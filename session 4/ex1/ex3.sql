USE ss4;

SELECT * FROM students
WHERE birth_day BETWEEN 20030101 AND 20050101;

SELECT * FROM students
WHERE gender IN ('male', 'female');

SELECT * FROM students
WHERE student_id IN (1, 4, 5);

SELECT student_id, full_name, birth_day FROM students;