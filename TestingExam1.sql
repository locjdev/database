-- Question 1:
CREATE DATABASE testingExam1;
USE testingExam1;

CREATE TABLE CUSTOMER (
	CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    Address VARCHAR(100),
    Note VARCHAR(100)
);

INSERT INTO CUSTOMER (Name, Phone, Email, Address, Note)
VALUES               ("Vo Duy Loc", "0793316337","Loc1@gmail.com", "Da Nang","Khong co"),
  				     ("Vo Duy Loc 1", "0793316337","Loc2@gmail.com", "Da Nang","Khong co"),
                     ("Vo Duy Loc 2", "0793316337","Loc3@gmail.com", "Da Nang","Khong co"),
                     ("Vo Duy Loc 3", "0793316337","Loc4@gmail.com", "Da Nang","Khong co"),
                     ("Vo Duy Loc 4", "0793316337","Loc5@gmail.com", "Da Nang","Khong co");
                     
 CREATE TABLE CAR (
	CarID INT PRIMARY KEY AUTO_INCREMENT,
    Maker ENUM ("HONDA", "TOYOTA", "NISSAN"),
    Model VARCHAR(20),
    Year INT,
    Color VARCHAR(100),
    Note VARCHAR(100)
 );      
 
 INSERT INTO CAR (Maker, Model, Year, Color, Note)
 VALUES			 ("HONDA", "A1", 2024, "black", "Khong co"),	
				 ("HONDA", "A2", 2024, "white", "Khong co"),
				 ("TOYOTA", "T1", 2024, "black", "Khong co"),
				 ("TOYOTA", "T2", 2024, "white", "Khong co"),
				 ("NISSAN", "N1", 2024, "yellow", "Khong co");

CREATE TABLE CAR_ORDER (
	OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT,
    CarID INT, 
    Amount INT DEFAULT(1),
    SalePrice BIGINT,
    OrderDate DATE,
    DeliveryDate DATE,
    DeliveryAddress VARCHAR(100),
    Status ENUM ("0","1","2") DEFAULT("0"),
    Note VARCHAR(100),
    FOREIGN KEY (CustomerID) REFERENCES CUSTOMER(CustomerID),
    FOREIGN KEY (CarID) REFERENCES CAR(CarID)
    ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO CAR_ORDER (CustomerID, CarID, Amount, SalePrice,OrderDate   ,DeliveryDate,DeliveryAddress,Status, Note)
VALUES				  (	1        ,1       ,1    ,1000000000,"2024-04-30","2024-04-30","DA NANG"      ,"0","KHong co" ),
					  ( 2        ,2       ,1    ,2000000000,"2024-04-30","2024-04-30","DA NANG"      ,"1","KHong co" ),
					  ( 3        ,3       ,1    ,3000000000,"2024-04-30","2024-04-30","DA NANG"      ,"1","KHong co" ),
                      (	4        ,4       ,1    ,4000000000,"2024-04-30","2024-04-30","DA NANG"      ,"1","KHong co" ),
                      (	5        ,5       ,1    ,5000000000,"2024-04-30","2024-04-30","DA NANG"      ,"2","KHong co" );
                      
                      
-- Question 2:
SELECT CUSTOMER.Name,SUM(Amount) AS car_sum
FROM CUSTOMER
LEFT JOIN CAR_ORDER USING(CustomerID)
WHERE Status = "1"
GROUP BY CustomerID
ORDER BY Car_count;

-- Question3:
DELIMITER $$
CREATE FUNCTION fn_01 () RETURNS ENUM ("HONDA", "TOYOTA", "NISSAN")
BEGIN 
	DECLARE v_maker ENUM ("HONDA", "TOYOTA", "NISSAN");

	WITH ct1 AS (
		SELECT Car.Maker, COUNT(OrderID) AS order_count
		FROM CAR
		LEFT JOIN CAR_ORDER USING (CarID)
        WHERE Status = "1" AND YEAR(DeliveryDate) = YEAR(CURRENT_DATE())
        GROUP BY Maker
    )
	SELECT Maker INTO v_maker
    FROM ct1
    WHERE order_count = (SELECT MAX(order_count) FROM ct1); 
    RETURN v_maker;
END $$
DELIMITER ;

SELECT fn_01();

-- Question 4:
DELIMITER $$
CREATE PROCEDURE sp_04 ()
BEGIN 
	SELECT COUNT(*)
    FROM CAR_ORDER
    WHERE Status = "2" AND YEAR(DeliveryDate) < YEAR(CURRENT_DATE());
    
    DELETE FROM CAR_ORDER
    WHERE Status = "2" AND YEAR(DeliveryDate) < YEAR(CURRENT_DATE());
END $$
DELIMITER ;

CALL sp_04();

-- Question 5:
DELIMITER $$
CREATE PROCEDURE sp_05 (IN in_CustomerID INT)
BEGIN 
	SELECT *
    FROM CUSTOMER
    LEFT JOIN CAR_ORDER USING(Customer_id)
    LEFT JOIN CAR USING(Car_id);
END $$
DELIMITER ;