DROP DATABASE IF EXISTS assignment_01;
CREATE DATABASE assignment_01;
USE assignment_01;

-- Table 1
CREATE TABLE department (
	department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(50)
);

INSERT INTO department (department_name)
VALUES				   ("Sale"),
                       ("Marketing");

-- Table 2
CREATE TABLE position (
	position_id INT PRIMARY KEY AUTO_INCREMENT,
    position_name ENUM("Dev", "Test", "Scrum Master", "PM")
);

-- Table 3
CREATE TABLE account (
	account_id INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(50),
    username VARCHAR(50),
    full_name VARCHAR(50),
    department_id INT,
    position_id INT, 
    created_date DATE
);

-- Table 4
CREATE TABLE `group` (
	group_id INT PRIMARY KEY AUTO_INCREMENT,
    group_name VARCHAR(50),
    creator_id INT,
    created_date DATE
);

-- Table 5
CREATE TABLE group_account (
	group_id INT,
    account_id INT,
    Joined_date DATE
);

-- Table 6
CREATE TABLE type_question (
	type_id INT PRIMARY KEY AUTO_INCREMENT,
    type_name VARCHAR(50)
);

INSERT INTO type_question (type_name)
VALUES					  ("Essay"),
						  ("Multiple-Choice");
                          
-- Table 7 
CREATE TABLE category_question (
	category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(50)
);

INSERT INTO category_question (category_name)
VALUES						  ("Java"),
							  (".Net"),
							  ("Postman"),
                              ("Ruby");

-- Table 8
CREATE TABLE question (
	question_id INT,
    content VARCHAR(100),
    category_id INT,
    type_id INT,
    creator_id INT,
    created_date DATE
);

-- Table 9 
CREATE TABLE answer (
	answer_id INT PRIMARY KEY AUTO_INCREMENT,
    content VARCHAR(100),
    question_id INT,
    is_Correct boolean
);

-- Table 10
CREATE TABLE exam (
	exam_id INT PRIMARY KEY AUTO_INCREMENT,
    code VARCHAR(50),
    title VARCHAR(100),
    category_id INT,
    duration INT,
    creator_id INT,
    created_date DATE
);

-- Table 11
CREATE TABLE exame_question (
	exam_id INT,
    question_id INT
);