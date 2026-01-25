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

-- Person detaljer
INSERT INTO person_details (person_id, personal_number, email) VALUES
(1, '890606-1234', 'mikael.goransson@yrkesco.se'),
(2, '751123-5678', 'pierre.dubois@yrkesco.se'),
(3, '880317-9101', 'lisan.al-gaib@yrkesco.se'),
(4, '901212-1121', 'aaliyah.omar@yrkesco.se'),
(5, '920930-1234', 'fiona.mckenzie@yrkesco.se'),
(6, '780101-2345', 'anna.karenina@yrkesco.se'),
(7, '630515-3456', 'karl.kristensen@yrkesco.se'),
(8, '710822-4567', 'andre.lefevre@yrkesco.se'),
(9, '800210-5678', 'mohammed.al-sayed@yrkesco.se'),
(10, '891105-6789', 'julia.schmidt@yrkesco.se'),
(11, '910418-7890', 'sofia.lindberg@yrkesco.se'),
(12, '940729-8901', 'sami.hassan@yrkesco.se'),
(13, '941014-9012', 'ayesha.khan@yrkesco.se'),
(14, '970121-0123', 'ahmed.youssef@yrkesco.se'),
(15, '980830-2345', 'elena.ivanova@yrkesco.se'),
(16, '950420-3456', 'alexander.johnson@yrkesco.se'),
(17, '961211-4567', 'isabella.martinez@yrkesco.se'),
(18, '941106-5678', 'liam.keane@yrkesco.se'),
(19, '850314-6789', 'nina.peterson@yrkesco.se'),
(20, '860719-7890', 'omar.hussein@yrkesco.se'),
(21, '901025-8901', 'clara.vasquez@yrkesco.se'),
(22, '820909-9012', 'lukas.eriksson@yrkesco.se'),
(23, '910603-0123', 'ilham.abdi@yrkesco.se'),
(24, '790530-2345', 'johan.bergstrom@yrkesco.se'),

(25, '020105-3456', 'fatima.ali@yrkesco.se'),
(26, '011212-4567', 'noah.sundstrom@yrkesco.se'),
(27, '971023-5678', 'emelie.nilsson@yrkesco.se'),
(28, '990214-6789', 'oscar.goransson@yrkesco.se'),
(29, '000630-7890', 'maja.lundqvist@yrkesco.se'),
(30, '990418-8901', 'hanna.karlsson@yrkesco.se'),
(31, '981111-9012', 'elias.jabbari@yrkesco.se'),
(32, '040909-0123', 'alma.svensson@yrkesco.se'),
(33, '960808-2345', 'viktor.holm@yrkesco.se'),
(34, '950505-3456', 'sara.olofsson@yrkesco.se'),
(35, '960815-4567', 'alejandro.papadopoulos@yrkesco.se'),
(36, '990228-5678', 'linnea.berg@yrkesco.se'),
(37, '911204-6789', 'felix.nystrom@yrkesco.se'),
(38, '920303-7890', 'elin.forsberg@yrkesco.se'),
(39, '020404-8901', 'adam.nordstrom@yrkesco.se'),
(40, '010104-9012', 'wilma.hansson@yrkesco.se'),
(41, '990110-0123', 'mohammed.said@yrkesco.se'),
(42, '010921-2345', 'asia.ahmeddin@yrkesco.se'),
(43, '940811-3456', 'leo.gustafsson@yrkesco.se'),
(44, '980808-4567', 'thomas.sankara@yrkesco.se'),
(45, '970503-5678', 'berhan.mustafa@yrkesco.se'),
(46, '031210-6789', 'cecilia.larsson@yrkesco.se'),
(47, '990604-7890', 'musa.habib@yrkesco.se'),
(48, '050205-8901', 'jasmine.zhao@yrkesco.se'),
(49, '000303-9012', 'lina.ahmed@yrkesco.se'),
(50, '870708-0123', 'erik.andersson@yrkesco.se'),
(51, '950905-2345', 'anna.karlsson@yrkesco.se'),
(52, '861010-3456', 'kenneth.cornelius@yrkesco.se');

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
