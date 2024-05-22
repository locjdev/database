-- Mệnh đề SELECT
SELECT CURRENT_DATE;
SELECT PI();
SELECT 1 + 1;
SELECT "Khoa";
SELECT CURRENT_DATE AS "Today", NOW() AS "Now";
SELECT CURRENT_DATE "Today", NOW() "Now";

-- Mệnh đề FROM
SELECT department_name, department_id
FROM department;
-- *: Tất cả
SELECT *
FROM question;

-- Mệnh đề WHERE
-- Toán tử: >, >=, <, <=, =, !=
SELECT *
FROM department
WHERE department_id != 5;
-- AND, OR
SELECT *
FROM department
WHERE department_id >= 3 AND department_id <= 8;

SELECT *
FROM department
WHERE department_id >= 3 OR department_id <= 8;

-- BETWEEN ... AND ...
SELECT *
FROM department
WHERE department_id BETWEEN 3 AND 8;

-- IN
SELECT *
FROM department
WHERE department_id IN (2, 4, 6, 8);

-- LIKE
-- _: Đại diện 1 kí tự
-- %: Đại diện 0 hoặc nhiều kí tự
SELECT *
FROM department
WHERE department_name LIKE "%g%";

-- IS NULL / IS NOT NULL
SELECT *
FROM department
WHERE department_name IS NOT NULL;

-- Mệnh đề LIMIT
SELECT * 
FROM department
LIMIT 5;

-- Mệnh đề ORDER BY
-- ASC, DESC 
-- Mặc định: ASC (Tăng dần)
SELECT *
FROM exam
ORDER BY duration DESC, created_date ASC;

-- Hàm tổng hợp
-- COUNT(*): Đếm số dòng
SELECT COUNT(*) AS exam_count
FROM exam;
-- COUNT(id): Đếm số dòng mà id IS NOT NULL
SELECT COUNT(duration) AS exam_count
FROM exam;
INSERT INTO `assignment_03`.`exam` (`exam_id`, `code`   , `title`       , `category_id`, `duration`, `creator_id`, `created_date`) 
VALUES                             ('11'     , 'VTIQ011', 'Đề thi MySQL', '2'          , null      , '9'         , '2024-05-05');
-- SUM, MIN, MAX, AVG: Áp dụng với dòng mà IS NOT NULL
SELECT SUM(duration), MIN(duration), MAX(duration), AVG(duration)
FROM exam;

-- Mệnh đề GROUP BY
SELECT duration, created_date, COUNT(exam_id) AS exam_count
FROM exam
GROUP BY duration, created_date
ORDER BY duration, created_date;

-- Mệnh đề HAVING: Điều kiện trên 1 nhóm
SELECT duration, created_date, COUNT(exam_id) AS exam_count
FROM exam
GROUP BY duration, created_date
HAVING COUNT(exam_id)>1
ORDER BY duration, created_date;

-- Cập nhật dữ liệu
UPDATE department
SET department_name = "Phòng chờ"
WHERE department_id = 1;

-- Xóa dữ liệu
DELETE FROM exam
WHERE duration IS NULL;