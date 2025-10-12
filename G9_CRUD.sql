SET SERVEROUTPUT ON;

/*

checks the format for phone number and ensures its in the formate ###-###=####

*/

CREATE OR REPLACE FUNCTION IS_PHONE_VALID (P_INPUT in varchar2)
    RETURN BOOLEAN
AS
BEGIN
    IF NOT REGEXP_LIKE(P_INPUT, '\d{3}-\d{3}-\d{4}') THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
END IS_PHONE_VALID;
/

/*

checks the format for email and ensures it has characters before and after an @ symbol

*/

CREATE OR REPLACE FUNCTION IS_EMAIL_VALID (P_INPUT IN VARCHAR2)
    RETURN BOOLEAN
AS
BEGIN
    IF NOT REGEXP_LIKE(P_INPUT, '[A-Za-z0-9]@[A-Za-z0-9]') THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
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
    IF NOT REGEXP_LIKE(P_INPUT, '[0-9]{2}-[A-Z]{3}-[0-9]{4}') THEN
        RETURN FALSE;
    END IF;
    RETURN TRUE;
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

