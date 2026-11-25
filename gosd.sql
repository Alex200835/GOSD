-- Справочник стадий рассмотрения
CREATE TABLE IF NOT EXISTS stage_types (
    id	    SERIAL PRIMARY KEY,
    name    TEXT UNIQUE NOT NULL
);

-- Справочник тех инстанций у кого находится рассмотрение законопроекта (ГосДума, Совет Федерации, и т.д)
CREATE TABLE IF NOT EXISTS instances (
    id	    SERIAL PRIMARY KEY,
    name	TEXT UNIQUE NOT NULL
);

-- Паспорт законопроекта 
CREATE TABLE IF NOT EXISTS plans (
    id			            SERIAL PRIMARY KEY,
    number			        VARCHAR(50) UNIQUE NOT NULL,
    title			        TEXT NOT NULL,
    initiator			    TEXT,
    status			        TEXT,
    responsible_committee	TEXT,
    passport_extra		    JSONB DEFAULT '{}'::jsonb,
    source_url		        TEXT
);

-- Фактические этапы рассмотрения
CREATE TABLE IF NOT EXISTS plan_stages (
    id		        SERIAL PRIMARY KEY,
    plan_id		    INTEGER NOT NULL REFERENCES plans(id) ON DELETE CASCADE,
    stage_type_id	INTEGER REFERENCES stage_types(id), -- Связь переменной с таблицей стадий рассмотрения
    instance_id	    INTEGER REFERENCES instances(id), -- Связь переменной с таблицей инстанций
    result        	TEXT
);
