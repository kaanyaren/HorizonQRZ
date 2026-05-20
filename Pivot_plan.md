# Log Summit — Pivot Implementation Plan

**From:** HorizonQRZ (QRZ.com client)
**To:** Log Summit (Multi-platform ham QSO logging app with Supabase sync)

---

## Architecture Overview

```
┌──────────────────────────────────────────────────────────────────┐
│                        Log Summit App                            │
│                                                                  │
│  Supabase PostgreSQL (SOURCE OF TRUTH)                           │
│       ↕ two-way sync                                              │
│  Drift/SQLite (local buffer for offline)                         │
│                                                                  │
│  ─── Separate async pipelines:                                   │
│       → Upload QSOs to QRZ.com (ADIF)                            │
│       → Upload QSOs to Club Log (ADIF)                           │
│       → Upload QSOs to eQSL.cc (ADIF)                            │
│       → Export contest ADIF for N1MM                              │
└──────────────────────────────────────────────────────────────────┘
```

**Key decisions:**
- Supabase PostgreSQL is the **source of truth** — all reads come from Supabase when online
- Drift/SQLite is a **local buffer** — enables offline QSO logging, syncs to Supabase when online
- Auth: **Google (Android)** / **Apple (iOS)** only (no email/password)
- No new VPS — share existing Supabase at `178.104.250.70` with a separate `log_summit` schema
- Upload to QRZ/Club Log/eQSL is **one-way push**, separate from Supabase sync
- ADIF export is **local file generation** — no server involvement

---

## Phase 0: Supabase Infrastructure (VPS)

### Step 0.1 — Add `log_summit` schema to existing PostgreSQL

**Target:** VPS `178.104.250.70`, existing Supabase PostgreSQL

Connect via SSH and create:

```sql
CREATE SCHEMA IF NOT EXISTS log_summit;

-- Profiles table (links Supabase Auth user to station info)
CREATE TABLE IF NOT EXISTS log_summit.profiles (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  callsign TEXT NOT NULL UNIQUE,
  station_gridsquare TEXT,
  default_band TEXT DEFAULT '20m',
  default_mode TEXT DEFAULT 'SSB',
  default_power TEXT DEFAULT '100',
  operator_name TEXT,
  cq_zone INT,
  itu_zone INT,
  state TEXT,
  country TEXT,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- QSOs table (the source of truth)
CREATE TABLE IF NOT EXISTS log_summit.qsos (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  callsign TEXT NOT NULL,
  qso_date DATE NOT NULL,
  time_on TIME NOT NULL,
  band TEXT NOT NULL,
  mode TEXT NOT NULL,
  freq TEXT,
  rst_sent TEXT,
  rst_rcvd TEXT,
  name TEXT,
  qth TEXT,
  country TEXT,
  gridsquare TEXT,
  lat TEXT,
  lon TEXT,
  comment TEXT,
  prop_mode TEXT,
  sat_name TEXT,
  tx_pwr TEXT,
  my_sig TEXT,
  sig TEXT,
  state TEXT,
  cq_zone TEXT,
  itu_zone TEXT,
  operator TEXT,
  station_callsign TEXT NOT NULL,
  station_gridsquare TEXT,
  -- Contest fields
  contest_id TEXT,
  stx TEXT,
  srx TEXT,
  stx_string TEXT,
  srx_string TEXT,
  -- Metadata
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  deleted_at TIMESTAMPTZ
);

-- Platform credentials (encrypted, per-user)
CREATE TABLE IF NOT EXISTS log_summit.platform_credentials (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  platform TEXT NOT NULL CHECK (platform IN ('qrz', 'clublog', 'eqsl')),
  encrypted_data TEXT NOT NULL,
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(user_id, platform)
);

-- Upload trackers (per-platform sync status per QSO)
CREATE TABLE IF NOT EXISTS log_summit.upload_trackers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  qso_id UUID NOT NULL REFERENCES log_summit.qsos(id) ON DELETE CASCADE,
  platform TEXT NOT NULL CHECK (platform IN ('qrz', 'clublog', 'eqsl')),
  remote_id TEXT,
  status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'synced', 'error')),
  error_message TEXT,
  last_attempt TIMESTAMPTZ,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW(),
  UNIQUE(qso_id, platform)
);
```

### Step 0.2 — Create Supabase Edge Function: `auth-on-create`

When a user signs up via Google/Apple, create their profile row:

```typescript
// supabase/functions/log-summit-auth-on-create/index.ts
import { serve } from "https://deno.land/std@0.168.0/http/server.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2"

serve(async (req) => {
  const { user } = await req.json()
  const supabase = createClient(
    Deno.env.get("SUPABASE_URL")!,
    Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!
  )

  const { error } = await supabase
    .schema("log_summit")
    .from("profiles")
    .insert({
      id: user.id,
      callsign: "",  // User must set this on first launch
    })

  return new Response(JSON.stringify({ error }), { status: error ? 500 : 200 })
})
```

### Step 0.3 — Set up RLS (Row Level Security)

All tables in `log_summit` schema:

```sql
-- Profiles: users can only read/update their own
ALTER TABLE log_summit.profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_profiles ON log_summit.profiles
  USING (id = auth.uid());

-- QSOs: users can CRUD their own
ALTER TABLE log_summit.qsos ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_qsos ON log_summit.qsos
  USING (user_id = auth.uid());

-- Platform credentials: users can CRUD their own
ALTER TABLE log_summit.platform_credentials ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_credentials ON log_summit.platform_credentials
  USING (user_id = auth.uid());

-- Upload trackers: users can CRUD their own (via QSO ownership)
ALTER TABLE log_summit.upload_trackers ENABLE ROW LEVEL SECURITY;
CREATE POLICY user_trackers ON log_summit.upload_trackers
  USING (qso_id IN (SELECT id FROM log_summit.qsos WHERE user_id = auth.uid()));
```

### Step 0.4 — Configure Supabase Auth providers

On the Supabase dashboard (or via API):
- **Android**: Enable Google provider, add SHA-1 fingerprint from keystore
- **iOS**: Enable Apple provider, configure Service ID from Apple Developer portal

### Step 0.5 — Expose `log_summit` schema via API

In Supabase dashboard → API Settings → Add schemas: `log_summit`

This makes `log_summit.qsos`, `log_summit.profiles` etc. accessible through the standard `/rest/v1/` endpoint with the `Accept-Profile: log_summit` header.

---

## Phase 1: Rebrand from HorizonQRZ to Log Summit

### Step 1.1 — Update `pubspec.yaml`

```yaml
name: log_summit
description: "Ham QSO logging app with multi-platform upload & contest ADIF export"
version: 1.0.0+1
```

### Step 1.2 — Android branding files

| File | Change |
|---|---|
| `android/app/src/main/AndroidManifest.xml` | `android:label="Log Summit"` |
| `android/app/build.gradle` | `applicationId "com.logsummit.app"` or keep existing |
| Launcher icon | Replace with Log Summit icon |
| Splash screen | Replace with Log Summit splash |

### Step 1.3 — iOS branding files

| File | Change |
|---|---|
| `ios/Runner/Info.plist` | `CFBundleDisplayName` → "Log Summit" |
| `ios/Runner/Info.plist` | `CFBundleName` → "Log Summit" |
| iOS App Icon | Replace with Log Summit icon |

### Step 1.4 — Update `lib/main.dart`

- Change `HorizonQRZApp` → `LogSummitApp`
- Change `AuthWrapper` to use Supabase auth session check instead of local DB settings check
- Update `title: 'Log Summit'`
- Remove `ParticleNetwork` background (or keep if desired)
- Remove Google Ads initialization (unless you want to keep ads)
- Remove `MobileAds.instance.initialize()`

### Step 1.5 — Update `lib/ui/theme.dart`

Replace all HorizonQRZ references. `AppTheme` class name stays but update if desired.

### Step 1.6 — Service-level branding

- `QrzXmlService`: Update `agent` from `'HorizonQRZ-v1.0'` to `'LogSummit-v1.0'`
- `QrzLogbookService`: Update `User-Agent` from `'HorizonQRZ/1.0'` to `'LogSummit/1.0'`
- `lib/services/ad_helper.dart`: Remove or rename file (Google Ads may be removed)

### Step 1.7 — UI text replacements

Search and replace throughout `lib/ui/screens/`:
- `'HorizonQRZ'` → `'Log Summit'`
- `'your QRZ.com client'` → `'Log Summit'`
- Update login screen to show "Log Summit" instead of QRZ branded text
- Update settings screen branding text
- Remove the "Database Schema v4" outdated label (replace with real version)

### Step 1.8 — Remove hardcoded test credentials

`lib/ui/screens/login_screen.dart:19-21` — remove:
```dart
final _usernameController = TextEditingController(text: 'ta1kyn');
final _passwordController = TextEditingController(text: 'gurcan');
final _apiKeyController = TextEditingController(text: '4641-A08E-BE39-4503');
```

Replace with empty controllers.

### Step 1.9 — Launcher icons & splash

Regenerate with Log Summit branding:
```bash
# After replacing images
flutter pub run flutter_launcher_icons
flutter pub run flutter_native_splash:create
```

---

## Phase 2: Add Supabase Dependencies & Core Client

### Step 2.1 — Update `pubspec.yaml` dependencies

Add:
```yaml
supabase_flutter: ^2.8.0
```

Remove (if ads removed):
```yaml
# google_mobile_ads: ^5.3.0  # Remove if not keeping ads
```

### Step 2.2 — Create `lib/services/supabase_service.dart`

Singleton Supabase client:

```dart
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: 'https://your-project.supabase.co',  // Will proxy through VPS
      anonKey: 'your-anon-key',
    );
  }

  static SupabaseClient get client => Supabase.instance.client;

  // Helper to access log_summit schema
  static PostgrestQueryBuilder get qsos =>
      client.schema('log_summit').from('qsos');
  static PostgrestQueryBuilder get profiles =>
      client.schema('log_summit').from('profiles');
  static PostgrestQueryBuilder get platformCredentials =>
      client.schema('log_summit').from('platform_credentials');
  static PostgrestQueryBuilder get uploadTrackers =>
      client.schema('log_summit').from('upload_trackers');
}
```

**Self-hosted Supabase note:** Since your Supabase is self-hosted at `178.104.250.70`, the URL will be your VPS IP/domain, and the anon key comes from your Supabase config.

### Step 2.3 — Create `lib/services/auth_service.dart`

```dart
class AuthService {
  // Sign in with Google (Android)
  static Future<AuthResponse> signInWithGoogle() async {
    return await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.google,
      redirectUrl: 'com.logsummit.app://callback',
    );
  }

  // Sign in with Apple (iOS)
  static Future<AuthResponse> signInWithApple() async {
    return await Supabase.instance.client.auth.signInWithOAuth(
      OAuthProvider.apple,
      redirectUrl: 'com.logsummit.app://callback',
    );
  }

  // Sign out
  static Future<void> signOut() async {
    await Supabase.instance.client.auth.signOut();
  }

  // Get current session
  static Session? get currentSession =>
      Supabase.instance.client.auth.currentSession;
}
```

### Step 2.4 — Create `lib/providers/auth_provider.dart`

Replaces the old `authStateProvider`:

```dart
final supabaseServiceProvider = Provider<SupabaseService>((ref) => SupabaseService());
final supabaseClientProvider = Provider<SupabaseClient>((ref) => Supabase.instance.client);

enum AuthStatus { unauthenticated, authenticating, authenticated }

class AuthNotifier extends Notifier<AuthStatus> {
  @override
  AuthStatus build() {
    // Listen to auth state changes
    Supabase.instance.client.auth.onAuthStateChange.listen((data) {
      state = data.session != null ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    });
    return Supabase.instance.client.auth.currentSession != null
        ? AuthStatus.authenticated
        : AuthStatus.unauthenticated;
  }

  Future<void> signInWithGoogle() async { ... }
  Future<void> signInWithApple() async { ... }
  Future<void> signOut() async { ... }
}

final authProvider = NotifierProvider<AuthNotifier, AuthStatus>(AuthNotifier.new);
```

---

## Phase 3: Local Database Restructuring (Drift → Buffer)

### Step 3.1 — Drift schema v9

The local DB is now a **buffer/cache**, not source of truth. Restructure:

```dart
class LocalQsos extends Table {
  TextColumn get id => text()();                 // UUID from Supabase
  TextColumn get callsign => text()();
  DateTimeColumn get qsoDate => dateTime()();
  TimeColumn get timeOn => time()();             // Separate time from date
  TextColumn get band => text()();
  TextColumn get mode => text()();
  TextColumn get freq => text().nullable()();
  TextColumn get rstSent => text().nullable()();
  TextColumn get rstRcvd => text().nullable()();
  TextColumn get name => text().nullable()();
  TextColumn get qth => text().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get gridsquare => text().nullable()();
  TextColumn get lat => text().nullable()();
  TextColumn get lon => text().nullable()();
  TextColumn get comment => text().nullable()();
  TextColumn get propMode => text().nullable()();
  TextColumn get satName => text().nullable()();
  TextColumn get txPwr => text().nullable()();
  TextColumn get mySig => text().nullable()();
  TextColumn get sig => text().nullable()();
  TextColumn get state => text().nullable()();
  TextColumn get cqz => text().nullable()();
  TextColumn get contestId => text().nullable()();
  TextColumn get stx => text().nullable()();
  TextColumn get srx => text().nullable()();
  TextColumn get stxString => text().nullable()();
  TextColumn get srxString => text().nullable()();
  TextColumn get stationCallsign => text()();
  TextColumn get stationGridsquare => text().nullable()();
  TextColumn get operator => text().nullable()();

  IntColumn get syncVersion => integer().withDefault(const Constant(0))(); // Monotonically increasing for sync
  TextColumn get syncStatus => text().withDefault(const Constant('synced'))(); // synced, pending_upload, pending_delete, conflict
  TextColumn get userUuid => text()();            // Supabase user UUID
  TextColumn get supabaseId => text()();           // Supabase record UUID
}
```

**New approach:**
- `syncStatus`: `synced` (in sync with Supabase), `pending_upload` (created offline, not yet pushed), `pending_delete` (deleted offline), `conflict` (both sides modified)
- `syncVersion`: incremented each time the record changes locally; Supabase stores `updated_at` timestamp for conflict detection

### Step 3.2 — Rewrite `SyncProvider` for Supabase sync

The old `sync_provider.dart` synced only to QRZ.com. The new one syncs **to Supabase** (the source of truth). Platform uploads (QRZ/Club Log/eQSL) are a separate pipeline.

**Sync logic:**

```
On app foreground / connectivity restored:
  1. PUSH: Read local QSOs with syncStatus = 'pending_upload'
     → Upsert to Supabase
     → Mark as 'synced' on success
  2. PULL: Fetch QSOs from Supabase updated since last sync timestamp
     → For each:
       - If not in local DB → insert
       - If in local DB with syncVersion < server version → update (server wins)
       - If in local DB with syncVersion > server version → keep local, re-push
  3. PUSH DELETES: Delete locally-deleted QSOs from Supabase
```

### Step 3.3 — Update `AppDatabase` schema version to 9

Add migration that:
- Renames existing `Qsos` table to a temp table
- Creates new `LocalQsos` table with UUID-based IDs and contest fields
- Migrates data from old table, generating UUIDs for `supabaseId` where `qrzLogid` exists, or generating new UUIDs for pending records
- Maps old `qrzLogid` → both `supabaseId` and `qrzLogid` (kept for reference)
- Removes old `Qsos` table
- Adds `SyncMeta` table for tracking last sync timestamp per direction

### Step 3.4 — Rework `AppSettings` table

Simplify — now only stores:
- Last band/mode/power (UX convenience)
- Station grid square
- Platform credentials (stored locally too, encrypted)

Credentials move to a separate encrypted storage via `flutter_secure_storage`.

---

## Phase 4: New Login / Auth Flow

### Step 4.1 — Rewrite `login_screen.dart`

Old login: QRZ username + password + API key form
New login: **Supabase Auth with social providers only**

**Android:**
- "Sign in with Google" button → `signInWithGoogle()`
- Uses `supabase_flutter` OAuth flow with Google One Tap / Chrome Custom Tab

**iOS:**
- "Sign in with Apple" button → `signInWithApple()`
- Uses ASWebAuthenticationSession

**Flow:**
1. User taps Google or Apple button
2. Supabase Auth opens browser/ASWebAuthenticationSession
3. User authenticates
4. On success, `auth-on-create` edge function fires (first time only) → creates profile row with empty callsign
5. App checks if profile has callsign → if empty, show "Set Your Callsign" dialog
6. On subsequent launches, `AuthWrapper` checks `Supabase.instance.client.auth.currentSession` → skip login

**Fallback:** If offline, show a message "Connect to the internet to sign in." (Supabase session is cached and works offline for up to 1 hour, but fresh sign-in requires network.)

### Step 4.2 — Create "Set Callsign" screen

Shown after first Supabase auth sign-up:
- Callsign text field (validated: 3-20 chars, alphanumeric + `/`)
- Station grid square (optional, with GPS auto-fill button)
- CQ Zone, ITU Zone (optional)
- Saves to `log_summit.profiles` via Supabase REST API
- Also saves to local `AppSettings` for offline use

### Step 4.3 — Update `AuthWrapper` in `main.dart`

```dart
class AuthWrapper extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStatus = ref.watch(authProvider);

    return authStatus.when(
      data: (status) {
        switch (status) {
          case AuthStatus.authenticated:
            // Check if callsign is set
            return FutureBuilder<Profile?>(
              future: _getProfile(),
              builder: (ctx, snap) {
                if (snap.data?.callsign.isEmpty ?? true) {
                  return const SetupProfileScreen();
                }
                return const HomeScreen();
              },
            );
          case AuthStatus.unauthenticated:
            return const LoginScreen();
          case AuthStatus.authenticating:
            return const Scaffold(body: Center(CircularProgressIndicator()));
        }
      },
      loading: () => const Scaffold(body: Center(CircularProgressIndicator())),
      error: (e, _) => LoginScreen(),
    );
  }
}
```

---

## Phase 5: ADIF Generation Engine

### Step 5.1 — Create `lib/utils/adif_generator.dart`

Full ADIF 3.1.x generator that handles all QSO fields and contest-specific tags.

**ADIF 3.1.x header:**
```
HorizonQRZ ADIF export<eoh>
```
Actually, update to:
```
Log Summit ADIF Export<eoh>
```

**Record format:**
```
<CALL:{len}>{callsign}
<QSO_DATE:8>{yyyymmdd}
<TIME_ON:6>{hhmmss}
<BAND:{len}>{band}
<MODE:{len}>{mode}
<FREQ:{len}>{freq}
<RST_SENT:{len}>{rstSent}
<RST_RCVD:{len}>{rstRcvd}
<NAME:{len}>{name}
<QTH:{len}>{qth}
<COUNTRY:{len}>{country}
<GRIDSQUARE:{len}>{gridsquare}
<CQZ:{len}>{cqz}
<STATE:{len}>{state}
<STATION_CALLSIGN:{len}>{stationCallsign}
<OPERATOR:{len}>{operator}
<STX:{len}>{stx}
<SRX:{len}>{srx}
<STX_STRING:{len}>{stxString}
<SRX_STRING:{len}>{srxString}
<CONTEST_ID:{len}>{contestId}
<EOR>
```

**Methods:**
```dart
class AdifGenerator {
  static String generateQso(Qso qso, AppSettings settings);
  static String generateFromQsos(List<Qso> qsos, AppSettings settings,
      {String? contestId});
  static String generateContestAdif(List<Qso> qsos, AppSettings settings,
      {required String contestId, String? stationCallsign});
}
```

### Step 5.2 — Contest-specific ADIF (N1MM-compatible)

N1MM export format adds these conventions:

```
<CONTEST_ID:8>CQ-WW-CW
<STX:3>001
<SRX:3>599
<STX_STRING:6>599 001
<SRX_STRING:6>599 003
<STATION_CALLSIGN:6>TA1KYN
<OPERATOR:6>TA1KYN
<APP_N1MM_EXCHANGE1:6>599 001
```

**Contest exchange formats:**

| Contest | Exchange | ADIF Fields |
|---|---|---|
| CQ WW DX CW/SSB/RTTY | RST + CQ Zone | `RST_SENT`, `CQZ`, `STX_STRING: "599 14"` |
| CQ WPX | RST + Serial | `RST_SENT`, `STX: "001"` |
| ARRL DX CW/SSB | RST + State/Prov | `RST_SENT`, `STATE`, `STX_STRING: "599 VA"` |
| ARRL Sweepstakes | Serial + Category + Check + Section | `STX: "001"`, `STX_STRING: "001 A 99 VA"` |
| ARRL Field Day | Class + Section | `STX_STRING: "1D VA"` |
| IARU HF | RST + ITU Zone | `RST_SENT`, `ITU_ZONE` |

Store these mappings in `lib/data/contest_definitions.dart`.

### Step 5.3 — Create `lib/data/contest_definitions.dart`

```dart
class ContestDefinition {
  final String id;        // e.g. "CQ-WW-CW"
  final String name;      // e.g. "CQ World Wide DX Contest (CW)"
  final String description;
  final List<String> requiredFields;  // e.g. ['RST_SENT', 'CQZ']
  final List<String> exchangeFields;  // e.g. ['RST', 'CQ_ZONE']
  final String exchangeHint;          // e.g. "RST + CQ Zone"
  final String? Function(Map<String, String> fields)? validateExchange;

  const ContestDefinition({...});
}

final contestDefinitions = <String, ContestDefinition>{
  'CQ-WW-CW': ContestDefinition(
    id: 'CQ-WW-CW',
    name: 'CQ World Wide DX Contest (CW)',
    exchangeFields: ['RST', 'CQ Zone'],
    exchangeHint: '599 [CQ Zone]',
  ),
  'CQ-WW-SSB': ContestDefinition(...),
  'CQ-WW-RTTY': ContestDefinition(...),
  'CQ-WPX-CW': ContestDefinition(...),
  'CQ-WPX-SSB': ContestDefinition(...),
  'ARRL-DX-CW': ContestDefinition(...),
  'ARRL-DX-SSB': ContestDefinition(...),
  'ARRL-SS-CW': ContestDefinition(...),
  'ARRL-SS-SSB': ContestDefinition(...),
  'ARRL-FIELD-DAY': ContestDefinition(...),
  'IARU-HF': ContestDefinition(...),
  'ALL-ASIAN-DX-CW': ContestDefinition(...),
  'ALL-ASIAN-DX-SSB': ContestDefinition(...),
  'CQ-160-CW': ContestDefinition(...),
  'CQ-160-SSB': ContestDefinition(...),
  'CQ-160-RTTY': ContestDefinition(...),
};
```

### Step 5.4 — Create `lib/services/adif_exporter.dart`

Handles file export and sharing:

```dart
class AdifExporter {
  /// Export a list of QSOs as an ADIF file and open the share sheet
  static Future<void> exportAndShare({
    required List<Qso> qsos,
    required AppSettings settings,
    String? contestId,
    String? stationCallsign,
  }) async {
    final adif = AdifGenerator.generateFromQsos(qsos, settings,
        contestId: contestId);

    // Write to temp file
    final dir = await getTemporaryDirectory();
    final filename = _generateFilename(stationCallsign ?? 'log', contestId);
    final file = File('${dir.path}/$filename.adi');
    await file.writeAsString(adif);

    // Share via system share sheet
    await Share.shareXFiles([XFile(file.path)], text: 'Log Summit ADIF Export');
  }

  static String _generateFilename(String callsign, String? contestId) {
    final date = DateTime.now().toUtc().toIso8601String().split('T')[0];
    final contest = contestId ?? 'ALL';
    return '${callsign}_${contest}_$date';
  }
}
```

### Step 5.5 — Keep existing ADIF parser

`lib/utils/adif_parser.dart` is fine as-is for incoming ADIF data (QRZ FETCH response). Keep it.

---

## Phase 6: Multi-Platform Upload Service

### Step 6.1 — Create abstract interface `lib/services/log_upload_service.dart`

```dart
abstract class LogUploadService {
  String get platformId;   // 'qrz', 'clublog', 'eqsl'
  String get platformName; // 'QRZ.com', 'Club Log', 'eQSL.cc'

  Future<bool> authenticate(Map<String, String> credentials);
  Future<bool> uploadQso(Qso qso, {Map<String, String>? credentials});
  Future<bool> uploadBatch(List<Qso> qsos, {Map<String, String>? credentials});
  Future<Map<String, dynamic>> getStatus({Map<String, String>? credentials});
}
```

### Step 6.2 — Refactor QRZ service to implement interface

Create `lib/services/qrz_upload_service.dart`:
- Wraps existing `QrzLogbookService` methods
- Implements `LogUploadService`
- Reuses the existing `insertQso()` with ADIF generation
- Reuses the existing `getStatus()` for QRZ dashboard stats

Keep `QrzLogbookService` and `QrzXmlService` as they are (they work fine) but add the interface wrapper.

### Step 6.3 — Create `lib/services/clublog_upload_service.dart`

Club Log API:
- **Login:** POST `https://clublog.org/api` with `action=login`, `call=<callsign>`, `password=<password>`. Gets back `session` cookie.
- **Upload:** POST same URL with `action=upload`, `call=<callsign>`, `file=<ADIF content>`.
- **Status:** GET `https://clublog.org/recent.php?call=<callsign>` (or use the API).

```dart
class ClubLogUploadService implements LogUploadService {
  @override
  String get platformId => 'clublog';
  @override
  String get platformName => 'Club Log';

  Future<bool> authenticate(Map<String, String> credentials) async { ... }
  Future<bool> uploadBatch(List<Qso> qsos, {Map<String, String>? credentials}) async { ... }
}
```

### Step 6.4 — Create `lib/services/eqsl_upload_service.dart`

eQSL.cc API:
- **Login:** POST `https://www.eqsl.cc/qslcard/IncomingADIF.cfm` with `UserName` and `Password` fields.
- **Upload:** POST same URL with `Action=Upload`, `ADIFData=<ADIF content>`.
- Response is an HTML page, parse for success/error.

```dart
class EqslUploadService implements LogUploadService {
  @override
  String get platformId => 'eqsl';
  @override
  String get platformName => 'eQSL.cc';

  Future<bool> authenticate(Map<String, String> credentials) async { ... }
  Future<bool> uploadBatch(List<Qso> qsos, {Map<String, String>? credentials}) async { ... }
}
```

### Step 6.5 — Create `lib/services/upload_orchestrator.dart`

Manages upload to all active platforms:

```dart
class UploadOrchestrator {
  final Map<String, LogUploadService> _services = {
    'qrz': QrzUploadService(),
    'clublog': ClubLogUploadService(),
    'eqsl': EqslUploadService(),
  };

  /// Upload a single QSO to all active platforms
  Future<Map<String, UploadResult>> uploadQsoToAll(Qso qso, PlatformCredentials creds) async { ... }

  /// Upload all pending QSOs to all active platforms
  Future<void> processUploadQueue() async { ... }

  /// Get per-platform status/summary
  Future<Map<String, Map<String, dynamic>>> getAllStatuses(PlatformCredentials creds) async { ... }
}
```

### Step 6.6 — Create `lib/providers/upload_provider.dart`

Riverpod provider for upload orchestration state:

```dart
enum UploadPhase { idle, uploading, completed, error }

class UploadState {
  final UploadPhase phase;
  final int current;    // current QSO being uploaded
  final int total;      // total QSOs to upload
  final Map<String, int> platformProgress; // { 'qrz': 5, 'clublog': 12, 'eqsl': 0 }
  final Map<String, String>? errors;       // { 'qrz': 'Auth failed' }
}

final uploadProvider = NotifierProvider<UploadNotifier, UploadState>(UploadNotifier.new);
```

---

## Phase 7: UI Screens Rewrites / Additions

### Step 7.1 — New `LoginScreen` (Merge with Setup Profile)

```
┌──────────────────────────┐
│                          │
│     [App Logo]           │
│     LOG SUMMIT           │
│     Log your QSOs        │
│                          │
│  ┌──────────────────────┐│
│  │  Sign in with Google ││  ← Android
│  └──────────────────────┘│
│  ┌──────────────────────┐│
│  │  Sign in with Apple  ││  ← iOS
│  └──────────────────────┘│
│                          │
│  No email/password       │
│  required                │
└──────────────────────────┘
```

After first auth → "Set up your Station" screen:
```
┌──────────────────────────┐
│  YOUR STATION            │
│                          │
│  [CALLSIGN   ] *required │
│  [Grid Square] optional  │
│  [CQ Zone    ] optional  │
│  [ITU Zone   ] optional  │
│                          │
│  ┌──────────────────────┐│
│  │  LET'S GO            ││
│  └──────────────────────┘│
└──────────────────────────┘
```

### Step 7.2 — New `PlatformsScreen` (formerly part of Settings)

Add a new tab or screen for managing upload platforms:

```
┌──────────────────────────┐
│  LOG UPLOAD              │
│                          │
│  ┌──────────────────────┐│
│  │  QRZ.com             ││  ← toggle active
│  │  Connected: TA1KYN   ││
│  │  Last sync: today    ││
│  └──────────────────────┘│
│  ┌──────────────────────┐│
│  │  Club Log            ││  ← toggle active
│  │  Not configured      ││
│  └──────────────────────┘│
│  ┌──────────────────────┐│
│  │  eQSL.cc             ││  ← toggle active
│  │  Not configured      ││
│  └──────────────────────┘│
│                          │
│  ┌──────────────────────┐│
│  │  SYNC ALL NOW        ││
│  └──────────────────────┘│
└──────────────────────────┘
```

Tapping a platform card opens credential configuration:
```
┌──────────────────────────┐
│  CLUB LOG SETTINGS       │
│                          │
│  Callsign: [TA1KYN   ]  │
│  Password: [********  ]  │
│                          │
│  ┌──────────────────────┐│
│  │  TEST & SAVE         ││
│  └──────────────────────┘│
└──────────────────────────┘
```

Credentials stored encrypted in `flutter_secure_storage` locally AND in `log_summit.platform_credentials` (encrypted) on Supabase.

### Step 7.3 — New `ExportScreen`

```
┌──────────────────────────┐
│  ADIF EXPORT             │
│                          │
│  CONTEST                 │
│  [CQ WW DX CW   ▼]      │
│                          │
│  DATE RANGE              │
│  [2026-01-01] to [today] │
│                          │
│  BAND FILTER             │
│  [All bands        ▼]   │
│                          │
│  MODE FILTER             │
│  [All modes        ▼]   │
│                          │
│  QSOs to export: 47      │
│                          │
│  ┌──────────────────────┐│
│  │  EXPORT & SHARE      ││
│  └──────────────────────┘│
│                          │
│  (Opens share sheet:     │
│   Email, AirDrop, Files, │
│   Google Drive, etc.)    │
└──────────────────────────┘
```

File named: `TA1KYN_CQ-WW-CW_2026-05-18.adi`

### Step 7.4 — Update `LoggerScreen` with Contest Mode

**Normal mode** (existing, with small improvements):
- Pre-fill station callsign from profile/settings
- Include `operator` and `stationCallsign` in the save
- Generate UUID for local `id` field on save
- On save: write to local DB with `syncStatus: 'pending_upload'`
- Also immediately push to Supabase if online

**Contest mode** (new toggle):
```
┌──────────────────────────┐
│  LOGGER — CONTEST MODE   │  ← toggle: Normal / Contest
│  [CQ WW DX CW       ▼]  │
│                          │
│  CALLSIGN: [TA1K   ]    │
│  Serial #: [047]auto-inc │
│   → Exchange: [599 14]   │
│                          │
│  ┌───┐ ┌───────────────┐│
│  │CLR│ │   LOG QSO     ││
│  └───┘ └───────────────┘│
│                          │
│  Last: TA1ABC 599 20     │
│        TA2XYZ 599 15     │
│        TA3PQR 599 07     │
└──────────────────────────┘
```

**Rapid-fire mode:**
- Auto-increment serial number after each log
- Auto-clear callsign field after log
- Keyboard stays open (no focus loss)
- Tab key moves to next field
- Recent QSO list at bottom for quick verification

### Step 7.5 — Update `LogbookScreen` with sync indicators

Add per-platform sync status icons on each QSO card:
```
TA1ABC   14.080 MHz  [20m] [FT8]
05/18/2026 14:30 UTC  1234 km
  QRZ ✓  CL ✓  eQSL ✗        ← per-platform icons
```

Filter/search options:
- By platform sync status (synced to all, pending, errors)
- By contest
- By date range
- By band/mode

### Step 7.6 — Update `DashboardScreen`

Replace QRZ-only status with:
- **Total QSO count** (from Supabase)
- **QSOS in last 7 days** (from local DB / Supabase)
- **Active platform connections** (QRZ, Club Log, eQSL)
- **Pending uploads** count (QSOs not yet uploaded to each platform)
- **Sync status** widget showing last sync time to Supabase + each platform
- **Quick actions**: New QSO, Export ADIF, Sync All
- Keep the latest QSOs table (from local DB)
- Keep the activity chart (now with real data from Supabase query)

### Step 7.7 — Update `SettingsScreen`

Old settings screen had QRZ credentials + station grid square.
New settings screen:

```
┌──────────────────────────┐
│  SETTINGS                │
│                          │
│  STATION                  │
│  Callsign: TA1KYN        │
│  Operator: Gurcan        │
│  Grid: KM60              │
│  CQ Zone: 20             │
│  ITU Zone: 39            │
│  Power: 100W             │
│                          │
│  DEFAULTS                 │
│  Band: 20m               │
│  Mode: SSB               │
│                          │
│  ACCOUNT                  │
│  [Sign Out]              │
│                          │
│  ABOUT                    │
│  Log Summit v1.0.0       │
└──────────────────────────┘
```

### Step 7.8 — Update `HomeScreen` (Navigation)

Old: 5 tabs — Home, Log, Logbook, Awards, Settings
New: 5 or 6 tabs — Home, Log, Logbook, **Export**, Platforms/Awards, Settings

Or keep the tab structure but add:
- Export accessible from Logbook screen (FAB or app bar action)
- Platforms accessible from Settings or dedicated tab
- Awards moved to a sub-section or kept as a tab

---

## Phase 8: Supabase ↔ Drift Sync Engine

### Step 8.1 — Create `lib/services/supabase_sync_service.dart`

The core sync engine. This is the most critical piece of the app.

```dart
class SupabaseSyncService {
  final AppDatabase _localDb;
  final SupabaseClient _client;

  /// Direction: Local → Supabase
  /// Push QSOs created/modified while offline
  Future<SyncResult> pushLocalChanges() async {
    // 1. Get all locally-modified QSOs (pending_upload)
    // 2. For each, upsert to Supabase
    // 3. On success, update local syncStatus to 'synced' and store supabaseId
    // 4. On conflict (server has newer updated_at), resolve with server winning
  }

  /// Direction: Supabase → Local
  /// Pull QSOs created/modified on other devices
  Future<SyncResult> pullRemoteChanges() async {
    // 1. Get last_sync_timestamp from SyncMeta table
    // 2. Fetch QSOs from Supabase with updated_at > last_sync_timestamp
    // 3. For each remote QSO:
    //    a. If not in local DB → insert
    //    b. If in local DB and remote.updated_at > local.syncVersion → update
    //    c. If in local DB and local is pending_upload → server wins (time-based)
    // 4. Update last_sync_timestamp
  }

  /// Full two-way sync (push then pull)
  Future<SyncResult> syncAll() async {
    await _ensureAuthenticated();
    final pushResult = await pushLocalChanges();
    final pullResult = await pullRemoteChanges();
    return SyncResult(pushResult, pullResult);
  }
}
```

**Conflict resolution strategy:**
- Simple last-write-wins based on `updated_at` timestamps
- If local is `pending_upload` and server has a newer `updated_at` → **user is alerted**, both versions kept, user picks one
- If local is `pending_upload` and server has no record → push wins (it's a new QSO)
- If local is `pending_upload` and server has same `updated_at` → push wins (same version, just duplicate)

### Step 8.2 — Create `lib/providers/sync_state_provider.dart`

```dart
enum AppSyncPhase { idle, pushing, pulling, syncing, completed, error }

class AppSyncState {
  final AppSyncPhase phase;
  final int localChanges;     // # QSOs to push
  final int remoteChanges;    // # QSOs pulled
  final DateTime? lastSyncTime;
  final String? error;
}

final appSyncProvider = NotifierProvider<AppSyncNotifier, AppSyncState>(AppSyncNotifier.new);
```

### Step 8.3 — Wire sync triggers

Sync is triggered by:
1. **App foreground** — `AppLifecycleListener` detects `resumed`, triggers `syncAll()`
2. **Connectivity restored** — `connectivity_plus` listener triggers `syncAll()`
3. **Pull-to-refresh** — on Dashboard and Logbook screens
4. **After QSO save** — immediate push of that single QSO (optimistic)
5. **Periodic** — every 5 minutes while app is in foreground

---

## Phase 9: Contest Mode & N1MM Export

### Step 9.1 — Contest data definitions

`lib/data/contest_definitions.dart` (see Phase 5.3 above).

### Step 9.2 — Contest Logger UI

Updates to `logger_screen.dart`:

Add at top of form:
- Toggle: `Normal Mode` / `Contest Mode`
- When Contest Mode: contest selector dropdown

When contest is selected:
- Pre-fill `CONTEST_ID` on QSO records
- Show contest-specific exchange fields
- Auto-increment `STX` (sent serial number)
- `SRX` and `SRX_STRING` fields for received exchange
- Validation against contest rules (e.g., CQ WW needs valid CQ zone 1-40)

### Step 9.3 — N1MM ADIF export

`lib/utils/adif_generator.dart` method `generateContestAdif()` produces N1MM-compatible output:

```
Log Summit ADIF Export<eoh>
<CONTEST_ID:8>CQ-WW-CW
<CALL:6>TA1KYN
<STATION_CALLSIGN:6>TA1KYN
<OPERATOR:6>TA1KYN
<QSO_DATE:8>20260518
<TIME_ON:6>143000<CALL:6>TA1ABC<BAND:3>20m<MODE:2>CW<RST_SENT:3>599<RST_RCVD:3>599<STX:3>001<SRX:3>015<STX_STRING:6>599 001<SRX_STRING:6>599 015<CQZ:2>20<EOR>
```

### Step 9.4 — Export screen with filters

`lib/ui/screens/export_screen.dart`:
- Contest selector (optional — exports ALL if none selected)
- Date range picker
- Band/mode multi-select filter
- Preview: "47 QSOs will be exported"
- "Export & Share" button → calls `AdifExporter.exportAndShare()`

---

## Phase 10: Polish & Cleanup

### Step 10.1 — Remove deprecated code

| File | Action |
|---|---|
| `lib/services/ad_helper.dart` | Remove (Google Ads) |
| `lib/services/qrz_logbook_service.dart` | Keep but wrap in interface |
| `lib/services/qrz_xml_service.dart` | Keep (needed for callsign lookup + awards) |
| `lib/providers/sync_provider.dart` | Rewrite to `sync_state_provider.dart` |
| Hardcoded credentials in login | Remove |
| Debug `print()` statements | Remove throughout |

### Step 10.2 — Fix outstanding issues

| Issue | Fix |
|---|---|
| Outdated "Database Schema v4" label | Update to actual version or remove |
| Fake activity chart data | Replace with real queries from local DB |
| Logger doesn't include station fields | Populate from profile/settings on save |
| Awards provider is expensive | Cache QRZ XML awards, paginate callsign lookups |
| Awards screen might not make sense | Keep if useful, or move to sub-section |

### Step 10.3 — Run build_runner

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### Step 10.4 — Verify compilation

```bash
flutter analyze
```

### Step 10.5 — Build for testing

```bash
flutter build apk --debug
flutter build ios --debug --no-codesign
```

---

## File Change Summary (New + Modified)

### New files to create

| Path | Purpose |
|---|---|
| `lib/services/supabase_service.dart` | Supabase client singleton |
| `lib/services/auth_service.dart` | Google/Apple auth methods |
| `lib/services/supabase_sync_service.dart` | Two-way sync engine |
| `lib/services/log_upload_service.dart` | Abstract upload interface |
| `lib/services/qrz_upload_service.dart` | QRZ upload (wraps existing) |
| `lib/services/clublog_upload_service.dart` | Club Log upload |
| `lib/services/eqsl_upload_service.dart` | eQSL.cc upload |
| `lib/services/upload_orchestrator.dart` | Multi-platform upload manager |
| `lib/services/adif_exporter.dart` | ADIF file export + share |
| `lib/utils/adif_generator.dart` | Full ADIF 3.1.x generator |
| `lib/data/contest_definitions.dart` | Contest definitions |
| `lib/providers/auth_provider.dart` | Supabase auth state |
| `lib/providers/sync_state_provider.dart` | Sync state (replaces old sync_provider) |
| `lib/providers/upload_provider.dart` | Upload orchestration state |
| `lib/ui/screens/platforms_screen.dart` | Platform management UI |
| `lib/ui/screens/export_screen.dart` | ADIF export + filters |
| `lib/ui/screens/setup_profile_screen.dart` | First-launch callsign setup |

### Files to modify extensively

| Path | Changes |
|---|---|
| `pubspec.yaml` | Rebrand, add supabase_flutter, remove ads |
| `lib/main.dart` | Supabase init, new AuthWrapper, remove ads init |
| `lib/database/app_database.dart` | Schema v9: UUID-based IDs, contest fields, buffer model |
| `lib/providers/app_providers.dart` | Add supabase providers, remove old auth |
| `lib/ui/theme.dart` | Rebrand text references |
| `lib/ui/screens/login_screen.dart` | Full rewrite: Google/Apple auth |
| `lib/ui/screens/logger_screen.dart` | Contest mode, station fields, UUID generation |
| `lib/ui/screens/logbook_screen.dart` | Sync status icons, filter by platform |
| `lib/ui/screens/dashboard_screen.dart` | Multi-platform status, real activity data |
| `lib/ui/screens/settings_screen.dart` | Station info, platform creds, sign out |
| `lib/ui/screens/home_screen.dart` | Updated tab navigation |
| `lib/services/qrz_xml_service.dart` | Update User-Agent |
| `lib/services/qrz_logbook_service.dart` | Update User-Agent |

### Files to keep as-is

| Path | Reason |
|---|---|
| `lib/utils/adif_parser.dart` | Still needed for incoming ADIF parsing |
| `lib/utils/distance.dart` | Grid/lat/lon/haversine — no changes needed |
| `lib/ui/screens/qso_detail_screen.dart` | Still works, just needs to load from supabaseId |
| `lib/ui/screens/awards_screen.dart` | Still works with QRZ XML API |
| `lib/ui/screens/lookup_screen.dart` | Still works with QRZ XML API |
| `lib/ui/widgets/instrument_card.dart` | Reusable, no changes needed |
| `lib/ui/widgets/banner_ad_widget.dart` | Delete if removing ads, keep if staying |
| `lib/ui/screens/sync_log_screen.dart` | Keep for debug, update to show Supabase sync logs |

---

## Architecture Decision Records

### ADR-1: Supabase as source of truth
- All QSO data lives in `log_summit.qsos` on the self-hosted Supabase PostgreSQL
- `Drift/SQLite` is a local cache for offline operation
- Rationale: Multi-device sync, cloud backup, future web dashboard

### ADR-2: Google (Android) / Apple (iOS) only auth
- No email/password flow
- Rationale: Simpler UX, no password management, native OS trust

### ADR-3: Separate sync & upload pipelines
- Supabase sync: bidirectional, keeps local DB in sync with cloud source of truth
- Platform upload: unidirectional push to QRZ/Club Log/eQSL
- Rationale: Different reliability requirements — losing Supabase sync is critical, losing a platform upload is retryable

### ADR-4: Platform credentials encrypted at rest
- Stored in `flutter_secure_storage` locally AND in `log_summit.platform_credentials` on Supabase
- Encrypted with user's device keychain before sending
- Rationale: QRZ/Club Log/eQSL credentials are sensitive and must be protected

### ADR-5: ADIF generation is local-only
- ADIF files are generated on-device and shared via OS share sheet
- No server involvement
- Rationale: ADIF is a standard interchange format; user chooses where to send it
