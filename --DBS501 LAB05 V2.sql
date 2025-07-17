--DBS501 LAB05 V2

-- prep --
CREATE TABLE emp
AS
SELECT * FROM hr_employees;

ALTER TABLE emp ADD stars VARCHAR2(50);

-- TASK 1 --
SET SERVEROUTPUT ON;

DECLARE
    v_empno      emp.employee_id%TYPE := &emp_id; --user input
    v_asterisk   emp.stars%TYPE := NULL; --initalize to NULL
    sal          emp.salary%TYPE;
    num_stars    NUMBER;
BEGIN
    --getting empsp salary
    SELECT salary
    INTO sal
    FROM emp
    WHERE employee_id = v_empno;

    --calculate num of stars
    num_stars := ROUND(sal / 1000);

    -- Loop to append asterisks
    FOR i IN 1..num_stars LOOP
        v_asterisk := v_asterisk || '*';
    END LOOP;

    --update stars
    UPDATE emp
    SET stars = v_asterisk
    WHERE employee_id = v_empno;

    COMMIT;

    DBMS_OUTPUT.PUT_LINE('Employee ' || v_empno || ' stars updated to: ' || v_asterisk);
END;
/

SELECT employee_id, salary, stars
FROM emp
WHERE employee_id = &emp_id;


-- TASK 2 --
SET SERVEROUTPUT ON;

DECLARE
    --variable declaration

    --100
    v_firstname1 HR_EMPLOYEES.first_name%TYPE; 
    v_salary1    HR_EMPLOYEES.salary%TYPE;     

    --101
    v_firstname2 HR_EMPLOYEES.first_name%TYPE; 
    v_salary2    HR_EMPLOYEES.salary%TYPE;     

    --102
    v_firstname3 HR_EMPLOYEES.first_name%TYPE; 
    v_salary3    HR_EMPLOYEES.salary%TYPE;     

    --avg salary
    v_avgsal     HR_EMPLOYEES.salary%TYPE;     

BEGIN
    --fetching data for the previous decalred employees
    SELECT first_name, salary
    INTO v_firstname1, v_salary1
    FROM HR_EMPLOYEES 
    WHERE employee_id = 100;

    SELECT first_name, salary
    INTO v_firstname2, v_salary2
    FROM HR_EMPLOYEES 
    WHERE employee_id = 101;

    SELECT first_name, salary
    INTO v_firstname3, v_salary3
    FROM HR_EMPLOYEES 
    WHERE employee_id = 102;

    --getting avg salary
    SELECT AVG(salary)
    INTO v_avgsal
    FROM HR_EMPLOYEES; 

    DBMS_OUTPUT.PUT_LINE('Average salary is: ' || TO_CHAR(v_avgsal, 'FM99,999.00')); --added to see the average for testing


    --comparing 100
    IF v_salary1 > v_avgsal THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname1 || ' salary ' || v_salary1 || ' is more than average salary.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname1 || ' salary ' || v_salary1 || ' is less than average salary.');
    END IF;

    --comparing 101
    IF v_salary2 > v_avgsal THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname2 || ' salary ' || v_salary2 || ' is more than average salary.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname2 || ' salary ' || v_salary2 || ' is less than average salary.');
    END IF;

    --comparing 102
    IF v_salary3 > v_avgsal THEN
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname3 || ' salary ' || v_salary3 || ' is more than average salary.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Employee ' || v_firstname3 || ' salary ' || v_salary3 || ' is less than average salary.');
    END IF;
END;
/