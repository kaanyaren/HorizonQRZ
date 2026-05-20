# Row Level Security (RLS) Policies for Log Summit

## Overview
All tables in the `log_summit` schema have Row Level Security enabled to ensure users can only access their own data.

## Enabling RLS

Run these commands on your Supabase PostgreSQL instance:

```sql
-- Enable RLS on all log_summit tables
ALTER TABLE log_summit.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_summit.qsos ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_summit.platform_credentials ENABLE ROW LEVEL SECURITY;
ALTER TABLE log_summit.upload_trackers ENABLE ROW LEVEL SECURITY;
```

## Policies

### Profiles Table
Users can only read/update their own profile.

```sql
CREATE POLICY user_profiles ON log_summit.profiles
  USING (id = auth.uid())
  WITH CHECK (id = auth.uid());
```

### QSOs Table
Users can CREATE, READ, UPDATE, DELETE only their own QSOs.

```sql
CREATE POLICY user_qsos ON log_summit.qsos
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());
```

### Platform Credentials Table
Users can CRUD only their own platform credentials.

```sql
CREATE POLICY user_credentials ON log_summit.platform_credentials
  USING (user_id = auth.uid())
  WITH CHECK (user_id = auth.uid());
```

### Upload Trackers Table
Users can CRUD upload trackers for their own QSOs.

```sql
CREATE POLICY user_trackers ON log_summit.upload_trackers
  USING (
    qso_id IN (
      SELECT id FROM log_summit.qsos WHERE user_id = auth.uid()
    )
  )
  WITH CHECK (
    qso_id IN (
      SELECT id FROM log_summit.qsos WHERE user_id = auth.uid()
    )
  );
```

## auth-on-create Function

The `log-summit-auth-on-create` function is automatically triggered when a new user signs up via Google or Apple.

**Environment Variables Required:**
- `SUPABASE_URL` - Your Supabase project URL
- `SUPABASE_SERVICE_ROLE_KEY` - Your service role key (found in Supabase dashboard → Settings → API)

**Deployment:**
1. Push the function code to your Supabase repository
2. Deploy via Supabase CLI:
   ```bash
   supabase functions deploy log-summit-auth-on-create
   ```

## Testing RLS

After setting up RLS, test with these queries:

```sql
-- As user A
\c postgres
SELECT * FROM log_summit.profiles WHERE id = auth.uid();
SELECT * FROM log_summit.qsos WHERE user_id = auth.uid();

-- As user B (should see nothing for user B's data)
\c postgres
SELECT * FROM log_summit.profiles WHERE id = auth.uid();
-- This should return 0 rows if user B is trying to access user A's data
```

## Troubleshooting

If RLS is blocking queries:
1. Temporarily disable RLS for testing:
   ```sql
   ALTER TABLE log_summit.profiles DISABLE ROW LEVEL SECURITY;
   ALTER TABLE log_summit.qsos DISABLE ROW LEVEL SECURITY;
   ```
2. Add debugging queries to your logs
3. Re-enable RLS when done
