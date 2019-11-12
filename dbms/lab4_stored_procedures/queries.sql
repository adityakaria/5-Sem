-- Exercise 1
DROP PROCEDURE IF EXISTS usp_get_employees;

DELIMITER &&

CREATE PROCEDURE usp_get_employees(IN target_salary INT)
BEGIN
    SELECT Fname, Lname FROM Employee WHERE Salary >= target_salary;
END &&

DELIMITER ;

CALL usp_get_employees(48100);

-- Exercise 2
DROP PROCEDURE IF EXISTS usp_get_towns_starting_with;

DELIMITER &&

CREATE PROCEDURE usp_get_towns_starting_with(IN begin_string varchar(100))
BEGIN
    SELECT Dlocation FROM Dept_locations WHERE DLocation LIKE CONCAT(begin_string,'%');
END &&

DELIMITER ;

CALL usp_get_towns_starting_with('H');

-- Exercise 3
DROP FUNCTION IF EXISTS ufn_get_salary_level;

DELIMITER &&

CREATE FUNCTION ufn_get_salary_level(salary int)
RETURNS varchar(10)
BEGIN
    IF salary < 30000 THEN
        RETURN 'Low';
    END IF;
    IF salary <= 50000 THEN
        RETURN 'Average';
    END IF;
    RETURN 'High';
END &&

DELIMITER ;

SELECT ufn_get_salary_level(35000);

-- Exercise 4
DROP FUNCTION IF EXISTS ufn_calculate_future_value;

DELIMITER &&

CREATE FUNCTION ufn_calculate_future_value(initial_sum int, interest decimal(10,2), years int)
RETURNS decimal(10,2)
BEGIN
    RETURN initial_sum * (POWER(1+interest,years));
END &&

DELIMITER ;

SELECT ufn_calculate_future_value(1000,0.1,5);

-- Exercise 5
DROP PROCEDURE IF EXISTS emp_in_dept;

DELIMITER $$

CREATE PROCEDURE emp_in_dept(IN department INT, INOUT name_result varchar(1000))
BEGIN
    DECLARE finished int;
    DECLARE employee_name varchar(100);

    DEClARE cursor_emp CURSOR FOR SELECT Fname FROM Employee WHERE Dno = department;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cursor_emp;

    e_loop: LOOP
        FETCH cursor_emp INTO employee_name;
        IF finished = 1 THEN
            LEAVE e_loop;
        END IF;

        SET name_result = CONCAT(employee_name,", ",name_result);
    END LOOP e_loop;

    CLOSE cursor_emp;

END $$

DELIMITER ;

SET @result = "";
CALL emp_in_dept(5, @result);
SELECT @result AS "Employees in Department";

-- Exercise 6

source create_emp_2.sql;

DROP PROCEDURE IF EXISTS update_emp_salary;

DELIMITER $$
CREATE PROCEDURE update_emp_salary()
BEGIN
    DECLARE finished int DEFAULT 0;
    DECLARE emp_id varchar(10);
    DECLARE old_salary int;
    DECLARE employee_name varchar(100);
    DECLARE emp_pos varchar(20);

    DECLARE cursor_sal CURSOR FOR SELECT Id FROM Employee_2;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

    OPEN cursor_sal;

    s_loop: LOOP
        IF finished = 1 THEN
            LEAVE s_loop;
        END IF;

        FETCH cursor_sal INTO emp_id;

        SELECT Salary INTO old_salary FROM Employee_2 WHERE Id = emp_id;
        SELECT Position INTO emp_pos FROM Employee_2 WHERE Id = emp_id;

        IF emp_pos = 'Manager' THEN
            UPDATE Employee_2 SET Salary = (old_salary + 20000) WHERE Id = emp_id;
        END IF;

        IF emp_pos = 'Trainer' THEN
            UPDATE Employee_2 SET Salary = (old_salary + 30000) WHERE Id = emp_id;
        END IF;

    END LOOP s_loop;

    CLOSE cursor_sal;
END$$
DELIMITER ;

CALL update_emp_salary();
SELECT * FROM Employee_2;
