SET SERVEROUTPUT ON;

/*

checks the format for phone number and ensures its in the formate ###-###=####

*/

CREATE OR REPLACE FUNCTION IS_PHONE_VALID (P_INPUT in varchar2)
    RETURN BOOLEAN
AS
BEGIN
    IF REGEXP_LIKE(P_INPUT, '^\d{3}-\d{3}-\d{4}$') THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END IS_PHONE_VALID;
/


/*

checks the format for email and ensures it has characters before and after an @ symbol

*/

CREATE OR REPLACE FUNCTION IS_EMAIL_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    IF REGEXP_LIKE(P_INPUT, '[A-Za-z0-9]@[A-Za-z0-9]') THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END IS_EMAIL_VALID;
/

/*

checks the format for date and ensures it has the format DD-MON-YYYY
does not validate if it is a date only the format

*/

CREATE OR REPLACE FUNCTION IS_DATE_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    IF REGEXP_LIKE(P_INPUT, '^[0-9]{2}-[A-Z]{3}-[0-9]{4}$') THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END IS_DATE_VALID;
/

/*

checks if the user enters a valid option for payment method

*/

CREATE OR REPLACE FUNCTION IS_PAYMENT_METHOD_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    CASE UPPER(TRIM(P_INPUT))
        WHEN 'CREDIT CARD' THEN
            RETURN TRUE;
        WHEN 'DEBIT CARD' THEN
            RETURN TRUE;
        WHEN 'CHECK' THEN
            RETURN TRUE;
        WHEN 'APPLE PLAY' THEN
            RETURN TRUE;
        WHEN 'PAYPAL' THEN
            RETURN TRUE;
        WHEN 'GOOGLE PAY' THEN
            RETURN TRUE;
    END CASE;
    RETURN FALSE;
END IS_PAYMENT_METHOD_VALID;
/

/*

checks the format for state and ensures use the format AA

*/

CREATE OR REPLACE FUNCTION IS_STATE_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    IF REGEXP_LIKE(P_INPUT, '^[A-Z]{2}$') THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END IS_STATE_VALID;
/

/*

checks the format for state and ensures use the format A###

*/

CREATE OR REPLACE FUNCTION IS_ID_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    IF REGEXP_LIKE(P_INPUT, '^[A-Z]{1}\d{3}$') THEN
        RETURN TRUE;
    END IF;
    RETURN FALSE;
END IS_ID_VALID;
/

CREATE OR REPLACE PROCEDURE CREATE_CLIENT
(P_CUSTOMERID IN CLIENT.CUSTOMERID%TYPE, P_FIRSTNAME IN CLIENT.FIRSTNAME%TYPE, P_LASTNAME IN CLIENT.LASTNAME%TYPE, P_EMAIL CLIENT.EMAIL%TYPE, P_PHONE CLIENT.PHONE%TYPE, P_ADDRESS CLIENT.ADDRESS%TYPE, P_CITY CLIENT.CITY%TYPE, P_STATE CLIENT.STATE%TYPE)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
    
BEGIN
    IF NOT IS_ID_VALID(P_CUSTOMERID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid customer id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_EMAIL_VALID(P_EMAIL) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid email');
    ELSIF NOT IS_PHONE_VALID(P_PHONE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid phone number, please use the ###-###-#### format');
    ELSIF NOT IS_STATE_VALID(P_STATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid state, please use the AA format where A is a capitalized character');
    END IF;
    
    INSERT INTO CLIENT VALUES(P_CUSTOMERID, P_FIRSTNAME, P_LASTNAME, P_EMAIL, P_PHONE, P_ADDRESS, P_CITY, P_STATE);
    
    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        END IF;
END;
/

EXEC CREATE_CLIENT('C052', 'Jake', 'Peralta', 'jperalta@gmail.com', '000-000-0000', '320 fake address st', 'Brooklyn', 'NY')