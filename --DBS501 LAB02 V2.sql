--DBS501 LAB02 V2
--QUESTION 1
SELECT
    c.fname,
    c.lname,
    v.comments
FROM
    dh_client c
JOIN
    dh_viewing v ON c.clientno = v.clientno
WHERE
    v.comments IS NOT NULL; --shows viewings where there IS a comment

--QUESTION 2
SELECT
    b.branchno,
    b.city AS branch_city,
    s.staffno,
    s.fname || ' ' || s.lname AS staff_name,
    p.propertyno,
    p.street,
    p.city AS property_city
FROM
    dh_branch b
JOIN
    dh_staff s ON b.branchno = s.branchno
JOIN
    dh_propertyforrent p ON s.staffno = p.staffno
WHERE
    s.POSITION = 'Supervisor' OR s.POSITION = 'Manager'; 

--QUESTION 3
SELECT
    e.last_name AS employee_last_name,
    e.hire_date AS employee_hire_date,
    m.last_name AS manager_last_name,
    m.hire_date AS manager_hire_date
FROM
    hr_employees e
JOIN
    hr_employees m ON e.manager_id = m.employee_id
WHERE
    e.hire_date < m.hire_date;

--QUESTION 4
SELECT
    e.employee_id,
    e.first_name,
    e.salary,
    e.job_id,
    d.department_name,
    l.city,
    l.state_province
FROM
    hr_employees e
JOIN
    hr_departments d ON e.department_id = d.department_id
JOIN
    hr_locations l ON d.location_id = l.location_id
WHERE
    e.job_id LIKE '%REP%';

--QUESTION 5
--a
SELECT DISTINCT
    c.LASTNAME,    
    c.CUSTOMER#    
FROM
    JL_CUSTOMERS c   
JOIN
    JL_ORDERS o ON c.CUSTOMER# = o.CUSTOMER#      
JOIN
    JL_ORDERITEMS i ON o."ORDER#" = i."ORDER#"     
JOIN
    JL_BOOKS b ON i.ISBN = b.ISBN            
WHERE
    c.STATE = 'FL'        
    AND b.CATEGORY = 'COMPUTER';  

--b
SELECT DISTINCT
    c.LASTNAME,  
    CUSTOMER#      
FROM
    JL_BOOKS b    
JOIN
    JL_ORDERITEMS i USING (ISBN) 
JOIN
    JL_ORDERS o USING ("ORDER#") 
JOIN
    JL_CUSTOMERS c USING (CUSTOMER#) 
WHERE
    c.STATE = 'FL'                                 
    AND b.CATEGORY = 'COMPUTER';                   
   

