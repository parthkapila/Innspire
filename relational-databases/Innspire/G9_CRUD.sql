SET SERVEROUTPUT ON;

/*

checks the format for phone number and ensures its in the formatok ###-###=####

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
    IF REGEXP_LIKE(P_INPUT, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$') THEN
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
        WHEN 'APPLE PAY' THEN
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
        RAISE_APPLICATION_ERROR(-20111,  'invalid listing id, please use the format A### where A is a capitalized character');
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
--------------------------------------------------------------------------------
-- READ OPERATIONS
-- Purpose: Implement Read and Search functions for Listings, Clients, and Reviews
--------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

/*
Procedure: GET_LISTING_DETAILS
Displays full listing information given a listing ID.
Uses validation and exception handling.
*/
CREATE OR REPLACE PROCEDURE GET_LISTING_DETAILS (
    P_LISTINGID IN VARCHAR2
)
AS
    V_LISTING LISTING%ROWTYPE;
BEGIN
    IF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid listing ID format. Use A### where A is a capitalized character.');
    END IF;

    SELECT * INTO V_LISTING
    FROM LISTING
    WHERE LISTINGID = P_LISTINGID;

    DBMS_OUTPUT.PUT_LINE('Listing ID: ' || V_LISTING.LISTINGID);
    DBMS_OUTPUT.PUT_LINE('Title: ' || V_LISTING.TITLE);
    DBMS_OUTPUT.PUT_LINE('City: ' || V_LISTING.CITY);
    DBMS_OUTPUT.PUT_LINE('State: ' || V_LISTING.STATE);
    DBMS_OUTPUT.PUT_LINE('Price per Night: $' || V_LISTING.PRICEPERNIGHT);
    DBMS_OUTPUT.PUT_LINE('Description: ' || V_LISTING.DESCRIPTION);

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No listing found with ID: ' || P_LISTINGID);
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Invalid data type encountered.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

/*
Procedure: SEARCH_LISTINGS_BY_CITY
Displays all listings in a given city using a CURSOR FOR loop.
*/
CREATE OR REPLACE PROCEDURE SEARCH_LISTINGS_BY_CITY (
    P_CITY IN VARCHAR2
)
AS
BEGIN
    FOR R IN (
        SELECT LISTINGID, TITLE, PRICEPERNIGHT, STATE
        FROM LISTING
        WHERE UPPER(CITY) = UPPER(TRIM(P_CITY))
        ORDER BY PRICEPERNIGHT
    )
    LOOP
        DBMS_OUTPUT.PUT_LINE('Listing ID: ' || R.LISTINGID || 
                             ', Title: ' || R.TITLE ||
                             ', Price per Night: $' || R.PRICEPERNIGHT ||
                             ', State: ' || R.STATE);
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('End of listings for city: ' || P_CITY);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No listings found in the specified city.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

/*
Procedure: SEARCH_LISTINGS_BY_PRICE_RANGE
Uses an explicit cursor to find listings between two price values.
Demonstrates use of WHILE LOOP and explicit cursor control.
*/
CREATE OR REPLACE PROCEDURE SEARCH_LISTINGS_BY_PRICE_RANGE (
    P_MIN_PRICE IN NUMBER,
    P_MAX_PRICE IN NUMBER
)
AS
    CURSOR C_LISTINGS IS
        SELECT LISTINGID, TITLE, CITY, STATE, PRICEPERNIGHT
        FROM LISTING
        WHERE PRICEPERNIGHT BETWEEN P_MIN_PRICE AND P_MAX_PRICE
        ORDER BY PRICEPERNIGHT;
    V_REC C_LISTINGS%ROWTYPE;
BEGIN
    OPEN C_LISTINGS;
    LOOP
        FETCH C_LISTINGS INTO V_REC;
        EXIT WHEN C_LISTINGS%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('[' || V_REC.LISTINGID || '] ' ||
                             V_REC.TITLE || ' - $' || V_REC.PRICEPERNIGHT ||
                             ' (' || V_REC.CITY || ', ' || V_REC.STATE || ')');
    END LOOP;
    CLOSE C_LISTINGS;

    DBMS_OUTPUT.PUT_LINE('Search completed for price range: ' || P_MIN_PRICE || ' - ' || P_MAX_PRICE);
EXCEPTION
    WHEN VALUE_ERROR THEN
        DBMS_OUTPUT.PUT_LINE('Invalid numeric input for price range.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

/*
Procedure: SEARCH_REVIEWS_BY_RATING
Displays reviews matching a given minimum rating using CASE and loops.
*/
CREATE OR REPLACE PROCEDURE SEARCH_REVIEWS_BY_RATING (
    P_MIN_RATING IN NUMBER
)
AS
BEGIN
    FOR R IN (
        SELECT REVIEWID, CUSTOMERID, LISTINGID, RATING, DESCRIPTION
        FROM REVIEW
        WHERE RATING >= P_MIN_RATING
        ORDER BY RATING DESC
    )
    LOOP
        CASE 
            WHEN R.RATING = 5 THEN
                DBMS_OUTPUT.PUT_LINE('***** ' || R.DESCRIPTION);
            WHEN R.RATING >= 3 THEN
                DBMS_OUTPUT.PUT_LINE('*** ' || R.DESCRIPTION);
            ELSE
                DBMS_OUTPUT.PUT_LINE('* Low rating - ' || R.DESCRIPTION);
        END CASE;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Displayed all reviews with rating >= ' || P_MIN_RATING);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No reviews found with rating above ' || P_MIN_RATING);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Unexpected error: ' || SQLERRM);
END;
/

-- Update Procedures

/*
Updating Host Tables
*/

CREATE OR REPLACE PROCEDURE UPDATE_HOST_FIRSTNAME
(P_HID IN CHAR, P_HFIRSTNAME IN VARCHAR2)
AS
BEGIN
    UPDATE HOST
    SET FIRSTNAME = P_HFIRSTNAME
    WHERE HOSTID = P_HID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('HOSTID ' || P_HID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Host first name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating host: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_HOST_LASTNAME
(P_HID IN CHAR, P_HLASTNAME IN VARCHAR2)
AS
BEGIN
    UPDATE HOST
    SET LASTNAME = P_HLASTNAME
    WHERE HOSTID = P_HID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('HOSTID ' || P_HID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Host last name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating host: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_HOST_EMAIL
(P_HID IN CHAR, P_HEMAIL IN VARCHAR2)
AS
BEGIN
    UPDATE HOST
    SET EMAIL = P_HEMAIL
    WHERE HOSTID = P_HID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('HOSTID ' || P_HID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Host email updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating host: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_HOST_PHONE
(P_HID IN CHAR, P_HPHONE IN CHAR)
AS
BEGIN
    UPDATE HOST
    SET PHONE = P_HPHONE
    WHERE HOSTID = P_HID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('HOSTID ' || P_HID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Host phone updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating host: ' || SQLERRM);
END;
/

/*
Update Client Tables
*/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_FIRSTNAME
(P_CID IN CHAR, P_CFIRSTNAME IN VARCHAR2)
AS
BEGIN
    UPDATE CLIENT
    SET FIRSTNAME = P_CFIRSTNAME
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client first name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_LASTNAME
(P_CID IN CHAR, P_CLASTNAME IN VARCHAR2)
AS
BEGIN
    UPDATE CLIENT
    SET LASTNAME = P_CLASTNAME
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client last name updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_EMAIL
(P_CID IN CHAR, P_CEMAIL IN VARCHAR2)
AS
BEGIN
    UPDATE CLIENT
    SET EMAIL = P_CEMAIL
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client email updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_PHONE
(P_CID IN CHAR, P_CPHONE IN CHAR)
AS
BEGIN
    UPDATE CLIENT
    SET PHONE = P_CPHONE
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client phone updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_ADDR
(P_CID IN CHAR, P_CADDR IN VARCHAR2)
AS
BEGIN
    UPDATE CLIENT
    SET ADDRESS = P_CADDR
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client address updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_CITY
(P_CID IN CHAR, P_CCITY IN VARCHAR2)
AS
BEGIN
    UPDATE CLIENT
    SET CITY = P_CCITY
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client city updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CLIENT_STATE
(P_CID IN CHAR, P_CSTATE IN CHAR)
AS
BEGIN
    UPDATE CLIENT
    SET STATE = P_CSTATE
    WHERE CUSTOMERID = P_CID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('CLIENTID ' || P_CID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Client state updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating client: ' || SQLERRM);
END;
/

/*
Update Listing tables
*/

CREATE OR REPLACE PROCEDURE UPDATE_LISTING_PRICEPERNIGHT
(P_LID IN CHAR, P_LPRICE IN NUMBER)
AS
BEGIN
    UPDATE LISTING
    SET PRICEPERNIGHT = P_LPRICE
    WHERE LISTINGID = P_LID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LISTINGID ' || P_LID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Listing price updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating listing: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_LISTING_DESC
(P_LID IN CHAR, P_LDESC IN VARCHAR2)
AS
BEGIN
    UPDATE LISTING
    SET DESCRIPTION = P_LDESC
    WHERE LISTINGID = P_LID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LISTINGID ' || P_LID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Listing description updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating listing: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_LISTING_TITLE
(P_LID IN CHAR, P_LTITLE IN VARCHAR2)
AS
BEGIN
    UPDATE LISTING
    SET TITLE = P_LTITLE
    WHERE LISTINGID = P_LID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LISTINGID ' || P_LID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Listing title updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating listing: ' || SQLERRM);
END;
/

/*
Update Dates Available
*/

CREATE OR REPLACE PROCEDURE UPDATE_DATESAVAIL_STARTDATE
(P_LID IN CHAR, P_DSTARTDATE IN DATE)
AS
BEGIN
    UPDATE DATES_AVAILABLE
    SET STARTDATE = P_DSTARTDATE
    WHERE LISTINGID = P_LID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LISTINGID ' || P_LID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Start date updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating start date: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_DATESAVAIL_ENDDATE
(P_LID IN CHAR, P_DENDDATE IN DATE)
AS
BEGIN
    UPDATE DATES_AVAILABLE
    SET ENDDATE = P_DENDDATE
    WHERE LISTINGID = P_LID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('LISTINGID ' || P_LID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('End date updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating end date: ' || SQLERRM);
END;
/

/*
Update Reviews
*/

CREATE OR REPLACE PROCEDURE UPDATE_REVIEW_RATING
(P_RID IN CHAR, P_RRATING IN NUMBER)
AS
BEGIN
    UPDATE REVIEW
    SET RATING = P_RRATING
    WHERE REVIEWID = P_RID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('REVIEWID ' || P_RID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Review rating updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating review: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_REVIEW_DESC
(P_RID IN CHAR, P_RDESC IN VARCHAR2)
AS
BEGIN
    UPDATE REVIEW
    SET DESCRIPTION = P_RDESC
    WHERE REVIEWID = P_RID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('REVIEWID ' || P_RID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Review description updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating review: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_REVIEW_DATEPOSTED
(P_RID IN CHAR, P_RDATE IN DATE)
AS
BEGIN
    UPDATE REVIEW
    SET DATEPOSTED = P_RDATE
    WHERE REVIEWID = P_RID;
    
    IF SQL%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('REVIEWID ' || P_RID || ' is not found.');
    ELSE
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Review date posted updated successfully.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error updating review: ' || SQLERRM);
END;
/

-- End Updates

--------------------------------------------------------------------------------
-- DELETE OPERATIONS
--------------------------------------------------------------------------------

/*
Procedure: DELETE_BOOKING
Deletes a booking record by BookingID.
Includes validation and exception handling.
*/

CREATE OR REPLACE PROCEDURE DELETE_BOOKING
(P_BOOKINGID IN VARCHAR2)
AS
    V_CUSTOMERID BOOKING.CUSTOMERID%TYPE;
    V_LISTINGID BOOKING.LISTINGID%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_BOOKINGID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid booking ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM BOOKING
        WHERE BOOKINGID = P_BOOKINGID
        RETURNING CUSTOMERID, LISTINGID INTO V_CUSTOMERID, V_LISTINGID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Booking ' || P_BOOKINGID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Booking ' || P_BOOKINGID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: Customer ' || V_CUSTOMERID || ', Listing ' || V_LISTINGID);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting booking: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_REVIEW
(P_REVIEWID IN VARCHAR2)
AS
    V_CUSTOMERID REVIEW.CUSTOMERID%TYPE;
    V_LISTINGID REVIEW.LISTINGID%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_REVIEWID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid review ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM REVIEW
        WHERE REVIEWID = P_REVIEWID
        RETURNING CUSTOMERID, LISTINGID INTO V_CUSTOMERID, V_LISTINGID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Review ' || P_REVIEWID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Review ' || P_REVIEWID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: Customer ' || V_CUSTOMERID || ', Listing ' || V_LISTINGID);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting review: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_DATES_AVAILABLE
(P_DATEID IN VARCHAR2)
AS
    V_LISTINGID DATES_AVAILABLE.LISTINGID%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_DATEID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid date ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM DATES_AVAILABLE
        WHERE DATEID = P_DATEID
        RETURNING LISTINGID INTO V_LISTINGID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Date ' || P_DATEID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Date ' || P_DATEID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: Listing ' || V_LISTINGID);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting dates_available: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_LISTING_AMENITY
(P_AMENITYID IN VARCHAR2, P_LISTINGID IN VARCHAR2)
AS
    V_AID LISTING_AMENITY.AMENITIESID%TYPE;
    V_LID LISTING_AMENITY.LISTINGID%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_AMENITYID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid amenity ID, please use the format A### where A is a capitalized character');
    ELSIF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid listing ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM LISTING_AMENITY
        WHERE AMENITIESID = P_AMENITYID AND LISTINGID = P_LISTINGID
        RETURNING AMENITIESID, LISTINGID INTO V_AID, V_LID;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Listing_amenity (' || P_AMENITYID || ', ' || P_LISTINGID || ') not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Listing_amenity (' || P_AMENITYID || ', ' || P_LISTINGID || ') deleted successfully.');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting listing_amenity: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_CLIENT
(P_CUSTOMERID IN VARCHAR2)
AS
    V_FIRSTNAME CLIENT.FIRSTNAME%TYPE;
    V_LASTNAME CLIENT.LASTNAME%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_CUSTOMERID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid customer ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM CLIENT
        WHERE CUSTOMERID = P_CUSTOMERID
        RETURNING FIRSTNAME, LASTNAME INTO V_FIRSTNAME, V_LASTNAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Client ' || P_CUSTOMERID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Client ' || P_CUSTOMERID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: ' || V_FIRSTNAME || ' ' || V_LASTNAME);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting client: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_LISTING
(P_LISTINGID IN VARCHAR2)
AS
    V_HOSTID LISTING.HOSTID%TYPE;
    V_TITLE LISTING.TITLE%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_LISTINGID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid listing ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM LISTING
        WHERE LISTINGID = P_LISTINGID
        RETURNING HOSTID, TITLE INTO V_HOSTID, V_TITLE;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Listing ' || P_LISTINGID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Listing ' || P_LISTINGID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: Host ' || V_HOSTID || ', Title ' || V_TITLE);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting listing: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_AMENITY
(P_AMENITYID IN VARCHAR2)
AS
    V_NAME AMENITY.NAME%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_AMENITYID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid amenity ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM AMENITY
        WHERE AMENITIESID = P_AMENITYID
        RETURNING NAME INTO V_NAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Amenity ' || P_AMENITYID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Amenity ' || P_AMENITYID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: ' || V_NAME);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting amenity: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_HOST
(P_HOSTID IN VARCHAR2)
AS
    V_FIRSTNAME HOST.FIRSTNAME%TYPE;
    V_LASTNAME HOST.LASTNAME%TYPE;
BEGIN
    IF NOT IS_ID_VALID(P_HOSTID) THEN
        RAISE_APPLICATION_ERROR(-20111, 'Invalid host ID, please use the format A### where A is a capitalized character');
    END IF;

    BEGIN
        DELETE FROM HOST
        WHERE HOSTID = P_HOSTID
        RETURNING FIRSTNAME, LASTNAME INTO V_FIRSTNAME, V_LASTNAME;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Host ' || P_HOSTID || ' not found. No records deleted.');
            RETURN;
    END;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Host ' || P_HOSTID || ' deleted successfully.');
    DBMS_OUTPUT.PUT_LINE('Details: ' || V_FIRSTNAME || ' ' || V_LASTNAME);

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting host: ' || SQLERRM);
END;
/