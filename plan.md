# QRZ.com Logbook Client - Implementation Plan

## 1. Project Overview
A cross-platform mobile application (iOS/Android) built with Flutter to manage QRZ.com Logbooks. The app focuses on real-time logging, offline-first data management, and comprehensive award tracking using official QRZ.com APIs.

## 2. Tech Stack
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (for clean, reactive architecture)
- **Local Database:** Drift (SQLite wrapper for type-safe persistence)
- **Networking:** Dio (HTTP client with interceptors for auth/logging)
- **API Formats:** XML (Callbook API) and ADIF/Name-Value pairs (Logbook API)
- **Architecture:** Layered Architecture (Data -> Domain -> Presentation)

## 3. API Architecture

### 3.1 QRZ XML Callbook API (Lookup)
- **Purpose:** Callsign lookups (Bio, Photo, Address).
- **Authentication:** `https://xmldata.qrz.com/xml/current/`
    - Request: `?username=...;password=...;agent=...`
    - Response: `<SessionKey>` (Cached for 24 hours).
- **Lookup:** `?s=<SessionKey>;callsign=<Call>`

### 3.2 QRZ Logbook REST API (Management)
- **Purpose:** Logging QSOs, fetching logbook status, and award metadata.
- **Endpoint:** `https://logbook.qrz.com/api`
- **Auth:** Static `KEY` (Logbook API Key) provided by the user.
- **Actions:**
    - `STATUS`: Get summary counts (QSO, DXCC, etc.).
    - `INSERT`: Upload new QSO in ADIF format.
    - `FETCH`: Retrieve specific log records.
    - `EXTRACT`: Export full log for offline sync/local analysis.

## 4. Database Schema (Drift/SQLite)

### `logbook_records`
- `id` (Local ID)
- `qrz_logid` (Remote ID from QRZ)
- `callsign`
- `qso_date`
- `time_on`
- `band`
- `mode`
- `rst_sent`
- `rst_rcvd`
- `sync_status` (pending, synced, error)
- `raw_adif` (Complete ADIF record)

### `app_settings`
- `qrz_username`
- `qrz_password` (Securely stored)
- `logbook_api_key`
- `last_sync_timestamp`

## 5. Implementation Roadmap

### Phase 1: Foundation (Current)
- [ ] Initialize Flutter project.
- [ ] Configure `pubspec.yaml` with all dependencies.
- [ ] Set up folder structure.
- [ ] Initialize Drift database schema.

### Phase 2: Core Services
- [ ] Implement `QrzXmlService` for Session & Lookup.
- [ ] Implement `QrzLogbookService` for REST actions.
- [ ] Implement `SyncService` for background upload of pending QSOs.

### Phase 3: UI Development
- [ ] **Auth/Settings:** Screen to input credentials and validate API access.
- [ ] **Dashboard:** Display `STATUS` metrics (Awards progress cards).
- [ ] **Logger:** Responsive form with real-time callsign lookup integration.
- [ ] **Logbook View:** Searchable/Filterable list of local and remote QSOs.

### Phase 4: Offline & Sync
- [ ] Connectivity interceptor for Dio.
- [ ] Background worker (WorkManager) for periodic sync.
- [ ] Conflict resolution strategy (Remote takes precedence).

### Phase 5: Awards & Analytics
- [ ] Parse `EXTRACT` data for detailed award tracking (WAS states, DXCC entities).
- [ ] Visual charts for band/mode distribution.

## 6. Constraints & Safety
- **No Scraping:** Strictly use official APIs to protect user accounts.
- **Data Privacy:** Passwords must be stored using `flutter_secure_storage`.
- **API Limits:** Implement exponential backoff for failed sync attempts to respect QRZ rate limits.
