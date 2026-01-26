-- ==========================
-- YRKESCO DATABASE | QUERIES
-- ==========================

-- Klasser samt program, ledare och anläggning
SELECT
    c.class_code,
    c.class_name,
    p.program_name,
    CONCAT(per.first_name, ' ', per.last_name) as leader_name,
    el.department,
    f.facility_name,
    f.city,
    c.iteration,
    c.start_date,
    c.end_date,
    c.status,
    COUNT(s.student_id) as antal_studenter
FROM class c
JOIN program p ON c.program_id = p.program_id
JOIN education_leader el ON c.leader_id = el.leader_id
JOIN person per ON el.leader_id = per.person_id
JOIN facility f ON c.facility_id = f.facility_id
LEFT JOIN student s ON c.class_id = s.class_id 
GROUP BY c.class_id, p.program_name, per.first_name, per.last_name, el.department, f.facility_name, f.city
ORDER BY c.start_date, f.city;

-- Specifika klasser
SELECT
    co.course_code,
    co.course_name,
    co.credits,
    co.difficulty_level,
    ca.start_date as kurs_start,
    ca.end_date as kurs_slut,
    CONCAT(per.first_name, ' ', per.last_name) as lärare_namn,
    CASE 
        WHEN e.is_permanent THEN 'Fast anställd'
        ELSE 'Konsult/visstid'
    END as anställningstyp,
    e.hourly_rate as timlön
FROM course_assignment ca
JOIN course co ON ca.course_id = co.course_id
JOIN educator e ON ca.educator_id = e.educator_id
JOIN person per ON e.educator_id = per.person_id
WHERE ca.class_id = 1  -- ID ändras beroende på klass
ORDER BY ca.start_date;

-- Studenter: Klass - Program och kurser
SELECT
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn
    p.program_name,
    c.class_name,
    COUNT(se.enrollment_id) as antal_kurser,
    STRING_AGG(co.course_name, ', ') as kurser
FROM student s
JOIN person per ON s.student_id = per.person_id
JOIN program p ON s.program_id = p.program_id
JOIN class c ON s.class_id = c.class_id
LEFT JOIN student_enrollment se ON s.student_id = se.student_id
LEFT JOIN course_assignment ca ON se.assignment_id = ca.assignment_id
LEFT JOIN course co ON ca.course_id = co.course_id
WHERE s.class_id = 1 -- ID: beroende på klass
GROUP BY s.student_id, per.first_name, per.last_name, 
         p.program_name, c.class_name, s.student_number
ORDER BY per.last_name;

-- Lärarna och kurserna som de undervisar i
SELECT 
    CONCAT(per.first_name, ' ', per.last_name) as lärare_namn,
    e.employee_number,
    CASE 
        WHEN e.is_permanent THEN 'Fast anställd'
        ELSE 'Konsult/visstid'
    END as anställningstyp,
    e.hourly_rate as timlön,
    COUNT(DISTINCT ca.assignment_id) as antal_kursuppdrag,
    STRING_AGG(DISTINCT co.course_name, ', ') as kurser_undervisar
FROM educator e
JOIN person per ON e.educator_id = per.person_id
LEFT JOIN course_assignment ca ON e.educator_id = ca.educator_id
LEFT JOIN course co ON ca.course_id = co.course_id
GROUP BY e.educator_id, per.first_name, per.last_name, 
         e.employee_number, e.is_permanent, e.hourly_rate
ORDER BY antal_kursuppdrag DESC, lärare_namn;

-- KONSULTER: FÖRETAG OCH ARVODE
SELECT 
    CONCAT(per.first_name, ' ', per.last_name) as konsult_namn,
    cc.company_name,
    cc.org_number,
    c.hourly_rate as arvode_per_timme,
    c.contract_start_date,
    c.contract_end_date,
    ROUND(c.hourly_rate * 160, 2) as beräknad_månadskostnad
FROM consultant c
JOIN person per ON c.consultant_id = per.person_id
JOIN consultant_company cc ON c.company_id = cc.company_id
ORDER BY c.hourly_rate DESC;

-- Fristående kurser
SELECT 
    co.course_code,
    co.course_name,
    co.credits,
    co.description,
    cl.class_name,
    CONCAT(per.first_name, ' ', per.last_name) as lärare_namn,
    ca.start_date,
    ca.end_date,
    f.facility_name,
    f.city
FROM course co
JOIN course_assignment ca ON co.course_id = ca.course_id
JOIN class cl ON ca.class_id = cl.class_id
JOIN educator e ON ca.educator_id = e.educator_id
JOIN person per ON e.educator_id = per.person_id
JOIN facility f ON cl.facility_id = f.facility_id
WHERE co.is_standalone = TRUE
ORDER BY ca.start_date;

-- Program: Kurser och Vad/Om de är obligatoriska
SELECT 
    p.program_name,
    p.program_code,
    co.course_name,
    co.course_code,
    co.credits,
    CASE 
        WHEN pc.is_mandatory THEN 'Obligatorisk'
        ELSE 'Valfri'
    END as kurs_typ,
    pc.semester as termin
FROM program p
JOIN program_course pc ON p.program_id = pc.program_id
JOIN course co ON pc.course_id = co.course_id
ORDER BY p.program_name, pc.semester, kurs_typ DESC;

-- Statistik: Antal studenter och städer
SELECT 
    p.program_name,
    f.city,
    cl.iteration as omgång,
    cl.status,
    COUNT(s.student_id) as antal_studenter,
    cl.max_students as max_antal,
    ROUND((COUNT(s.student_id) * 100.0 / cl.max_students), 1) as fyllnadsgrad
FROM program p
JOIN class cl ON p.program_id = cl.program_id
JOIN facility f ON cl.facility_id = f.facility_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY p.program_name, f.city, cl.iteration, cl.status, cl.max_students
ORDER BY p.program_name, f.city, cl.iteration;

-- Utbildningsledare och deras klasser
SELECT 
    CONCAT(per.first_name, ' ', per.last_name) as ledare_namn,
    el.employee_number,
    el.department,
    COUNT(cl.class_id) as antal_klasser,
    STRING_AGG(CONCAT(cl.class_name, ' (', cl.status, ')'), ', ') as ledda_klasser,
    CASE 
        WHEN COUNT(cl.class_id) > 3 THEN 'ÖVER MAXGRÄNS!'
        ELSE 'OK'
    END as kontroll
FROM education_leader el
JOIN person per ON el.leader_id = per.person_id
LEFT JOIN class cl ON el.leader_id = cl.leader_id
GROUP BY el.leader_id, per.first_name, per.last_name, 
         el.employee_number, el.department
HAVING COUNT(cl.class_id) > 0  -- Enbart ledare med klasser!!!
ORDER BY antal_klasser DESC;

-- Registrering av studenter och betyg
SELECT 
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn,
    co.course_name,
    cl.class_name,
    se.enrollment_date,
    se.grade,
    se.status as kurs_status,
    CONCAT(edu_per.first_name, ' ', edu_per.last_name) as lärare_namn
FROM student_enrollment se
JOIN student s ON se.student_id = s.student_id
JOIN person per ON s.student_id = per.person_id
JOIN course_assignment ca ON se.assignment_id = ca.assignment_id
JOIN course co ON ca.course_id = co.course_id
JOIN class cl ON ca.class_id = cl.class_id
JOIN educator e ON ca.educator_id = e.educator_id
JOIN person edu_per ON e.educator_id = edu_per.person_id
ORDER BY per.last_name, co.course_name;

-- Känslig data (Personuppgifter separerade)
SELECT 
    p.person_id,
    CONCAT(p.first_name, ' ', p.last_name) as namn,
    p.person_type,
    pd.email,
    pd.personal_number
FROM person p
JOIN person_details pd ON p.person_id = pd.person_id
WHERE p.person_type = 'student'
ORDER BY p.last_name
LIMIT 10;  -- Begränsa för säkerhet

-- Anläggningar och deras specifika klasser
SELECT 
    f.facility_code,
    f.facility_name,
    f.city,
    f.address,
    COUNT(DISTINCT cl.class_id) as antal_klasser,
    STRING_AGG(DISTINCT p.program_name, ', ') as program,
    COUNT(DISTINCT s.student_id) as totala_studenter
FROM facility f
LEFT JOIN class cl ON f.facility_id = cl.facility_id
LEFT JOIN program p ON cl.program_id = p.program_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY f.facility_id, f.facility_code, f.facility_name, 
         f.city, f.address
ORDER BY f.city, f.facility_name;

-- Fast anställda eller konsulter/visstids
SELECT 
    'Fast anställda' as kategori,
    COUNT(*) as antal,
    ROUND(AVG(e.hourly_rate), 2) as genomsnittlig_timlön
FROM educator e
WHERE e.is_permanent = TRUE

UNION ALL

SELECT 
    'Konsulter/visstid' as kategori,
    COUNT(*) as antal,
    ROUND(AVG(e.hourly_rate), 2) as genomsnittlig_timlön
FROM educator e
WHERE e.is_permanent = FALSE

UNION ALL

SELECT 
    'Konsulter (separat)' as kategori,
    COUNT(*) as antal,
    ROUND(AVG(c.hourly_rate), 2) as genomsnittlig_arvode
FROM consultant c;

-- Den tänkta expansionen till andra städer/orter
SELECT 
    f.city,
    COUNT(DISTINCT f.facility_id) as antal_anläggningar,
    COUNT(DISTINCT cl.class_id) as antal_klasser,
    COUNT(DISTINCT s.student_id) as antal_studenter,
    STRING_AGG(DISTINCT p.program_name, ', ') as erbjudna_program
FROM facility f
LEFT JOIN class cl ON f.facility_id = cl.facility_id
LEFT JOIN program p ON cl.program_id = p.program_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY f.city
ORDER BY antal_studenter DESC;

-- Join-test för att enkelt få upp all viktig och nödvändig information om en student + exempel för redovisningssyfte
SELECT 
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn,
    p.program_name,
    cl.class_name,
    f.facility_name,
    f.city,
    el.employee_number as ledare_nr,
    CONCAT(el_per.first_name, ' ', el_per.last_name) as ledare_namn
FROM student s
JOIN person per ON s.student_id = per.person_id
JOIN program p ON s.program_id = p.program_id
JOIN class cl ON s.class_id = cl.class_id
JOIN facility f ON cl.facility_id = f.facility_id
JOIN education_leader el ON cl.leader_id = el.leader_id
JOIN person el_per ON el.leader_id = el_per.person_id
WHERE s.student_id = 25  -- Fatima Ali
LIMIT 1;