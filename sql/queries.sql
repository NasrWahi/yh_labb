-- ===============================
-- YRKESCO DATABASE | TEST-QUERIES
-- ===============================

-- Test 1: Utbildningsledare max 3 klasser
SELECT 
    'Test: Utbildningsledare max 3 klasser' as test_namn,
    CONCAT(p.first_name, ' ', p.last_name) as ledare_namn,
    COUNT(cl.class_id) as antal_klasser,
    CASE 
        WHEN COUNT(cl.class_id) > 3 THEN 'FEL - for manga klasser'
        WHEN COUNT(cl.class_id) = 0 THEN 'Inga klasser'
        ELSE 'OK'
    END as resultat
FROM education_leader el
JOIN person p ON el.leader_id = p.person_id
LEFT JOIN class cl ON el.leader_id = cl.leader_id
GROUP BY el.leader_id, p.first_name, p.last_name
ORDER BY antal_klasser DESC;

-- Test 2: Program har 3 iterationer
SELECT 
    'Test: Program har 3 iterationer' as test_namn,
    p.program_name,
    COUNT(DISTINCT cl.iteration) as antal_iterationer,
    CASE 
        WHEN COUNT(DISTINCT cl.iteration) = 3 THEN 'OK'
        WHEN COUNT(DISTINCT cl.iteration) = 0 THEN 'INGA'
        ELSE CONCAT('Bara ', COUNT(DISTINCT cl.iteration))
    END as resultat
FROM program p
LEFT JOIN class cl ON p.program_id = cl.program_id
GROUP BY p.program_id, p.program_name
ORDER BY p.program_name;

-- Test 3: Anläggningar
SELECT 
    'Test: Anläggningar' as test_namn,
    COUNT(*) as antal_anlaggningar,
    CASE 
        WHEN COUNT(*) >= 2 THEN 'OK'
        ELSE 'For fa'
    END as resultat
FROM facility;

-- Test 4: Känslig data separerad
SELECT 
    'Test: Kanslig data separerad' as test_namn,
    CASE 
        WHEN COUNT(DISTINCT p.person_id) = COUNT(DISTINCT pd.person_id) 
            THEN 'OK'
        ELSE 'FEL'
    END as resultat
FROM person p
LEFT JOIN person_details pd ON p.person_id = pd.person_id;

-- Test 5: Personaltyper
SELECT 
    'Test: Personaltyper' as test_namn,
    CASE 
        WHEN (SELECT COUNT(*) FROM educator WHERE is_permanent = TRUE) > 0 
            AND (SELECT COUNT(*) FROM consultant) > 0 
            THEN 'OK'
        ELSE 'FEL'
    END as resultat;

-- Test 6: Fristående kurser
SELECT 
    'Test: Fristaende kurser' as test_namn,
    CASE 
        WHEN COUNT(*) > 0 THEN 'OK'
        ELSE 'FEL'
    END as resultat
FROM course 
WHERE is_standalone = TRUE;

-- ==========================
-- YRKESCO DATABASE | QUERIES
-- ==========================

-- Query 1: Klassöversikt
SELECT
    c.class_code,
    c.class_name,
    p.program_name,
    CONCAT(per.first_name, ' ', per.last_name) as leader_name,
    f.facility_name,
    f.city,
    c.iteration,
    c.start_date,
    c.end_date,
    c.status,
    COUNT(s.student_id) as antal_studenter,
    c.max_students
FROM class c
JOIN program p ON c.program_id = p.program_id
JOIN education_leader el ON c.leader_id = el.leader_id
JOIN person per ON el.leader_id = per.person_id
JOIN facility f ON c.facility_id = f.facility_id
LEFT JOIN student s ON c.class_id = s.class_id 
GROUP BY c.class_id, p.program_name, per.first_name, per.last_name, 
         f.facility_name, f.city, c.max_students
ORDER BY c.start_date, f.city;

-- Query 2: Kurser i en klass (exempel: klass 1)
SELECT
    co.course_code,
    co.course_name,
    co.credits,
    co.difficulty_level,
    ca.start_date as kurs_start,
    ca.end_date as kurs_slut,
    CONCAT(per.first_name, ' ', per.last_name) as larare_namn,
    CASE 
        WHEN e.is_permanent THEN 'Fast anstalld'
        ELSE 'Konsult/visstid'
    END as anstallningstyp
FROM course_assignment ca
JOIN course co ON ca.course_id = co.course_id
JOIN educator e ON ca.educator_id = e.educator_id
JOIN person per ON e.educator_id = per.person_id
WHERE ca.class_id = 1
ORDER BY ca.start_date;

-- Query 3: Studenter i en klass (exempel: klass 1)
SELECT
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn,
    p.program_name,
    c.class_name,
    COUNT(se.enrollment_id) as antal_kurser
FROM student s
JOIN person per ON s.student_id = per.person_id
JOIN program p ON s.program_id = p.program_id
JOIN class c ON s.class_id = c.class_id
LEFT JOIN student_enrollment se ON s.student_id = se.student_id
WHERE s.class_id = 1
GROUP BY s.student_id, per.first_name, per.last_name, 
         p.program_name, c.class_name, s.student_number
ORDER BY per.last_name;

-- Query 4: Alla lärare
SELECT 
    CONCAT(per.first_name, ' ', per.last_name) as larare_namn,
    CASE 
        WHEN e.is_permanent THEN 'Fast anstalld'
        ELSE 'Konsult/visstid'
    END as anstallningstyp,
    e.hourly_rate as timlon,
    COUNT(DISTINCT ca.assignment_id) as antal_kursuppdrag
FROM educator e
JOIN person per ON e.educator_id = per.person_id
LEFT JOIN course_assignment ca ON e.educator_id = ca.educator_id
GROUP BY e.educator_id, per.first_name, per.last_name, 
         e.is_permanent, e.hourly_rate
ORDER BY antal_kursuppdrag DESC;

-- Query 5: Alla konsulter
SELECT 
    CONCAT(per.first_name, ' ', per.last_name) as konsult_namn,
    cc.company_name,
    c.hourly_rate as arvode_per_timme,
    c.contract_start_date,
    c.contract_end_date
FROM consultant c
JOIN person per ON c.consultant_id = per.person_id
JOIN consultant_company cc ON c.company_id = cc.company_id
ORDER BY c.hourly_rate DESC;

-- Query 6: Fristående kurser
SELECT 
    co.course_code,
    co.course_name,
    co.credits,
    cl.class_name,
    CONCAT(per.first_name, ' ', per.last_name) as larare_namn,
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

-- Query 7: Program och kurser
SELECT 
    p.program_name,
    co.course_name,
    CASE 
        WHEN pc.is_mandatory THEN 'Obligatorisk'
        ELSE 'Valfri'
    END as kurs_typ,
    pc.semester as termin
FROM program p
JOIN program_course pc ON p.program_id = pc.program_id
JOIN course co ON pc.course_id = co.course_id
ORDER BY p.program_name, pc.semester;

-- Query 8: Statistik: Studentantal
SELECT 
    p.program_name,
    f.city,
    cl.iteration as omgang,
    COUNT(s.student_id) as antal_studenter,
    cl.max_students as max_antal
FROM program p
JOIN class cl ON p.program_id = cl.program_id
JOIN facility f ON cl.facility_id = f.facility_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY p.program_name, f.city, cl.iteration, cl.max_students
ORDER BY p.program_name, f.city;

-- Query 9: Utbildningsledare och deras klasser
SELECT 
    CONCAT(per.first_name, ' ', p.last_name) as ledare_namn,
    COUNT(cl.class_id) as antal_klasser
FROM education_leader el
JOIN person p ON el.leader_id = p.person_id
LEFT JOIN class cl ON el.leader_id = cl.leader_id
GROUP BY el.leader_id, per.first_name, p.last_name
ORDER BY antal_klasser DESC;

-- Query 10: Studentbetyg
SELECT 
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn,
    co.course_name,
    se.grade,
    CONCAT(edu_per.first_name, ' ', edu_per.last_name) as larare_namn
FROM student_enrollment se
JOIN student s ON se.student_id = s.student_id
JOIN person per ON s.student_id = per.person_id
JOIN course_assignment ca ON se.assignment_id = ca.assignment_id
JOIN course co ON ca.course_id = co.course_id
JOIN educator e ON ca.educator_id = e.educator_id
JOIN person edu_per ON e.educator_id = edu_per.person_id
WHERE se.grade IS NOT NULL
ORDER BY per.last_name, co.course_name;

-- Query 11: Anläggningar och klasser
SELECT 
    f.facility_name,
    f.city,
    COUNT(DISTINCT cl.class_id) as antal_klasser,
    COUNT(DISTINCT s.student_id) as totala_studenter
FROM facility f
LEFT JOIN class cl ON f.facility_id = cl.facility_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY f.facility_id, f.facility_name, f.city
ORDER BY f.city;

-- Query 12: Personalstatistik
SELECT 
    'Fast anstallda' as kategori,
    COUNT(*) as antal
FROM educator e
WHERE e.is_permanent = TRUE
UNION ALL
SELECT 
    'Konsulter/visstid' as kategori,
    COUNT(*) as antal
FROM educator e
WHERE e.is_permanent = FALSE
UNION ALL
SELECT 
    'IT-konsulter' as kategori,
    COUNT(*) as antal
FROM consultant c;

-- Query 13: Expansion till andra städer
SELECT 
    f.city,
    COUNT(DISTINCT cl.class_id) as antal_klasser,
    COUNT(DISTINCT s.student_id) as antal_studenter
FROM facility f
LEFT JOIN class cl ON f.facility_id = cl.facility_id
LEFT JOIN student s ON cl.class_id = s.class_id
GROUP BY f.city
ORDER BY antal_studenter DESC;

-- Query 14: Studentöversikt (exempel: Fatima Ali)
SELECT 
    s.student_number,
    CONCAT(per.first_name, ' ', per.last_name) as student_namn,
    p.program_name,
    cl.class_name,
    f.facility_name,
    f.city,
    CONCAT(el_per.first_name, ' ', el_per.last_name) as ledare_namn
FROM student s
JOIN person per ON s.student_id = per.person_id
JOIN program p ON s.program_id = p.program_id
JOIN class cl ON s.class_id = cl.class_id
JOIN facility f ON cl.facility_id = f.facility_id
JOIN education_leader el ON cl.leader_id = el.leader_id
JOIN person el_per ON el.leader_id = el_per.person_id
WHERE s.student_id = 25;