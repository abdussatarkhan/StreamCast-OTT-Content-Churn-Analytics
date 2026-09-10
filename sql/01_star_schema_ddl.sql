-- ============================================================================
-- StreamCast: Global SVOD Streaming Platform Content & Churn Analytics
-- Star Schema DDL (PostgreSQL 16 Enterprise Spec)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS streamcast_dw;
SET search_path TO streamcast_dw, public;

-- Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_name VARCHAR(12) NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_subscribers (
    subscribers_key SERIAL PRIMARY KEY,
    subscribers_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_titles_catalog (
    titles_catalog_key SERIAL PRIMARY KEY,
    titles_catalog_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_devices_ott (
    devices_ott_key SERIAL PRIMARY KEY,
    devices_ott_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_plans_sub (
    plans_sub_key SERIAL PRIMARY KEY,
    plans_sub_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_playback_sessions (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_qoe_telemetry (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_subscription_events (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_content_interactions (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

