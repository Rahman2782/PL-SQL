SET SERVEROUTPUT ON;

-- Q1 --
DECLARE
  CURSOR c_department_managers IS
    SELECT
      d.DEPARTMENT_NAME,
      e.FIRST_NAME || ' ' || e.LAST_NAME AS MANAGER_NAME
    FROM
      HR_DEPARTMENTS d
    LEFT JOIN
      HR_EMPLOYEES e ON d.MANAGER_ID = e.EMPLOYEE_ID;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Department Name | Manager Name');
  DBMS_OUTPUT.PUT_LINE('----------------|--------------');
  FOR rec IN c_department_managers LOOP
    DBMS_OUTPUT.PUT_LINE(RPAD(rec.DEPARTMENT_NAME, 16) || '| ' || rec.MANAGER_NAME);
  END LOOP;
END;
/

-- Q2 --
DECLARE
    CURSOR manager_cursor IS
        SELECT EMPLOYEE_ID, SALARY
        FROM HR_EMPLOYEES
        WHERE JOB_ID = 'MANAGER';

    v_emp_id HR_EMPLOYEES.EMPLOYEE_ID%TYPE;
    v_old_salary HR_EMPLOYEES.SALARY%TYPE;
    v_new_salary HR_EMPLOYEES.SALARY%TYPE;

BEGIN
    OPEN manager_cursor;
    LOOP
        FETCH manager_cursor INTO v_emp_id, v_old_salary;
        EXIT WHEN manager_cursor%NOTFOUND;

        IF v_old_salary <= 30000 THEN
            v_new_salary := v_old_salary * 1.10;

            UPDATE HR_EMPLOYEES
            SET SALARY = v_new_salary
            WHERE EMPLOYEE_ID = v_emp_id;
        END IF;
    END LOOP;

    CLOSE manager_cursor;
END;
/


-- Q3 --
DECLARE
  CURSOR c_all_emp IS
    SELECT FIRST_NAME, LAST_NAME, JOB_ID
      FROM HR_EMPLOYEES
      ORDER BY EMPLOYEE_ID;

  v_fname  HR_EMPLOYEES.FIRST_NAME%TYPE;
  v_lname  HR_EMPLOYEES.LAST_NAME%TYPE;
  v_job    HR_EMPLOYEES.JOB_ID%TYPE;

  found_itprog BOOLEAN := FALSE;

BEGIN
  OPEN c_all_emp;
  LOOP
    FETCH c_all_emp INTO v_fname, v_lname, v_job;
    EXIT WHEN c_all_emp%NOTFOUND;

    DBMS_OUTPUT.PUT_LINE(
      'EMPLOYEE: ' || v_fname || ' ' || v_lname ||
      '  |  Job ID: ' || v_job
    );

    IF v_job = 'IT_PROG' THEN
      found_itprog := TRUE;
    END IF;
  END LOOP;
  CLOSE c_all_emp;

  IF NOT found_itprog THEN
    RAISE e_no_itprog;
  END IF;

EXCEPTION
  WHEN e_no_itprog THEN
    DBMS_OUTPUT.PUT_LINE(
      'ALERT: No IT_PROG employees were found!'
    );
END;
/

