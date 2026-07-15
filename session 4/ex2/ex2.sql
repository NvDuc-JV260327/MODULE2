USE ss4;

SELECT * FROM students;

-- UPDATE students SET	student_id = 1 WHERE student_id = 22;
-- UPDATE students SET	student_id = 2 WHERE student_id = 23;
-- UPDATE students SET	student_id = 3 WHERE student_id = 24;
-- UPDATE students SET	student_id = 4 WHERE student_id = 25;
-- UPDATE students SET	student_id = 5 WHERE student_id = 26;

DELETE FROM students WHERE student_id = 3;

UPDATE students SET gender = 'female' WHERE student_id = 5;
SELECT student_id, gender FROM students WHERE student_id = 5;

SELECT student_id, full_name, email FROM students;

UPDATE students SET email = 'nvB@gmail.com' WHERE student_id = 2;
SELECT student_id,full_name, email FROM students WHERE student_id = 2;

UPDATE students SET email = 'ntD@gmail.com' WHERE student_id = 4;
SELECT student_id,full_name, email FROM students WHERE student_id = 4;