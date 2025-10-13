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
    P_DATE DATE;
BEGIN
    IF P_INPUT IS NULL THEN
        RETURN FALSE;
    ELSIF NOT REGEXP_LIKE(P_INPUT, '^\d{2}-[A-Z]{3}-\d{4}$') THEN
        RETURN FALSE;
    END IF;
    P_DATE := TO_DATE(P_INPUT, 'DD-MON-YYYY');
    RETURN TRUE;
EXCEPTION
    WHEN OTHERS THEN
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
        ELSE RETURN FALSE;
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

/*

function for adding a new client to the database

*/

CREATE OR REPLACE PROCEDURE CREATE_CLIENT
(P_CUSTOMERID IN VARCHAR2, 
 P_FIRSTNAME IN VARCHAR2, 
 P_LASTNAME IN VARCHAR2, 
 P_EMAIL VARCHAR2, 
 P_PHONE VARCHAR2, 
 P_ADDRESS VARCHAR2, 
 P_CITY VARCHAR2, 
 P_STATE VARCHAR2)
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

/*

function for adding a new booking to the database

*/

CREATE OR REPLACE PROCEDURE CREATE_BOOKING
(P_BOOKINGID IN VARCHAR2, 
 P_CUSTOMERID IN VARCHAR2, 
 P_LISTINGID IN VARCHAR2, 
 P_BOOKINGDATE IN VARCHAR2,
 P_PAYMENTMETHOD IN VARCHAR2, 
 P_STARTDATE IN VARCHAR2, 
 P_ENDDATE IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_BOOKINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid booking id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_CUSTOMERID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid customer id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid listing id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_DATE_VALID(P_BOOKINGDATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid booking date');
    ELSIF NOT IS_DATE_VALID(P_STARTDATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid start date format');
    ELSIF NOT IS_DATE_VALID(P_ENDDATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid end date');
    ELSIF NOT IS_PAYMENT_METHOD_VALID(P_PAYMENTMETHOD) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid payment method, please choose between: Credit Card, Debit Card, Apple Pay, PayPal, or Google Pay');
    END IF;
    INSERT INTO BOOKING VALUES(P_BOOKINGID, P_CUSTOMERID, P_LISTINGID, TO_DATE(P_BOOKINGDATE, 'DD-MON-YYYY'), UPPER(TRIM(P_PAYMENTMETHOD)), TO_DATE(P_STARTDATE, 'DD-MON-YYYY'), TO_DATE(P_ENDDATE, 'DD-MON-YYYY'));
    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSIF SQLCODE = -02291 THEN
            DBMS_OUTPUT.PUT_LINE('invalid foreign key, please enter an existing foreign key');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
    
END;
/

/*

function for adding a new review to the database

*/

CREATE OR REPLACE PROCEDURE CREATE_REVIEW
(P_REVIEWID IN REVIEW.REVIEWID%TYPE,
 P_LISTINGID IN REVIEW.LISTINGID%TYPE,
 P_CUSTOMERID IN REVIEW.CUSTOMERID%TYPE,
 P_RATING IN VARCHAR2,
 P_DESCRIPTION IN REVIEW.DESCRIPTION%TYPE,
 P_DATEPOSTED IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_REVIEWID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid review id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid listing id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_CUSTOMERID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid customer id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_DATE_VALID(P_DATEPOSTED) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid date posted');
    END IF;
    
    INSERT INTO REVIEW VALUES (P_REVIEWID, P_LISTINGID, P_CUSTOMERID, TO_NUMBER(P_RATING), P_DESCRIPTION, TO_DATE(P_DATEPOSTED, 'DD-MON-YYYY'));
    
    DBMS_OUTPUT.PUT_LINE('success');
    
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN INVALID_NUMBER THEN
        DBMS_OUTPUT.PUT_LINE('invalid number entered');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSIF SQLCODE = -02291 THEN
            DBMS_OUTPUT.PUT_LINE('invalid foreign key, please enter an existing foreign key');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_HOST
(P_HOSTID IN VARCHAR2,
 P_FIRSTNAME IN VARCHAR2,
 P_LASTNAME IN VARCHAR2,
 P_EMAIL IN VARCHAR2,
 P_PHONE IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_HOSTID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid host id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_EMAIL_VALID(P_EMAIL) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid email');
    ELSIF NOT IS_PHONE_VALID(P_PHONE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid phone');
    END IF;
    
    INSERT INTO HOST VALUES(P_HOSTID, P_FIRSTNAME, P_LASTNAME, P_EMAIL, P_PHONE);
    
    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_LISTING
(P_LISTINGID IN VARCHAR2,
 P_HOSTID IN VARCHAR2,
 P_DATEPOSTED IN VARCHAR2,
 P_PRICEPERNIGHT IN VARCHAR2,
 P_DESCRIPTION IN VARCHAR2,
 P_BEDROOMNUM IN VARCHAR2,
 P_BATHROOMNUM IN VARCHAR2,
 P_CITY IN VARCHAR2,
 P_STATE IN VARCHAR2,
 P_ADDRESS IN VARCHAR2,
 P_TITLE IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid listing id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_HOSTID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid host id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_DATE_VALID(P_DATEPOSTED) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid date posted');
    ELSIF NOT IS_STATE_VALID(P_STATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid state');
    END IF;
    
    INSERT INTO LISTING VALUES(P_LISTINGID, P_HOSTID, TO_DATE(P_DATEPOSTED, 'DD-MON-YYYY'), TO_NUMBER(P_PRICEPERNIGHT), P_DESCRIPTION, TO_NUMBER(P_BEDROOMNUM), TO_NUMBER(P_BATHROOMNUM), P_CITY, P_STATE, P_ADDRESS, P_TITLE);
    
    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSIF SQLCODE = -02291 THEN
            DBMS_OUTPUT.PUT_LINE('invalid foreign key, please enter an existing foreign key');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_DATES_AVAILABLE
(P_DATEID IN VARCHAR2,
 P_LISTINGID IN VARCHAR2,
 P_STARTDATE IN VARCHAR2,
 P_ENDDATE IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_DATEID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid date id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid listing id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_DATE_VALID(P_STARTDATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid start posted');
    ELSIF NOT IS_DATE_VALID(P_ENDDATE) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid end posted');
    END IF;
    
    INSERT INTO DATES_AVAILABLE VALUES(P_DATEID, P_LISTINGID, TO_DATE(P_STARTDATE, 'DD-MON-YYYY'), TO_DATE(P_ENDDATE, 'DD-MON-YYYY'));

    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSIF SQLCODE = -02291 THEN
            DBMS_OUTPUT.PUT_LINE('invalid foreign key, please enter an existing foreign key');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_AMENITY
(P_AMENITYID IN VARCHAR2,
 P_NAME IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_AMENITYID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid amenity id, please use the format A### where A is a capitalized character');
    END IF;
    
    INSERT INTO AMENITY VALUES(P_AMENITYID, P_NAME);
    
    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/

CREATE OR REPLACE PROCEDURE CREATE_LISTING_AMENITY
(P_AMENITYID IN VARCHAR2,
 P_LISTINGID IN VARCHAR2)
AS
    INVALID_INPUT EXCEPTION;
    PRAGMA EXCEPTION_INIT(INVALID_INPUT, -20111);
BEGIN  
    IF NOT IS_ID_VALID(P_AMENITYID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid amenity id, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111,  'invalid amenity id, please use the format A### where A is a capitalized character');
    END IF;
    
    INSERT INTO LISTING_AMENITY VALUES(P_AMENITYID, P_LISTINGID);

    DBMS_OUTPUT.PUT_LINE('success');
EXCEPTION
    WHEN INVALID_INPUT THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('primary key has already been used, please use a different one');
    WHEN OTHERS THEN
        IF SQLCODE = -12899 THEN
            DBMS_OUTPUT.PUT_LINE('inputted string to large');
        ELSIF SQLCODE = -02291 THEN
            DBMS_OUTPUT.PUT_LINE('invalid foreign key, please enter an existing foreign key');
        ELSE
            DBMS_OUTPUT.PUT_LINE(SQLERRM);
        END IF;
END;
/
