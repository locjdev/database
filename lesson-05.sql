-- SUBQUERY: Truy vấn con
-- Thứ tự chạy: Từ trong ra ngoài
-- VD: Lấy ra tất cả chức vụ có ít người nhất

-- B1: Thống kê số người trong từng chức vụ
SELECT position.*, COUNT(account_id) AS account_count
FROM position
LEFT JOIN account USING (position_id)
GROUP BY position_id;
-- B2: Tìm giá trị nhỏ nhất từ B1
SELECT MIN(account_count)
FROM (  SELECT position.*, COUNT(account_id) AS account_count
		FROM position
		LEFT JOIN account USING (position_id)
		GROUP BY position_id
	) AS t;
-- B3: Lấy ra tất cả các chức vụ có giá trị nhỏ nhất đó
SELECT position.*, COUNT(account_id) AS account_count
FROM position
LEFT JOIN account USING (position_id)
GROUP BY position_id
HAVING COUNT(account_id) = (
							SELECT MIN(account_count)
							FROM (  SELECT position.*, COUNT(account_id) AS account_count
									FROM position
									LEFT JOIN account USING (position_id)
									GROUP BY position_id
									) AS t);

-- ANY, ALL, EXISTS
-- ANY giống như IN nhưng có > <
SELECT *
FROM account
WHERE department_id = ANY (
							SELECT department_id
                            FROM department
                            WHERE department_name IN ("Bảo vệ","Sale")
                            );
-- ALL giống ANY nhưng thỏa mãn tất cả
-- EXISTS, NOT EXISTS
SELECT *
FROM `group`
WHERE EXISTS
		(SELECT *
        FROM group_account
        WHERE group_account.group_id = 	`group`.group_id);
        
-- VIEW: Bảng ảo (Không chứa dữ liệu)
DROP VIEW IF EXISTS view_01;
CREATE OR REPLACE VIEW view_01 AS
SELECT *
FROM department;

SELECT department_name
FROM view_01;

-- CTE: Common Table Expression (Bảng tạm)
-- VD: Lấy ra tất cả phòng ban có nhiều nhân viên nhất
WITH c1 AS (
			SELECT department.*, COUNT(account_id) AS account_count
            FROM department
            LEFT JOIN account USING (department_id)
            GROUP BY department_id
)
SELECT *
FROM c1
WHERE account_count = (
						SELECT MAX(account_count)
						FROM c1
                        );