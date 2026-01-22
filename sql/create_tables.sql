-- YrkesCo

CREATE TABLE (
    facility_id SERIAL PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(300) NOT NULL,
    phone VARCHAR(20)
);

-- Konsult

CREATE TABLE consultant_company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    org_number VARCHAR(12) UNIQUE NOT NULL,
    has_f_skatt BOOLEAN DEFAULT TRUE,
    adress VARCHAR(300),
    email VARCHAR(300),