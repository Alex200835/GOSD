CREATE TABLE IF NOT EXISTS stage_types (
    id   SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS instances (
    id   SERIAL PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS plans (
    id                   SERIAL PRIMARY KEY,
    number               VARCHAR(50) UNIQUE NOT NULL,
    title                TEXT NOT NULL,
    initiator            TEXT,
    introduction_date    DATE,
    status               TEXT,
    responsible_committee TEXT,
    passport_extra       JSONB DEFAULT '{}'::jsonb,
    source_url           TEXT,
    created_at           TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at           TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS plans_stages (
    id            SERIAL PRIMARY KEY,
    plan_id       INTEGER NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
    stage_type_id INTEGER REFERENCES stage_types(id),
    instance_id   INTEGER REFERENCES instances(id),
    stage_date    DATE,
    result        TEXT,
    created_at    TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_plans_stages_plan_id    ON plans_stages (plan_id);
CREATE INDEX IF NOT EXISTS idx_plans_stages_stage_date ON plans_stages (stage_date);
CREATE INDEX IF NOT EXISTS idx_plans_updated_at       ON plans (updated_at);