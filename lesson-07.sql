-- LOCAL VARIABLE: Biến cục bộ
-- Phạm vi sử dụng: BEGIN END
-- Từ khóa: DECLARE
-- VD: DECLARE id INT;

-- SESSION VARIABLE: Biến session
-- Phạm vi sử dụng: Cả session
-- Từ khóa: SET
-- VD
SET @age = 18;
SELECT @age;

-- GLOBAL VARIABLE: Biến toàn cục 
-- Phạm vi sử dụng: Toàn bộ
-- Từ khóa: SET
-- Hiển thị danh sách biến
SHOW VARIABLES;
-- VD: Thay đổi connect_timeout thành 5
SET GLOBAL connect_timeout = 5;


-- TRIGGER
-- Thời điểm: BEFORE, AFTER
-- Sự kiện: INSERT, UPDATE, DELETE
-- Tham chiếu: OLD, NEW
DROP TRIGGER IF EXISTS trigger_01;
DELIMITER $$
CREATE TRIGGER trigger_01
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
	IF NEW.joined_date > CURRENT_DATE THEN
		SET NEW.joined_date = CURRENT_DATE;
    END IF;
END $$
DELIMITER ;

-- VD:
DROP TRIGGER IF EXISTS trigger_02;
DELIMITER $$
CREATE TRIGGER trigger_02
BEFORE INSERT ON group_account
FOR EACH ROW
BEGIN
	IF NEW.joined_date > CURRENT_DATE THEN
		SIGNAL SQLSTATE "12345"
        SET MESSAGE_TEXT = "Thời gian tham gia không hợp lệ";
    END IF;
END $$
DELIMITER ;

INSERT INTO group_account (group_id, account_id, joined_date)
VALUES (5,10,"5000-2-12");

-- Hiển thị danh sách trigger
SHOW TRIGGERS;

-- CASE WHEN
SELECT *,
	CASE
		WHEN duration <= 45 THEN "Short time"
        WHEN duration <= 100 THEN "Medium time"
        ELSE "Long time" 
	END AS duration_type
FROM exam;

-- INDEX: Đánh chỉ mục 
CREATE INDEX index_name 
ON department (department_name);

-- 
CREATE INDEX index_email_username
ON account (email, username);

-- 
SELECT *
FROM department
WHERE department_name = "Sale";

-- Xóa index
DROP INDEX index_name ON department;

SHOW INDEX FROM department;