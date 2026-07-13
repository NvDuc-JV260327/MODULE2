USE ss4;

SELECT * FROM students
WHERE email IS NULL;

SELECT * FROM students 
WHERE email IS NOT NULL;

SELECT * FROM students 
WHERE full_name LIKE 'Ng%';

SELECT * FROM students 
WHERE NOT gender = 'male';