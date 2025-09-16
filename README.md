# PL-SQL
The code consists of various SQL exercises that cover essential PL/SQL concepts including variable declarations, user input handling, conditional statements, loops, arrays (VARRAYs), exception handling, and database operations. This readme will highlight my work for as2, since all concepts I learned are present here.

## Questions and Concepts
### Question 1: Triangle Calculator with User Input
**Concepts Learned:**
- Variable declaration with different data types (NUMBER, VARCHAR2)
- User input using substitution variables (&variable)
- Conditional logic with IF-ELSIF-ELSE statements
- String manipulation with UPPER() function
- Exception handling (VALUE_ERROR, OTHERS)
- Variable cleanup with UNDEFINE

This segment calculates either the area or perimeter of a triangle based on user input. It demonstrates input validation, conditional processing, and proper exception handling for non-numeric inputs.
___
### Question 2: Number Sequences with Different Loop Types
**Concepts Learned:**
- Basic LOOP with EXIT WHEN condition
- FOR loops with REVERSE keyword
- Modular arithmetic using MOD() function
- Loop counters and conditional logic within loops
- Output formatting with CHR(10) for line breaks

Demonstrates various looping constructs by generating different number sequences:
- Numbers 1 to 100 (basic loop)
- Numbers 100 to 1 (reverse for loop)
- First 50 odd numbers (conditional loop)
- First 50 even numbers (for loop with multiplication)
- First 20 numbers divisible by both 2 and 3 (complex conditional loop)
___
### Question 4: VARRAY Operations - Min/Max Finder
**Concepts Learned:**
- VARRAY (Variable Array) declaration and initialization
- Custom data type creation with TYPE statement
- Array traversal using FOR loops
- Array properties (.COUNT)
- Comparison algorithms for finding minimum and maximum values

Creates a VARRAY of 5 numbers and finds the minimum and maximum values through array iteration, demonstrating Oracle's collection data types.
___
### Question 5: Distance Conversion (Meters ↔ Kilometers)
**Concepts Learned:**
- Nested IF statements
- Input validation (non-negative values)
- Case-insensitive string comparison with UPPER()
- Mathematical conversions
- Error handling for invalid units

Converts distances between meters and kilometers with proper validation and error handling for negative values and invalid units.
___
### Question 6: Length Conversion (Feet ↔ Centimeters)
**Concepts Learned:**
- Constants declaration with CONSTANT keyword
- Multiple unit name recognition (FOOT/FT, CENTIMETER/CM)
- Conversion factor usage
- Input validation and error messaging

Performs bidirectional conversion between feet and centimeters using a predefined conversion constant, with support for multiple unit name formats.
___
### Question 7: Database Operations with Conditional Inserts
**Concepts Learned:**
- Table creation and manipulation (CREATE TABLE, TRUNCATE)
- INSERT statements within PL/SQL blocks
- NOT IN operator for exclusion logic
- Transaction control with COMMIT
- Database querying with SELECT

Creates and populates a database table with numbers 1-10, excluding 6 and 8, demonstrating database operations within PL/SQL blocks.
___
### Question 8: Grade Assignment System
**Concepts Learned:**
- Multi-level conditional logic
- Grade classification algorithms
- Range-based comparisons
- NULL handling for edge cases

Assigns letter grades (A, B, C) based on numerical marks using a tiered grading system with proper handling of marks below the minimum threshold.
___
### Question 9: Finding Maximum of Three Numbers
**Concepts Learned:**
- Nested IF statements for complex comparisons
- Multi-way comparison logic
- Variable initialization and comparison algorithms

Determines the largest of three numbers using nested conditional statements, demonstrating systematic comparison techniques.
___
### Question 10: Shape Identification by Sides
**Concepts Learned:**
- IF-ELSIF chains as an alternative to CASE statements
- Shape classification logic
- User input with data type specification (NUMBER(5))
- Default case handling

Identifies geometric shapes based on the number of sides input by the user, converting traditional CASE logic to IF-ELSIF structure.
