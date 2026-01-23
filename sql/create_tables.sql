-- YrkesCo

CREATE TABLE (
    facility_id SERIAL PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(300) NOT NULL,
    phone VARCHAR(20)
);

-- Konsultföretag

CREATE TABLE consultant_company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    org_number VARCHAR(12) UNIQUE NOT NULL,
    has_f_skatt BOOLEAN DEFAULT TRUE,
    adress VARCHAR(300),
    email VARCHAR(300)
);

-- Person
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    person_type VARCHAR(50) NOT NULL CHECK (person_type IN ('student','educator','education_leader', 'consultant')),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL
);

-- Person Detaljer
CREATE TABLE person_details (
    person_detail_id SERIAL PRIMARY KEY,
    person_id INTEGER UNIQUE NOT NULL REFERENCES person(person_id) ON DELETE CASCADE, -- DELETE CASCADE to remove details when a person is for example deleted, which was brought up to my attention by a peer/classmate
    personal_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
);

-- Program
CREATE TABLE program (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    program_code VARCHAR(10) NOT NULL UNIQUE,
    total_credits INTEGER NOT NULL
);

-- KURS
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INTEGER NOT NULL,
    description TEXT,
    is_standalone BOOLEAN DEFAULT FALSE
);

-- Utbildningsledare