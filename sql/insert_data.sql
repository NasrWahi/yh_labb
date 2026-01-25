-- =================
-- YRKESCO DATABASE
-- =================

-- Anläggningar
INSERT INTO facility (facility_code, facility_name, address, postal_code, phone) VALUES
('GBG01', 'YrkesCo Göteborg (Central)', 'Göteborg', 'Götaplatsen 5', '41256', '031-123456'),
('GBG02', 'YrkesCo Göteborg Avenyn', 'Göteborg', 'Avenyn 42', '41136', '031-234567'),
('STO01', 'YrkesCo Stockholm Kungsgatan', 'Stockholm', 'Kungsgatan 64', '11122', '08-987654'),
('STO02', 'YrkesCo Stockholm Sveavägen', 'Stockholm', 'Sveavägen 73', '11350', '08-876543'),
('MAL01', 'YrkesCo Malmö (Central)', 'Malmö', 'Stortorget 1', '21141', '040-222444'),
('UPP01', 'YrkesCo Uppsala Stad', 'Uppsala', 'Stora Torget 10', '75320', '018-999888');

-- Konsultföretag
INSERT INTO consultant_company (company_name, org_number, has_f_skatt, address, email, phone) VALUES
('IT Konsult AB', '556677-8899', TRUE, 'Kungsgatan 10, Stockholm', 'info@itkonsult.se', '08-123456'),
('Data Education Sverige AB', '556688-9900', TRUE, 'Avenyn 25, Göteborg', 'kontakt@dataeducation.se', '031-234567'),
('North Tech Valley AB', '556699-0011', TRUE, 'Stortorget 5, Malmö', 'info@northtechvalley.se', '040-345678'),
('Nortech AB', '556600-1122', TRUE, 'Drottninggatan 8, Uppsala', 'kontakt@nortech.se', '018-456789');

-- Personer
INSERT INTO person (first_name, last_name, person_type, birth_date) VALUES
-- Utbildningsledare
('Mikael', 'Göransson', 'education_leader', '1989-06-06'),
('Pierre', 'Dubois', 'education_leader', '1975-11-23'),
('Lisan', 'Al-Gaib', 'education_leader', '1988-03-17'),
('Aaliyah', 'Omar', 'education_leader', '1990-12-12'),
('Fiona', 'McKenzie', 'education_leader', '1992-09-30'),

-- Utbildare - Fasta anställda
('Anna', 'Karenina', 'educator', '1978-01-01'),
('Karl', 'Kristensen', 'educator', '1963-05-15'),
('André', 'Lefevre', 'educator', '1971-08-22'),
('Mohammed', 'Al-Sayed', 'educator', '1980-02-10'),
('Julia', 'Schmidt', 'educator', '1989-11-05'),
('Sofia', 'Lindberg', 'educator', '1991-04-18'),
('Sami', 'Hassan', 'educator', '1994-07-29'),
('Ayesha', 'Khan', 'educator', '1994-10-14'),

-- Utbildare - Ej fasta (konsulter/visstidsanställda)
('Ahmed', 'Youssef', 'educator', '1997-01-21'),
('Elena', 'Ivanova', 'educator', '1998-08-30'),
('Alexander', 'Johnson', 'educator', '1995-04-20'),
('Isabella', 'Martinez', 'educator', '1996-12-11'),
('Liam', 'Keane', 'educator', '1994-11-06'),

-- Konsulter
('Nina', 'Peterson', 'consultant', '1985-03-14'),
('Omar', 'Hussein', 'consultant', '1986-07-19'),
('Clara', 'Vasquez', 'consultant', '1990-10-25'),
('Lukas', 'Eriksson', 'consultant', '1982-09-09'),
('Ilham', 'Abdi', 'consultant', '1991-06-03'),
('Johan', 'Bergström', 'consultant', '1979-05-30'),

-- Studenter
('Fatima', 'Ali', 'student', '2002-01-05'),
('Noah', 'Sundström', 'student', '2001-12-12'),
('Emelie', 'Nilsson', 'student', '1997-10-23'),
('Oscar', 'Göransson', 'student', '1999-02-14'),
('Maja', 'Lundqvist', 'student', '2000-06-30'),
('Hanna', 'Karlsson', 'student', '1999-04-18'),
('Elias', 'Jabbari', 'student', '1998-11-11'),
('Alma', 'Svensson', 'student', '2004-09-09'),
('Viktor', 'Holm', 'student', '1996-08-08'),
('Sara', 'Olofsson', 'student', '1995-05-05'),
('Alejandro', 'Papadopoulos', 'student', '1996-08-15'),
('Linnea', 'Berg', 'student', '1999-02-28'),
('Felix', 'Nyström', 'student', '1991-12-04'),
('Elin', 'Forsberg', 'student', '1992-03-03'),
('Adam', 'Nordström', 'student', '2002-04-04'),
('Wilma', 'Hansson', 'student', '2001-01-04'),
('Mohammed', 'Said', 'student', '1999-01-10'),
('Asia', 'Ahmeddin', 'student', '2001-09-21'),
('Leo', 'Gustafsson', 'student', '1994-08-11'),
('Thomas', 'Sankara', 'student', '1998-08-08'),
('Berhan', 'Mustafa', 'student', '1997-05-03'),
('Cecilia', 'Larsson', 'student', '2003-12-10'),
('Musa', 'Habib', 'student', '1999-06-04'),
('Jasmine', 'Zhao', 'student', '2005-02-05'),
('Lisa', 'Dahl', 'student', '2000-03-03'),
('Erik', 'Andersson', 'student', '1987-07-08'),
('Arda', 'Yilmaz', 'student', '1995-09-05'),
('Kenneth', 'Cornelius', 'student', '1986-10-10');

-- Program
INSERT INTO program (program_name, program_code, total_credits, duration_weeks, description, is_active) VALUES
('Fullstack Utvecklare .NET', 'YHP-FSD01', 400, 40, 'En omfattande utbildning i .NET-utveckling.', TRUE),
('Data Science & AI', 'YHP-DS01', 400, 42, 'Fokus på dataanalys och artificiell intelligens.', TRUE),
('UX/UI Design', 'YHP-UX01', 350, 35, 'Design och användarupplevelse inom digitala produkter.', TRUE),
('Cloud Engineer', 'YHP-CL01', 400, 40, 'Utbildning i molntjänster och infrastruktur.', TRUE),
('Cybersäkerhet', 'YHP-CY01', 400, 40, 'Säkerhetsprinciper och tekniker inom IT.', TRUE);

-- Kurser (Samt fristående kurser)
INSERT INTO course (course_name, course_code, credits, description, is_standalone, difficulty_level, is_active) VALUES
-- Programkurser
