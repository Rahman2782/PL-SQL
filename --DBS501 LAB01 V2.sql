--DBS501 LAB01 V2

--QUESTION 1 --
-- Find all employees who earn less than the average salary in their department. (Correlated Subquery)
SELECT 
    e.employee_id,
    e.first_name,
    e.last_name, 
    e.salary,
    e.department_id
FROM 
    hr_employees e
WHERE 
    e.salary < (
        SELECT 
            AVG(sub.salary) --calculating the average salary 
        FROM 
            hr_employees sub --labeled as 'sub' for sub-query
        WHERE sub.department_id = e.department_id --comparing employees salary to that of their own department
    );


--QUESTION 2 --
--Display details of those employees who have changed jobs at least 1 time over time.
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.email,
    e.phone_number,
    e.hire_date,
    e.job_id,
    e.salary
FROM
    hr_employees e
WHERE
    e.employee_id IN (
        SELECT
            jh.employee_id
        FROM
            hr_job_history jh
        GROUP BY
            jh.employee_id
        HAVING
            COUNT(jh.job_id) >= 1 --only count emps who have at least ONE entry in jh
    );

--QUESTION 3 --
--List all departments where any employee exists. (correlated subquery)
SELECT
    d.department_id,
    d.department_name
FROM
    hr_departments d
WHERE
    EXISTS (
        SELECT
            * --placeholder column
        FROM
            hr_employees e
        WHERE
            e.department_id = d.department_id
    );

--QUESTION 4 --
--List all employee details (employee id, first and last name, and each employee’s manager name and manager last_name).
SELECT
    e.employee_id,
    e.first_name AS employee_first_name,
    e.last_name AS employee_last_name,
    m.first_name AS manager_first_name,
    m.last_name AS manager_last_name
FROM
    hr_employees e
LEFT JOIN
    hr_employees m ON e.manager_id = m.employee_id; 
    --joined using LEFT JOIN to make sure all employees are shown

-- QUESTION 5 -- 
--List employees who are not a manager (people do not report to them, they are just regular employees).
SELECT
    e.employee_id,
    e.first_name,
    e.last_name
FROM
    hr_employees e
WHERE NOT EXISTS (
    SELECT
        * --placeholder column
    FROM
        hr_employees mgr
    WHERE
        mgr.manager_id = e.employee_id
);