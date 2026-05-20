-- Log Summit Supabase Schema
-- Run this on VPS: 178.104.250.70
-- Schema: log_summit

-- Create schema
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
  contest_id TEXT,
  stx TEXT,
  srx TEXT,
  stx_string TEXT,
  srx_string TEXT,
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
