# Log Summit — Supabase Setup Instructions

## Target VPS: 178.104.250.70

This guide walks through setting up the Supabase infrastructure for Log Summit.

---

## Step 1: Create the Schema

Connect to your Supabase PostgreSQL instance via SSH:

```bash
ssh root@178.104.250.70
```

Then run the schema file:

```bash
psql -U postgres -d postgres -f /Users/kaanyaren/Documents/GitHub/HorizonQRZ/supabase/schema_v1.sql
```

This creates:
- `log_summit.profiles` - Links auth users to station info
- `log_summit.qsos` - The source of truth for all QSOs
- `log_summit.platform_credentials` - Encrypted credentials per platform
- `log_summit.upload_trackers` - Tracks upload status per QSO/platform

**Verify the schema was created:**

```sql
\dt log_summit.*
```

---

## Step 2: Enable Row Level Security (RLS)

Run the RLS policies:

```bash
psql -U postgres -d postgres -f /Users/kaanyaren/Documents/GitHub/HorizonQRZ/supabase/rls_policies.sql
```

Or manually execute the SQL from `rls_policies.md` in this document.

---

## Step 3: Deploy the auth-on-create Function

### 3.1 Create a Supabase Function Repository

```bash
mkdir supabase-functions
cd supabase-functions
git init
git add .
git commit -m "Add auth-on-create function"
```

### 3.2 Deploy to Supabase

```bash
supabase login
supabase init functions
supabase functions deploy log-summit-auth-on-create
```

### 3.3 Configure Environment Variables

1. Go to Supabase Dashboard → Project Settings → Functions
2. Add environment variables:
   - `SUPABASE_URL` — Your project URL (e.g., `https://xxxxx.supabase.co`)
   - `SUPABASE_SERVICE_ROLE_KEY` — Service role key (Settings → API → Service Role)

---

## Step 4: Configure Supabase Auth Providers

### Google (Android)

1. Supabase Dashboard → Authentication → Providers → Google
2. Enable Google provider
3. Add SHA-1 fingerprint from your Android keystore

### Apple (iOS)

1. Supabase Dashboard → Authentication → Providers → Apple
2. Enable Apple provider
3. Get Service ID from Apple Developer Portal

---

## Step 5: Expose Schema via API

Supabase automatically exposes all schemas. The `log_summit` schema will be accessible via:

```
https://your-project.supabase.co/rest/v1?q=SELECT+*+FROM+log_summit.qsos
```

Or with custom header:
```
Accept-Profile: log_summit
```

---

## Step 6: Get Your Connection Strings

1. Supabase Dashboard → Project Settings → API
2. Copy:
   - **URL**: `https://your-project.supabase.co`
   - **anon public key**: For public access
   - **service role key**: For your app's backend functions

---

## Troubleshooting

### RLS is blocking queries

```sql
-- Temporarily disable to test
ALTER TABLE log_summit.profiles DISABLE ROW LEVEL SECURITY;
ALTER TABLE log_summit.qsos DISABLE ROW LEVEL SECURITY;

-- Re-enable when done
ALTER TABLE log_summit.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_summit.qsos ENABLE ROW LEVEL SECURITY;
```

### Function not being called

Check:
1. Function is deployed: `supabase functions list`
2. Function has correct permissions
3. Auth is working: Check Supabase Dashboard → Authentication → Users

### Schema not accessible

Verify:
1. Schema exists: `\dt log_summit.*`
2. RLS is enabled on all tables
3. Functions have correct permissions
