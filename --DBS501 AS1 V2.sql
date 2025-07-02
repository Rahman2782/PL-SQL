--a1
--question 1
DECLARE
    v_height        NUMBER; 
    v_base          NUMBER; 
    v_side1         NUMBER; 
    v_side2         NUMBER; 
    v_side3         NUMBER; 

    v_area          NUMBER; 
    v_side_total    NUMBER; 

    v_selection     VARCHAR2(10); 

BEGIN

    DBMS_OUTPUT.PUT_LINE('Please enter the triangle dimensions:');
    v_height := &h;   
    v_base   := &b;   
    v_side1  := &s1;  
    v_side2  := &s2;  
    v_side3  := &s3;  

    DBMS_OUTPUT.PUT_LINE('Do you want to calculate Area (A) or Side Total (ST)?');
    v_selection := '&option'; 

    v_selection := UPPER(v_selection);

    IF v_selection = 'A' THEN
        v_area := (v_height * v_base) / 2;
        DBMS_OUTPUT.PUT_LINE('Area of this triangle is ' || v_area);
    ELSIF v_selection = 'ST' THEN
        v_side_total := v_side1 + v_side2 + v_side3;
        DBMS_OUTPUT.PUT_LINE('Total of sides for this triangle is ' || v_side_total);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Invalid selection. Please enter A for Area or ST for Side Total.');
    END IF;

EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Error: Invalid number entered. Please enter numeric values for dimensions.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/
UNDEFINE h;
UNDEFINE b;
UNDEFINE s1;
UNDEFINE s2;
UNDEFINE s3;
UNDEFINE option;

--question 2
DECLARE
    v_counter       NUMBER; 
    v_odd_count     NUMBER; 
    v_even_count    NUMBER; 
    v_div_count     NUMBER; 
BEGIN

    DBMS_OUTPUT.PUT_LINE('--- Number Sequences ---');

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'a. Numbers from 1 to 100:');
    v_counter := 1; 
    LOOP
        DBMS_OUTPUT.PUT_LINE(v_counter); 
        v_counter := v_counter + 1;      
        EXIT WHEN v_counter > 100;       
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'b. Numbers from 100 to 1:');
    FOR i IN REVERSE 1..100 LOOP 
        DBMS_OUTPUT.PUT_LINE(i); 
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'c. First 50 odd numbers:');
    v_counter   := 1; 
    v_odd_count := 0; 
    LOOP
        IF MOD(v_counter, 2) <> 0 THEN 
            DBMS_OUTPUT.PUT_LINE(v_counter); 
            v_odd_count := v_odd_count + 1; 
        END IF;
        v_counter := v_counter + 1;      
        EXIT WHEN v_odd_count = 50;      
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'd. First 50 even numbers:');
    FOR i IN 1..50 LOOP 
        DBMS_OUTPUT.PUT_LINE(i * 2); 
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || 'e. First 20 numbers divisible by 2 and 3:');
    v_counter := 1;  
    v_div_count := 0; 
    LOOP
        IF MOD(v_counter, 2) = 0 AND MOD(v_counter, 3) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_counter); 
            v_div_count := v_div_count + 1;  
        END IF;
        v_counter := v_counter + 1;       
        EXIT WHEN v_div_count = 20;       
    END LOOP;

    DBMS_OUTPUT.PUT_LINE(CHR(10) || '--- End of Sequences ---');

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/