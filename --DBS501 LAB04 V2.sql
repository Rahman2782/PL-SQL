--question 1
DECLARE
    v_criminal_id   CJ_CRIMINALS.CRIMINAL_ID%TYPE;
    v_state         CJ_CRIMINALS.STATE%TYPE;
    v_phone         CJ_CRIMINALS.PHONE%TYPE;
    v_v_status      CJ_CRIMINALS.V_STATUS%TYPE;
BEGIN
    v_criminal_id := &criminal_id;

    SELECT
        STATE,
        PHONE,
        V_STATUS
    INTO
        v_state,
        v_phone,
        v_v_status
    FROM
        CJ_CRIMINALS
    WHERE
        CRIMINAL_ID = v_criminal_id;

    IF v_state = 'VA' AND v_v_status = 'N' AND v_phone IS NULL THEN
        DBMS_OUTPUT.PUT_LINE(v_criminal_id || ' this criminal needs to report to main office');
    ELSIF v_state = 'VA' AND v_v_status = 'N' AND v_phone IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE(v_criminal_id || ' this criminal contact info is valid');
    ELSE
        DBMS_OUTPUT.PUT_LINE('No action is required');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Criminal ID ' || v_criminal_id || ' not found.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE criminal_id;

--question 2
DECLARE
    TYPE prob_officer_rec_type IS RECORD (
        p_last_name     CJ_PROB_OFFICERS.LAST%TYPE,
        p_first_name    CJ_PROB_OFFICERS.FIRST%TYPE,
        p_city          CJ_PROB_OFFICERS.CITY%TYPE,
        p_status        CJ_PROB_OFFICERS.STATUS%TYPE
    );

    v_prob_officer_info prob_officer_rec_type;

    v_prob_id           CJ_PROB_OFFICERS.PROB_ID%TYPE;

    v_new_pager_number  CJ_PROB_OFFICERS.PAGER#%TYPE;

BEGIN
    v_prob_id := &prob_id;

    SELECT
        LAST,
        FIRST,
        CITY,
        STATUS
    INTO
        v_prob_officer_info.p_last_name,
        v_prob_officer_info.p_first_name,
        v_prob_officer_info.p_city,
        v_prob_officer_info.p_status
    FROM
        CJ_PROB_OFFICERS
    WHERE
        PROB_ID = v_prob_id;

    DBMS_OUTPUT.PUT_LINE('--- Retrieved Officer Information ---');
    DBMS_OUTPUT.PUT_LINE('Prob ID: ' || v_prob_id);
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_prob_officer_info.p_first_name || ' ' || v_prob_officer_info.p_last_name);
    DBMS_OUTPUT.PUT_LINE('City: ' || v_prob_officer_info.p_city);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_prob_officer_info.p_status);
    DBMS_OUTPUT.PUT_LINE('-----------------------------------');

    IF v_prob_officer_info.p_status = 'A' THEN
        v_new_pager_number := '888555333';
        DBMS_OUTPUT.PUT_LINE('Status is A. Updating PAGER# to ' || v_new_pager_number);
    ELSIF v_prob_officer_info.p_status = 'I' THEN
        v_new_pager_number := '777555333';
        DBMS_OUTPUT.PUT_LINE('Status is I. Updating PAGER# to ' || v_new_pager_number);
    ELSE
        v_new_pager_number := '9996667788';
        DBMS_OUTPUT.PUT_LINE('Status is neither A nor I. Setting PAGER# to ' || v_new_pager_number);
    END IF;

    UPDATE CJ_PROB_OFFICERS
    SET PAGER# = v_new_pager_number
    WHERE PROB_ID = v_prob_id;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('PAGER# for Prob ID ' || v_prob_id || ' updated successfully.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Probation Officer with ID ' || v_prob_id || ' not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE prob_id;

--question 3

CREATE TABLE log_table (id INT);

DECLARE
    v_criminal_id   CJ_SENTENCES.CRIMINAL_ID%TYPE;
    v_sentence_count NUMBER;
BEGIN
    v_criminal_id := &criminal_id;

    SELECT
        COUNT(*)
    INTO
        v_sentence_count
    FROM
        CJ_SENTENCES
    WHERE
        CRIMINAL_ID = v_criminal_id;

    DBMS_OUTPUT.PUT_LINE('Criminal ID: ' || v_criminal_id);
    DBMS_OUTPUT.PUT_LINE('Total sentences found: ' || v_sentence_count);

    FOR i IN 1..v_sentence_count LOOP
        INSERT INTO log_table VALUES (i);
        DBMS_OUTPUT.PUT_LINE('Inserted ' || i || ' into log_table.');
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Log table updated successfully for Criminal ID ' || v_criminal_id || '.');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Criminal ID ' || v_criminal_id || ' not found in CJ_SENTENCES table.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/

--question 4
DECLARE
    v_sentence_id   CJ_SENTENCES.SENTENCE_ID%TYPE;
    v_criminal_id   CJ_SENTENCES.CRIMINAL_ID%TYPE;

    v_rows_updated  NUMBER;

BEGIN
    v_sentence_id := &sentence_id;

    v_criminal_id := &criminal_id;

    DBMS_OUTPUT.PUT_LINE('Attempting to update END_DATE for Sentence ID: ' || v_sentence_id || ' and Criminal ID: ' || v_criminal_id);

    UPDATE CJ_SENTENCES
    SET
        END_DATE = SYSDATE
    WHERE
        SENTENCE_ID = v_sentence_id AND CRIMINAL_ID = v_criminal_id;

    v_rows_updated := SQL%ROWCOUNT;

    IF v_rows_updated > 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE(v_rows_updated || ' row(s) updated successfully.');
        DBMS_OUTPUT.PUT_LINE('END_DATE set to SYSDATE for Sentence ID ' || v_sentence_id || ' and Criminal ID ' || v_criminal_id || '.');
    ELSE
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('No record found for Sentence ID ' || v_sentence_id || ' and Criminal ID ' || v_criminal_id || '. No update performed.');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
END;
/
UNDEFINE sentence_id;
