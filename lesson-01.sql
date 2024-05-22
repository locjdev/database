-- Phím tắt: CTRL+ENTER

-- Xóa cơ sở dữ liệu (nếu tồn tại)
DROP DATABASE IF EXISTS lesson_01;

-- Xóa bảng (nếu tồn tại)
DROP TABLE IF EXISTS department;

-- Tạo cơ sở dữ liệu
CREATE DATABASE lesson_01;

-- Hiển thị danh sách cơ sở dữ liệu
SHOW DATABASES;

-- Chọn cơ sở dữ liệu muốn thao tác
USE lesson_01;

-- Kiểu dữ liệu
-- Số nguyên: TINYINT (1byte=8bit (-127->128)), SMALLINT (2 byte) (-32768 -> 32767), MEIDUMINT (3byte) (-8388608 to 8388607), INT (4 byte) (-2147483648 to 2147483647) , BIGINT (8 byte) (-9223372036854775808 to 9223372036854775807.)
-- Số thực: FLOAT (Đúng 7 chữ số), DOUBLE (Đúng 15 chữ số thập phân)
-- Chuỗi: VARCHAR(50), CHAR(50)
-- Thời gian: DATE (yyyy-MM-dd), TIME, DATETIME
-- LogicL BOOLEAN, BIT
-- Enum: ENUM("Loading", "Success", "Error") Chỉ nhận giá trị có trong ()
-- Tạo bảng
CREATE TABLE department (
	id INT,
    name VARCHAR(50),
    created_date DATE
	
);

-- Thêm dữ liệu vào bảng
INSERT INTO department(id, name        , created_date)
VALUES 				  (1 , "Bảo Vệ"    , "2020-04-19"),
					  (2 , "Kinh doanh", "2020-04-20"),
                      (3 , "Giám đốc"  , "2024-04-21");

-- Hiển thị danh sách dữ liệu
TABLE department;
-- Hoặc
SELECT * FROM department;

-- Ràng buộc dữ liệu
-- Khóa chính (PRIMARY KEY)
-- 1. Một bảng có tối đa 1 khóa chính
-- 2. Giá trị là duy nhất
-- 3. Phải NOT NULL
-- Tự động tăng: AUTO_INCREMENT
CREATE TABLE product (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);
INSERT INTO product (id, name)
VALUES              (1, "Chuột máy tính"),
					(2, "Bàn phím máy tính");
INSERT INTO product (name)
VALUES				("Tủ Lạnh");     

-- NOT NULL: Không được để trống
DROP TABLE IF EXISTS question;
CREATE TABLE question (
	id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(100) NOT NULL
);

--
INSERT INTO question (content)
VALUES	             (NULL);

--
INSERT INTO question (content)
VALUES               ("");
       
-- Ví dụ Facebook
-- user_id   group_id    joined_date
-- 1		 10			 2023
-- 1		 20	 		 2024
-- 2		 10			 2023
-- Khóa chính phải là 2 cột user_id và group_id (Vẫn là 1 khóa chính)

-- UNIQUE KEY: Khóa duy nhất ( Có thể là null)

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	id INT PRIMARY KEY  AUTO_INCREMENT,
    email VARCHAR(100) UNIQUE
);

INSERT INTO customer (email)
VALUES 				  (NULL);

-- DEFAULT: Giá trị mặc định
DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
	id INT PRIMARY KEY  AUTO_INCREMENT,
    email VARCHAR(100) DEFAULT "unknow@gmail.com",
    created_date DATE DEFAULT (CURRENT_DATE())
);

INSERT INTO customer (id)
VALUES				 (100);

-- CHECK: Kiểm tra
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
	id INT PRIMARY KEY  AUTO_INCREMENT,
	age INT CHECK (age >= 18)
);

INSERT INTO `user` (age)
VALUES			   (20);

-- FOREIGN KEY: Khóa ngoại
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
	id INT PRIMARY KEY  AUTO_INCREMENT,
	name VARCHAR(50)
);

DROP TABLE IF EXISTS `account`;
CREATE TABLE `account` (
	id INT PRIMARY KEY  AUTO_INCREMENT,
	full_name VARCHAR(50),
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES department(id)
    ON UPDATE CASCADE ON DELETE CASCADE -- SET NULL
);

INSERT INTO department (id, name)
VALUES                 (100, "Bảo vệ");

INSERT INTO `account` (full_name, department_id)
VALUES                ("Duy Lộc", 100);
