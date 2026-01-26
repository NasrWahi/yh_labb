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

-- 5. KONSULTER: FÖRETAG OCH ARVODE
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