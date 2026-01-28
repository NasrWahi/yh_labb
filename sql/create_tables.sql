-- YrkesCo (Anläggningar)
CREATE TABLE facility (
    facility_id SERIAL PRIMARY KEY,
    facility_code VARCHAR(15) UNIQUE NOT NULL,
    facility_name VARCHAR(200) NOT NULL,
    city VARCHAR(100) NOT NULL,
    address VARCHAR(300) NOT NULL,
    postal_code VARCHAR(10),
    phone VARCHAR(20)
);

-- Konsultföretag
CREATE TABLE consultant_company (
    company_id SERIAL PRIMARY KEY,
    company_name VARCHAR(200) NOT NULL,
    org_number VARCHAR(12) UNIQUE NOT NULL,
    has_f_skatt BOOLEAN DEFAULT TRUE,
    address VARCHAR(300),
    email VARCHAR(300),
    phone VARCHAR(20)
);

-- Person
CREATE TABLE person (
    person_id SERIAL PRIMARY KEY,
    person_type VARCHAR(50) NOT NULL CHECK (person_type IN ('student','educator','education_leader', 'consultant')),
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE
);

-- Program
CREATE TABLE program (
    program_id SERIAL PRIMARY KEY,
    program_name VARCHAR(100) NOT NULL,
    program_code VARCHAR(10) NOT NULL UNIQUE,
    total_credits INTEGER NOT NULL,
    duration_weeks INTEGER,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE
);

-- KURS
CREATE TABLE course (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(200) NOT NULL,
    course_code VARCHAR(20) NOT NULL UNIQUE,
    credits INTEGER NOT NULL,
    description TEXT,
    is_standalone BOOLEAN DEFAULT FALSE,
    difficulty_level VARCHAR(20) DEFAULT 'basic',
    is_active BOOLEAN DEFAULT TRUE
);

-- Person Detaljer
CREATE TABLE person_details (
    person_detail_id SERIAL PRIMARY KEY,
    person_id INTEGER UNIQUE NOT NULL REFERENCES person(person_id) ON DELETE CASCADE, -- DELETE CASCADE to remove details when a person is for example deleted, which was brought up to my attention by a peer/classmate
    personal_number VARCHAR(15) UNIQUE NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL
);

-- Utbildningsledare
CREATE TABLE education_leader (
    leader_id INTEGER PRIMARY KEY REFERENCES person(person_id) ON DELETE CASCADE,
    employee_number VARCHAR(25) UNIQUE NOT NULL,
    department VARCHAR(100)
);

-- Klass
CREATE TABLE class (
    class_id SERIAL PRIMARY KEY,
    program_id INTEGER NOT NULL REFERENCES program(program_id),
    leader_id INTEGER NOT NULL REFERENCES education_leader(leader_id),
    facility_id INTEGER NOT NULL REFERENCES facility(facility_id),
    class_name VARCHAR(50) NOT NULL,
    class_code VARCHAR(50) UNIQUE NOT NULL,
    iteration INTEGER NOT NULL CHECK (iteration BETWEEN 1 AND 3),
    start_date DATE,
    end_date DATE,
    max_students INTEGER DEFAULT 30,
    status VARCHAR(20) DEFAULT 'planned',
    UNIQUE (program_id, iteration, class_code)
);

-- Utbildare - Lärare - Pedagog
CREATE TABLE educator (
    educator_id INTEGER PRIMARY KEY REFERENCES person(person_id) ON DELETE CASCADE,
    is_permanent BOOLEAN DEFAULT FALSE,
    employee_number VARCHAR(25) UNIQUE NOT NULL,
    employment_date DATE,
    hourly_rate NUMERIC(10,2)
);

-- Student
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY REFERENCES person(person_id) ON DELETE CASCADE,
    program_id INTEGER NOT NULL REFERENCES program(program_id),
    class_id INTEGER NOT NULL REFERENCES class(class_id),
    student_number VARCHAR(30) UNIQUE NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    status VARCHAR(20) DEFAULT 'active'
);

-- Konsult
CREATE TABLE consultant (
    consultant_id INTEGER PRIMARY KEY REFERENCES person(person_id) ON DELETE CASCADE,
    company_id INTEGER NOT NULL REFERENCES consultant_company(company_id),
    hourly_rate NUMERIC(10,2) NOT NULL,
    contract_start_date DATE,
    contract_end_date DATE
);

-- Program Kurs
CREATE TABLE program_course (
    program_id INTEGER REFERENCES program(program_id) ON DELETE CASCADE,
    course_id INTEGER REFERENCES course(course_id) ON DELETE CASCADE,
    is_mandatory BOOLEAN DEFAULT TRUE,
    semester INTEGER,
    PRIMARY KEY (program_id, course_id)
);

-- Kurs Uppgift
CREATE TABLE course_assignment (
    assignment_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES course(course_id),
    educator_id INTEGER NOT NULL REFERENCES educator(educator_id),
    class_id INTEGER NOT NULL REFERENCES class(class_id),
    start_date DATE,
    end_date DATE,
    UNIQUE (course_id, class_id)
);

-- Studentinskrivning
CREATE TABLE student_enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL REFERENCES student(student_id) ON DELETE CASCADE,
    assignment_id INTEGER NOT NULL REFERENCES course_assignment(assignment_id) ON DELETE CASCADE,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade VARCHAR(2),
    status VARCHAR(20) DEFAULT 'enrolled',
    UNIQUE (student_id, assignment_id)
);

-- Index
CREATE INDEX idx_person_type ON person(person_type);
CREATE INDEX idx_student_class ON student(class_id);
CREATE INDEX idx_class_program ON class(program_id);
CREATE INDEX idx_course_assignment_class ON course_assignment(class_id);
CREATE INDEX idx_course_standalone ON course(is_standalone);
CREATE INDEX idx_program_active ON program(is_active);
CREATE INDEX idx_class_status ON class(status);
CREATE INDEX idx_student_enrollment_status ON student_enrollment(status);
CREATE INDEX idx_person_birth_date ON person(birth_date);