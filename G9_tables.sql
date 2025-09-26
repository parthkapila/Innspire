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
    enddate       DATE,
    title         VARCHAR2(50)
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
        
INSERT INTO HOST VALUES ('H101', 'Jessica', 'Day', 'jday@yahoo.com', '333-333-3333');
INSERT INTO HOST VALUES ('H102', 'Nick', 'Miller', 'nmiller@yahoo.com', '111-111-1111');
INSERT INTO HOST VALUES ('H103', 'Regan', 'Lucas', 'rlucas@yahoo.com', '222-222-2222');
INSERT INTO HOST VALUES ('H104', 'Cece', 'Parekh', 'cparekh@yahoo.com', '444-444-4444');
INSERT INTO HOST VALUES ('H105', 'Julia', 'Cleary', 'jcleary@yahoo.com', '555-555-5555');
INSERT INTO HOST VALUES ('H106', 'Jenn', 'Tovoii', 'jtovoii@yahoo.com', '666-666-6666');
INSERT INTO HOST VALUES ('H107', 'Ernie', 'Tagilaboo', 'etagilaboo@yahoo.com', '777-777-7777');
INSERT INTO HOST VALUES ('H108', 'Alisha', 'Bishop', 'abishop@yahoo.com', '888-888-8888');
INSERT INTO HOST VALUES ('H109', 'Becky', 'Cavatappi', 'bcavatappi@yahoo.com', '999-999-999');
INSERT INTO HOST VALUES ('H110', 'Winston', 'Schmidt', 'wscmidt@yahoo.com', '10-101-0101');
INSERT INTO HOST VALUES ('H111', 'Bob', 'Day', 'bday@yahoo.com', '121-121-1212');
INSERT INTO HOST VALUES ('H112', 'Bonnie', 'Miller', 'bmiller@yahoo.com', '131-131-1313');
INSERT INTO HOST VALUES ('H113', 'Pauk', 'Genzlinger', 'pgenzlinger@yahoo.com', '141-141-1414');
INSERT INTO HOST VALUES ('H114', 'Prinyanka', 'Parekh', 'pparekh@yahoo.com', '151-151-1515');
INSERT INTO HOST VALUES ('H115', 'Sam', 'Sweeney', 'sweeney@yahoo.com', '161-161-1616');
INSERT INTO HOST VALUES ('H116', 'Robby', 'McFerrin', 'rmcferrin@yahoo.com', '171-171-1717');
INSERT INTO HOST VALUES ('H117', 'Russel', 'Schiller', 'rschiller@yahoo.com', '181-181-1818');
INSERT INTO HOST VALUES ('H118', 'Abby', 'Day', 'aday@yahoo.com', '191-191-1919');
INSERT INTO HOST VALUES ('H119', 'Ruth', 'Schmidt', 'rschmidt@yahoo.com', '202-202-2020');
INSERT INTO HOST VALUES ('H120', 'Gavin', 'Schmidt', 'gschmidt@yahoo.com', '212-212-2121');
INSERT INTO HOST VALUES ('H121', 'Aly', 'Nelson', 'anelson@yahoo.com', '232-232-2323');
INSERT INTO HOST VALUES ('H122', 'Tanya', 'Lamontagne', 'tlamontagne@yahoo.com', '212-212-2121');
INSERT INTO HOST VALUES ('H123', 'Walt', 'Miller', 'wmiller@yahoo.com', '242-242-2424');
INSERT INTO HOST VALUES ('H124', 'Elaine', 'Swift', 'eswift@yahoo.com', '252-252-2525');
INSERT INTO HOST VALUES ('H125', 'May', 'Esperas', 'mesperas@yahoo.com', '262-262-2626');
INSERT INTO HOST VALUES ('H126', 'Louise', 'Schmidt', 'lschmidt@yahoo.com', '272-272-2727');
INSERT INTO HOST VALUES ('H127', 'Jeff', 'Day', 'jday1@yahoo.com', '282-282-2828');
INSERT INTO HOST VALUES ('H128', 'Stephan', 'Amell', 'samell@yahoo.com', '292-292-2929');
INSERT INTO HOST VALUES ('H129', 'Katie', 'Cassidy', 'kcassidy@yahoo.com', '303-303-3030');
INSERT INTO HOST VALUES ('H130', 'Natasha', 'Lyonne', 'nlyonne@yahoo.com', '313-313-3131');
INSERT INTO HOST VALUES ('H131', 'Lake', 'Bell', 'lbell@yahoo.com', '323-323-3232');
INSERT INTO HOST VALUES ('H132', 'Justin', 'Long', 'jlong@yahoo.com', '343-343-3434');
INSERT INTO HOST VALUES ('H133', 'Lizzy', 'Caplan', 'lcaplan@yahoo.com', '353-353-3535');
INSERT INTO HOST VALUES ('H134', 'Ryan', 'Kwanten', 'rkawnten@yahoo.com', '363-363-3636');
INSERT INTO HOST VALUES ('H135', 'Joey', 'King', 'jking@yahoo.com', '373-373-3737');
INSERT INTO HOST VALUES ('H136', 'Randall', 'Park', 'rpark@yahoo.com', '383-383-3838');
INSERT INTO HOST VALUES ('H137', 'Martin', 'Starr', 'mstarr@yahoo.com', '393-393-3939');
INSERT INTO HOST VALUES ('H138', 'Dermot', 'Mulroney', 'dmulroney@yahoo.com', '404-404-4040');
INSERT INTO HOST VALUES ('H139', 'Kareem', 'Abdul-Jabbar', 'kabduljabbar@yahoo.com', '414-414-4141');
INSERT INTO HOST VALUES ('H140', 'Chloe', 'Bridges', 'cbridges@yahoo.com', '424-424-4242');
INSERT INTO HOST VALUES ('H141', 'Thomas', 'Lennon', 'tlennon@yahoo.com', '434-434-4343');
INSERT INTO HOST VALUES ('H142', 'Parker', 'Posey', 'pposey@yahoo.com', '454-454-4545');
INSERT INTO HOST VALUES ('H143', 'Josh', 'Gad', 'jgad@yahoo.com', '464-464-4646');
INSERT INTO HOST VALUES ('H144', 'Carla', 'Gugino', 'cgugino@yahoo.com', '474-474-4747');
INSERT INTO HOST VALUES ('H145', 'Steve', 'Agee', 'sagee@yahoo.com', '484-484-4848');
INSERT INTO HOST VALUES ('H146', 'Rob', 'Riggle', 'rriggle@yahoo.com', '494-494-4949');
INSERT INTO HOST VALUES ('H147', 'Rob', 'Reiner', 'rreiner@yahoo.com', '505-505-5050');
INSERT INTO HOST VALUES ('H148', 'Olivia', 'Munn', 'omunn@yahoo.com', '515-515-5151');
INSERT INTO HOST VALUES ('H149', 'Justin','Watt', 'jwatt@yahoo.com', '525-525-5252');
INSERT INTO HOST VALUES ('H150', 'Clayton', 'Kershaw', 'ckershaw@yahoo.com', '535-535-5353');

select * from host;
