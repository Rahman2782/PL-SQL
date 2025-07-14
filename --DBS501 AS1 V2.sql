--a1
--question 1
DECLARE
    --declaring the vars to store the various values (number)
    v_height        NUMBER; 
    v_base          NUMBER; 
    v_side1         NUMBER; 
    v_side2         NUMBER; 
    v_side3         NUMBER; 

    v_area          NUMBER; 
    v_side_total    NUMBER; 

    v_selection     VARCHAR2(10); 

BEGIN
    --getting user input
    DBMS_OUTPUT.PUT_LINE('Please enter the triangle dimensions:');
    v_height := &h;   
    v_base   := &b;   
    v_side1  := &s1;  
    v_side2  := &s2;  
    v_side3  := &s3;  

    --presentning the choice to calculate either the sidde total or area based on the input
    DBMS_OUTPUT.PUT_LINE('Do you want to calculate Area (A) or Side Total (ST)?');
    v_selection := '&option'; 

    v_selection := UPPER(v_selection);

    --if user selected 'A' then area is calculated 
    IF v_selection = 'A' THEN
        v_area := (v_height * v_base) / 2; --calculating area
        DBMS_OUTPUT.PUT_LINE('Area of the triangle is ' || v_area); --displaying the area
    --if the user selected 'ST' then side total is calculated
    ELSIF v_selection = 'ST' THEN
        v_side_total := v_side1 + v_side2 + v_side3; --calculating side total
        DBMS_OUTPUT.PUT_LINE('Total of sides for the triangle is ' || v_side_total); --displaying ST
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERROR INVALID SELECTION');
    END IF;

EXCEPTION --exception handling for invalid inputs
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('ERROR NON-NUMERIC VALUE DETECTED');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('UNKNOWN ERROR' || SQLERRM);
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

-- question 4 --
DECLARE
    -- Defining VARRAY that can hold up to 5 numbers
    TYPE number_array_type IS VARRAY(5) OF NUMBER;

    --Declaring var of the defined type
    my_numbers number_array_type;

    --store min and max numbers here
    min_val NUMBER;
    max_val NUMBER;

BEGIN
    DBMS_OUTPUT.ENABLE;

    --Initialize VARARRAY
    my_numbers := number_array_type(45, 89, 72, 63, 68);

    -- Initialize vars with the first element of the array
    min_val := my_numbers(1);
    max_val := my_numbers(1);

    --Loop through the array starting from the second element
    FOR i IN 2..my_numbers.COUNT LOOP
        --is current element less than min_val?
        IF my_numbers(i) < min_val THEN
            --if yes, update min_val to current value
            min_val := my_numbers(i);
        END IF;

        --check if element is greater than max_val
        IF my_numbers(i) > max_val THEN
            --update max_val to the current value
            max_val := my_numbers(i);
        END IF;
    END LOOP;

    --printing final min value
    DBMS_OUTPUT.PUT_LINE('Minimum value: ' || min_val);

    --printing final max value
    DBMS_OUTPUT.PUT_LINE('Maximum value: ' || max_val);

END;
/

-- question 5 --
DECLARE
    --declaring input vars
    --stores the value of the distance.
    p_distance NUMBER := 1500; 
    p_unit     VARCHAR2(10) := 'METER'; 

    --vars to store calculated distance
    v_converted_distance NUMBER;
    v_target_unit        VARCHAR2(10);

BEGIN
    DBMS_OUTPUT.ENABLE;

    --print initial input
    DBMS_OUTPUT.PUT_LINE('Original Distance: ' || p_distance || ' ' || p_unit);

    -- Outer IF statement: Check the input unit (case-insensitive comparison using UPPER).
    IF UPPER(p_unit) = 'METER' THEN
        --if input is m, convert to km.
        IF p_distance >= 0 THEN --making sure distance is not negative
            v_converted_distance := p_distance / 1000; --1km = 1000m
            v_target_unit        := 'KILOMETER';
            DBMS_OUTPUT.PUT_LINE('Converting from Meters to Kilometers:');
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR NEGATIVE DISTANCE');
        END IF;

    ELSIF UPPER(p_unit) = 'KILOMETER' THEN
        --if input is km, convert to m.
        IF p_distance >= 0 THEN --making sure distance is not negative
            v_converted_distance := p_distance * 1000; --1km = 1000m
            v_target_unit        := 'METER';
            DBMS_OUTPUT.PUT_LINE('Converting from Kilometers to Meters:');
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR NEGATIVE DISTANCE');
        END IF;

    ELSE
        --if input unit is neither 'm' or 'km', it's invalid 
        v_converted_distance := NULL; --set distance to NULL for invalid input
        v_target_unit        := 'N/A';
        DBMS_OUTPUT.PUT_LINE('ERROR INVALID UNIT');
    END IF;

    --print conversion result if valid
    IF v_converted_distance IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Converted Distance: ' || v_converted_distance || ' ' || v_target_unit);
    END IF;


END;
/

-- question 6 --
DECLARE
    --vars for measurement values + units
    p_value NUMBER := 15; 
    p_unit  VARCHAR2(10) := 'FOOT'; 

    --vars to store the converted value and its unit
    v_converted_value NUMBER;
    v_target_unit     VARCHAR2(10);

    --defining the conversion constant
    C_FOOT_TO_CM_FACTOR CONSTANT NUMBER := 30.48;

BEGIN
    DBMS_OUTPUT.ENABLE;

    --displaying the initial values
    DBMS_OUTPUT.PUT_LINE('Original Measurement: ' || p_value || ' ' || p_unit);

    --check the input unit 
    IF UPPER(p_unit) = 'FOOT' OR UPPER(p_unit) = 'FT' THEN
        --if the input unit is FT then convert to CM.
        --check if the input value is not negative
        IF p_value >= 0 THEN
            --performing conversion
            v_converted_value := p_value * C_FOOT_TO_CM_FACTOR;
            v_target_unit     := 'CM';
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR CANNOT BE NEGATIVE');
            --set value to NULL for invalid conversion.
            v_converted_value := NULL;
        END IF;

    ELSIF UPPER(p_unit) = 'CENTIMETER' OR UPPER(p_unit) = 'CM' THEN
        --if the input unit is CM, convert to FT.
        --check if the input value is not negative
        IF p_value >= 0 THEN
            --performing conversion for cm -> ft
            v_converted_value := p_value / C_FOOT_TO_CM_FACTOR;
            v_target_unit     := 'FOOT';
        ELSE
            DBMS_OUTPUT.PUT_LINE('ERROR CANNOT BE NEGATIVE');
            --set value to NULL for invalid conversion.
            v_converted_value := NULL;
        END IF;
    END IF;

    --print conversion result if succesful
    IF v_converted_value IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Converted Measurement: ' || v_converted_value || ' ' || v_target_unit);
    END IF;


END;
/

-- question 7 --
--creating the messages table 
TRUNCATE TABLE messages;

CREATE TABLE messages
(  
    RESULTS  NUMBER
);

SELECT * FROM messages; --checking to see if its empty

--block to insert 1, 2, 3, 4, 5, 7, 9, 10 
DECLARE

BEGIN
    DBMS_OUTPUT.ENABLE;

    --looping from 1 - 10
    FOR i IN 1..10 LOOP
        --check if current num is not 6 or 8
        IF i NOT IN (6, 8) THEN
            --if num is not 6 or 8 insert it into messages
            INSERT INTO messages (RESULTS) VALUES (i);
        END IF;
    END LOOP;

    --commiting changes to table
    COMMIT;

    DBMS_OUTPUT.PUT_LINE('anonymous block completed.');

END;
/

-- question 8 --
DECLARE
    --var to hold marks
    --initalizing with a randopm value
    p_marks NUMBER := 65;

    --var to hold letter grade
    v_grade VARCHAR2(1); 

BEGIN
    DBMS_OUTPUT.ENABLE;

    --initial marks displayed
    DBMS_OUTPUT.PUT_LINE('Student Marks: ' || p_marks);
    DBMS_OUTPUT.PUT_LINE('--- Determining Grade ---');


    --Grade A: Marks are 70 or higher
    IF p_marks >= 70 THEN
        v_grade := 'A'; --if above 70, 'A' is assigned

    --Grade B: Marks are between 40 and 69
    ELSIF p_marks >= 40 AND p_marks < 70 THEN
        v_grade := 'B'; 

    --Grade C: Marks are between 35 and 39 
    ELSIF p_marks >= 35 AND p_marks < 40 THEN
        v_grade := 'C'; 

    END IF; 

    --printing the final grade:
    --check if grade was assigned to handle cases where marks are below 35
    IF v_grade IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Assigned Grade: ' || v_grade);
    ELSE
        --marks dont meet criteria
        DBMS_OUTPUT.PUT_LINE('Assigned Grade: N/A');
    END IF;
END;
/


-- question 9 --
DECLARE
    --declaring vcars to hold 3 random numbers
    a NUMBER := 34; 
    b NUMBER := 7; 
    c NUMBER := 53; 
    v_greatest NUMBER; --stores greatest num out of the 3 above

BEGIN
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('Numbers are: a = ' || a || ', b = ' || b || ', c = ' || c); --shows the numbers being compared

    --the outer IF compares a and b
    IF (a > b) THEN
        --if a > b it is in the running for greatest number
        --IF compares a and c
        IF (a > c) THEN
            v_greatest := a; --if a > c, a is the greatest
        ELSE
            v_greatest := c; --if c > a, c is the greatest
        END IF;
    ELSE
        --if b >= a, it is in the running to be the greatest
        --IF compares b and c
        IF (b > c) THEN
            v_greatest := b; --if b > c then b is the greatest
        ELSE
            v_greatest := c; --if c > b then c is the greatest
        END IF;
    END IF;

    --printing the result
    DBMS_OUTPUT.PUT_LINE('The greatest number is: ' || v_greatest);

END;
/

-- question 10 -- 
DECLARE
    --var to hold num of sides
    v_side  NUMBER(5) := &side;
    --var to hold shape name
    v_shape VARCHAR2(20);

BEGIN
    DBMS_OUTPUT.ENABLE;

    --displaying side count from input
    DBMS_OUTPUT.PUT_LINE('Input Side Count: ' || v_side);

    --converting CASE logic to IF structure
    --WHEN becomes  ELSIF
    --ELSE handles everything else that isnt mentioned
    IF v_side = 3 THEN
        v_shape := 'Triangle'; --assign 'Triangle' if v_side is 3.
    ELSIF v_side = 4 THEN
        v_shape := 'Rectangle'; --assign 'Rectangle' if v_side is 4.
    ELSIF v_side = 5 THEN
        v_shape := 'Pentagon'; --assign 'Pentagon' if v_side is 5.
    ELSIF v_side = 6 THEN
        v_shape := 'Hexagon'; --assign 'Hexagon' if v_side is 6.
    ELSIF v_side = 8 THEN
        v_shape := 'Octagon'; --assign 'Octagon' if v_side is 8.
    ELSE
        v_shape := 'No such shape'; --assign if nothing matches
    END IF; 

    --printing result including the side count and shape name
    DBMS_OUTPUT.PUT_LINE('Side: ' || v_side || '   Shape: ' || v_shape);
END;
/