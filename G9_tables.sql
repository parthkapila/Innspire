DROP TABLE listing_amenity;
DROP TABLE dates_available;
DROP TABLE booking;
DROP TABLE review;
DROP TABLE listing;
DROP TABLE client;
DROP TABLE host;
DROP TABLE amenity;

CREATE TABLE amenity (
    amenitiesid CHAR(4) NOT NULL,
    name        VARCHAR2(20)
);

ALTER TABLE amenity ADD CONSTRAINT amenity_pk PRIMARY KEY ( amenitiesid );

CREATE TABLE booking (
    bookingid     CHAR(4) NOT NULL,
    customerid    CHAR(4) NOT NULL,
    listingid     CHAR(4) NOT NULL,
    bookingdate   DATE,
    paymentmethod VARCHAR2(11),
    startdate     DATE,
    enddate       DATE
);

ALTER TABLE booking ADD CONSTRAINT booking_pk PRIMARY KEY ( bookingid );

CREATE TABLE client (
    customerid CHAR(4) NOT NULL,
    firstname  VARCHAR2(15),
    lastname   VARCHAR2(20),
    email      VARCHAR2(50),
    phone      CHAR(12),
    address    VARCHAR2(40),
    city       VARCHAR2(20),
    state      CHAR(2)
);

ALTER TABLE client ADD CONSTRAINT client_pk PRIMARY KEY ( customerid );

CREATE TABLE dates_available (
    dateid    CHAR(4) NOT NULL,
    listingid CHAR(4) NOT NULL,
    startdate DATE,
    enddate   DATE
);

ALTER TABLE dates_available ADD CONSTRAINT dates_available_pk PRIMARY KEY ( dateid );

CREATE TABLE host (
    hostid    CHAR(4) NOT NULL,
    firstname VARCHAR2(15),
    lastname  VARCHAR2(20),
    email     VARCHAR2(50),
    phone     CHAR(12)
);

ALTER TABLE host ADD CONSTRAINT host_pk PRIMARY KEY ( hostid );

CREATE TABLE listing (
    listingid     CHAR(4) NOT NULL,
    hostid        CHAR(4) NOT NULL,
    dateposted    DATE,
    pricepernight NUMBER(7, 2),
    description   VARCHAR2(1000),
    bedroomnum    NUMBER(1),
    bathroomnum   NUMBER(2, 1),
    city          VARCHAR2(20),
    state         CHAR(2),
    address       VARCHAR2(40)
);

ALTER TABLE listing ADD CONSTRAINT listing_pk PRIMARY KEY ( listingid );

CREATE TABLE listing_amenity (
    amenitiesid CHAR(4) NOT NULL,
    listingid   CHAR(4) NOT NULL
);

ALTER TABLE listing_amenity ADD CONSTRAINT listing_amenity_pk PRIMARY KEY ( amenitiesid,
                                                                            listingid );

CREATE TABLE review (
    reviewid    CHAR(4) NOT NULL,
    listingid   CHAR(4) NOT NULL,
    customerid  CHAR(4) NOT NULL,
    rating      NUMBER(2, 2),
    description VARCHAR2(500),
    dateposted  DATE
);

ALTER TABLE review ADD CONSTRAINT review_pk PRIMARY KEY ( reviewid );

ALTER TABLE booking
    ADD CONSTRAINT booking_client_fk FOREIGN KEY ( customerid )
        REFERENCES client ( customerid );

ALTER TABLE booking
    ADD CONSTRAINT booking_listing_fk FOREIGN KEY ( listingid )
        REFERENCES listing ( listingid );

ALTER TABLE dates_available
    ADD CONSTRAINT dates_available_listing_fk FOREIGN KEY ( listingid )
        REFERENCES listing ( listingid );

ALTER TABLE listing_amenity
    ADD CONSTRAINT listing_amenity_amenity_fk FOREIGN KEY ( amenitiesid )
        REFERENCES amenity ( amenitiesid );

ALTER TABLE listing_amenity
    ADD CONSTRAINT listing_amenity_listing_fk FOREIGN KEY ( listingid )
        REFERENCES listing ( listingid );

ALTER TABLE listing
    ADD CONSTRAINT listing_host_fk FOREIGN KEY ( hostid )
        REFERENCES host ( hostid );

ALTER TABLE review
    ADD CONSTRAINT review_client_fk FOREIGN KEY ( customerid )
        REFERENCES client ( customerid );

ALTER TABLE review
    ADD CONSTRAINT review_listing_fk FOREIGN KEY ( listingid )
        REFERENCES listing ( listingid );