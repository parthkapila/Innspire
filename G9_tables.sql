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
    address       VARCHAR2(40),
    title         VARCHAR2(50)
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
    rating      NUMBER(2, 1),
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

--host table
INSERT INTO HOST VALUES ('H101', 'Jessica', 'Day', 'jday@yahoo.com', '333-333-3333');
INSERT INTO HOST VALUES ('H102', 'Nick', 'Miller', 'nmiller@yahoo.com', '111-111-1111');
INSERT INTO HOST VALUES ('H103', 'Regan', 'Lucas', 'rlucas@yahoo.com', '222-222-2222');
INSERT INTO HOST VALUES ('H104', 'Cece', 'Parekh', 'cparekh@yahoo.com', '444-444-4444');
INSERT INTO HOST VALUES ('H105', 'Julia', 'Cleary', 'jcleary@yahoo.com', '555-555-5555');
INSERT INTO HOST VALUES ('H106', 'Jenn', 'Tovoii', 'jtovoii@yahoo.com', '666-666-6666');
INSERT INTO HOST VALUES ('H107', 'Ernie', 'Tagilaboo', 'etagilaboo@yahoo.com', '777-777-7777');
INSERT INTO HOST VALUES ('H108', 'Alisha', 'Bishop', 'abishop@yahoo.com', '888-888-8888');
INSERT INTO HOST VALUES ('H109', 'Becky', 'Cavatappi', 'bcavatappi@yahoo.com', '999-999-9999');
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
INSERT INTO HOST VALUES ('H122', 'Tanya', 'Lamontagne', 'tlamontagne@yahoo.com', '213-213-2131');
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

--listing table
INSERT INTO LISTING
    VALUES
    ('L101', 'H101', TO_DATE('01-JAN-2025', 'DD-MON-YYYY'), 206, 
    'Take it easy at this unique and tranquil getaway. Quiet and relaxing 1 bedroom studio home with king bed. Only 18 minutes from downtown.  Couch pulls out for added comfort, leg room and sleeping area.  There is a fold out single cot and a fold out queen mattress available.   Full kitchen, smart tv,  washer/dryer, private security system and all the basics are all with this secluded home', 
    1, 1, 'Indianapolis', 'IN', '777 Brockton Avenue', 'Cobb Cabin');
INSERT INTO LISTING
    VALUES
    ('L102', 'H101', TO_DATE('01-AUG-2025', 'DD-MON-YYYY'), 792, 
    'Located in the heart of Chicago’s stylish Gold Coast neighborhood, the historic Millennium Knickerbocker Hotel blends classic elegance with modern convenience. Guests enjoy beautifully appointed rooms, a famous Martini Bar, and proximity to the best of the city. Whether you’re visiting for business or leisure, you’ll find comfort, charm, and easy access to iconic Chicago experiences.', 
    1, 1, 'Chicago', 'IL', '30 Memorial Drive', 'Classic luxury on iconic Michigan Ave');
INSERT INTO LISTING
    VALUES
    ('L103', 'H102', TO_DATE('01-SEP-2025', 'DD-MON-YYYY'), 479, 
    'The Top of The Stairs is a private 1-bedroom loft apartment on the 3rd floor with its own gated exterior entrance—no shared spaces. Please note there are 38 steps to reach the unit. Inside, enjoy a king bed, a full bath with shower, a small laundry room, and a well-equipped kitchen with granite countertops. The living area offers a large sectional, 60" TV (plus bedroom TV), and streaming access with your own accounts. Three zoned mini-split HVAC units keep the space comfortable year-round.', 
    1, 1, 'Columbus', 'OH', '250 Hartford Avenue', 'The Top of the Stairs: Chic Loft on 3rd Ave');
INSERT INTO LISTING
    VALUES
    ('L104', 'H105', TO_DATE('01-SEP-2025', 'DD-MON-YYYY'), 1009, 
    'We use the profits from the guest rooms here to provide hot meals for homeless people on the streets of New York City. Please take a moment to look at the pictures on our listing. Since the money you give us for your room is financing the meal distribution program, just by staying here, you are already helping to support this program. But if you would like to personally come out to help with the meal distribution for two hours (from 9:30AM until 11:30AM) for one of the days of your visit, we will offer you the bed and breakfast guest room for a special price.', 
    1, 1, 'Manhattan', 'NY', '700 Oak Street', 'East Village, Private room with access to garden');
INSERT INTO LISTING
    VALUES
    ('L105', 'H110', TO_DATE('02-JAN-2024', 'DD-MON-YYYY'), 606, 
    'Guests will enjoy the stylish, charm of their private bedroom. Lush towels, plush bedding and ample storage provide refinement and comfort during your stay. Enjoy premium coffee in the luxurious kitchen, or read a book under the skylight in the upstairs library. There is ample space for you to enjoy. Legal listing! Please note that we cannot accommodate more than one (1) guest per visit. Please note that if you are a “digital nomad,” then this listing is probably not for you. We can recommend local places for remote work or add a desk to the room on request, but we do ask that guests refrain from using the shared spaces (dining, living room, etc.) as a remote office. Thanks so much for understanding!', 
    1, 1, 'Brooklyn', 'NY', '66-4 Parkhurst Rd', 'Chic, private room and bath in classic townhouse');
INSERT INTO LISTING
    VALUES
    ('L106', 'H115', TO_DATE('11-JAN-2024', 'DD-MON-YYYY'), 1712, 
    'On the back corner of our ten acre (budding) farm, the treehouse is situated with privacy. All the details pertaining to comfort have been thought of. Each room, an exquisite, artful experience.', 
    1, 1, 'Greenbrier', 'TN', '591 Memorial Dr', 'Nashville Luxury Dream Treehouse +Spa');
INSERT INTO LISTING
    VALUES
    ('L107', 'H120', TO_DATE('21-MAR-2024', 'DD-MON-YYYY'), 206, 
    'For a super easy check in, there will be a smart lock door entry with an assigned code, once you arrive. Check-in anytime after 3pm. Check-out is 10am. A 2 night minimum is preferred, however, we are flexible to 1 night stays. This is a separate entrance/self check in apartment. Best accommodating 1-2 guests.', 
    1, 1, 'Nashville', 'TN', '55 Brooksby Village Way', 'Simply Suite: Cozy Apartment, 13 mins to Downtown');
INSERT INTO LISTING
    VALUES
    ('L108', 'H120', TO_DATE('15-NOV-2024', 'DD-MON-YYYY'), 360, 
    'This house is a MODERN Tiny home featured on the TV show Modern Tiny Living. 20ft long, it features a kitchen, full bathroom, 1 lofted queen bed, 1 pullout queen bed and lounge area. This home is nestled in the woods on 5 acres of private property. There is a main house on this property which is part of Nashvilles country music royalty landmarks as it had recorded Dolly, George Jones, Tim Mcgraw, Lainey Wilson actually lived on the property for 3 years and many other established famous musicians. This tiny home is a private oasis from the hustle of Nashville. You will feel complete zen being tucked into the woods, while still only 10mins ($12 Uber) to Nashville''s downtown Honky Tonk district. Shopping, Restaurants, a gym, Starbucks, mini golf, are all within minutes from this home. There is a lake and private beach only minutes from the Tiny House. If you have never experienced Tiny living, it is time for you to Try It Tiny.', 
    2, 1, 'Nashville', 'TN', '137 Teaticket Hwy', 'Famous Tiny Home from HGTV');
INSERT INTO LISTING
    VALUES
    ('L109', 'H120', TO_DATE('09-AUG-2025', 'DD-MON-YYYY'), 681, 
    'Welcome to The Music City! The peaceful Stolisma Studio is located in trendy Midtown Nashville, on the border of Downtown, Broadway, Music Row, The Parthenon, and Hillsboro Village. Our neighborhood features many chef-driven restaurants and bustling bars. It is just moments from Vanderbilt Medical Center, Children''s Hospital, the VA Hospital, and Centennial Medical Complex. Its walkability and closeness to both downtown and other unique neighborhoods make it an exceptionally convenient area to stay in Nashville.', 
    1, 1, 'Nashville', 'TN', '42 Fairhaven Commons Way', 'City Apt. | 8 mins. to Broadway, parking/gym/pool');
INSERT INTO LISTING
    VALUES
    ('L110', 'H150', TO_DATE('19-FEB-2025', 'DD-MON-YYYY'), 1233, 
    'Made from reclaimed materials, this charming and newly constructed cabin has a vintage style that sits perfectly amongst the forest. It features a gorgeous open plan space and floor-to-ceiling windows that provide a 180-degree view of nature outside. Secluded on its own quiet 42 acres, the cabin lets you feel alone with nature. Further out, there is easy access to stores and restaurants with a few lovely places for antique shopping. Nashville itself is just a short drive away', 
    2, 2, 'Goodlettsville', 'TN', '374 William S Canning Blvd', 'Enjoy Nature at a Secluded Cabin near Nashville');
INSERT INTO LISTING
    VALUES
    ('L111', 'H140', TO_DATE('26-DEC-2024', 'DD-MON-YYYY'), 1023, 
    'Casa Carmona is a little oasis in the big city. It is convenient to just about anywhere you would want to visit while in Los Angeles. Private entrance allows you to come and go as you please. Very diverse selection of restaurants and there is a 7-11 as well as a small grocery store (that delivers) less than a block away if you would rather eat in. Laundromat and dry cleaners are one block away which is helpful for longer stays. Street parking is available. Convenient to public transportation.', 
    2, 1, 'Los Angeles', 'CA', '121 Worcester Rd', 'Casa Carmona, a Mid-City Garden Oasis near Museums');
INSERT INTO LISTING
    VALUES
    ('L112', 'H106', TO_DATE('31-JUL-2025', 'DD-MON-YYYY'), 771, 
    'We provide a comfortable 350 sf private guest suite for a maximum of 1 guest. There is wifi, a dedicated work space and private bathroom. A double-size bed with memory foam topper greets you with a library of books to choose from. For limited food prep there is a sink, mini-fridge, microwave, toaster oven, electric kettle, and washing machine and drying racks for laundry. We offer complimentary instant coffee, tea, water, and snacks. Utensils and dishware are provided. Added amenities include a hanger rack, dresser, in wall AC/heater unit. The space gets great afternoon light, but blackout blinds are also provided for a dimmer feel. Only street parking is available, but is fairly easy to come by. The exterior of the property is shared and we are all permanent residents. We are all quiet, friendly, early morning people. Since Covid, we also all work from home, so you will probably see us around :)', 
    1, 1, 'Los Angeles', 'CA', '677 Timpany Blvd', 'Guest Suite in Los Feliz, California');
INSERT INTO LISTING
    VALUES
    ('L113', 'H130', TO_DATE('25-MAR-2025', 'DD-MON-YYYY'), 543, 
    'Centrally Located to LAX, USC, Culver City, Downtown Los Angeles, Santa Monica, Beverly Hills, Staple Center, Santa Monica Beach, Venice Beach, Bike Hiking Trails, Cinemas , Baldwin Hills Crenshaw Plaza, and many more famous landmarks and attractions in Los Angeles. It is Fabulous!!!!!! Very quiet and spacious with a lot of amenities. You can not beat the ambiance and views. My place is good for couples, solo adventurers, business travelers, and families (with kids).', 
    1, 1, 'Los Angeles', 'CA', '337 Russell St', 'Fabulous 180 degree view of the City!');
INSERT INTO LISTING
    VALUES
    ('L114', 'H130', TO_DATE('22-JUN-2025', 'DD-MON-YYYY'), 2152, 
    'Floor-to-ceiling windows throughout the entire apartment! Dual King Sky Suite and Ultra-Luxury 2bed/2bath high-rise corner unit with 1 FREE parking spot, Pool, Jacuzzi, WiFi, air conditioning, kitchen, secure building, laundry facilities in-unit, floor-to-ceiling windows, and a 65” LED Smart TV + Netflix', 
    2, 2, 'Vernon', 'VA', '295 Plymouth Street', 'LA Penthouse 2bed/2bath [SKY SUITE | VIEWS | POOL]');
INSERT INTO LISTING
    VALUES
    ('L115', 'H121', TO_DATE('31-OCT-2024', 'DD-MON-YYYY'), 506, 
    'Located on the 1st floor of a new 3-level townhome in a gated community, this space is ideal for traveling professionals, nurses or students seeking a clean and modern space to relax and replenish in while on-assignment in Los Angeles', 
    1, 1, 'Gardena', 'CA', '1775 Washington St', 'Luxe Room w/Ensuite Bathroom | LAX | South Bay');
INSERT INTO LISTING
    VALUES
    ('L116', 'H121', TO_DATE('11-JAN-2025', 'DD-MON-YYYY'), 1144, 
    'This gorgeous cabin with all the comforts of home offers beautiful mountain views and an easy drive to the Smoky Mountains, Dollywood, or downtown Pigeon Forge. Perfect for a romantic getaway or a family retreat', 
    2, 2, 'Pigeon Forge', 'TN', '280 Washington Street', 'Couples getaway w/ hot tub, views, and king beds');
INSERT INTO LISTING
    VALUES
    ('L117', 'H121', TO_DATE('26-MAR-2025', 'DD-MON-YYYY'), 206, 
    'Want the feel of a private hotel without having to deal with the inconveniences? No key fobs or gate codes or confusing directions on how to get to your home away from home! Just pull into your PERSONAL ATTACHED GARAGE to access Tampa’s 1st and only Luxe property!', 
    1, 2, 'Tampa', 'FL', '20 Soojian Dr', 'Downtown Tampa - The Luxe Loft in Channelside');
INSERT INTO LISTING
    VALUES
    ('L118', 'H141', TO_DATE('30-APR-2025', 'DD-MON-YYYY'), 2179, 
    'Nestled on five private acres along Fightingtown Creek, River Song is a luxury retreat designed for relaxation and adventure. This modern, single-story home features an open-concept layout with a four-sided stone fireplace, a chef’s kitchen with Viking appliances, and floor-to-ceiling windows. Enjoy two king suites, a media room, a hot tub, an outdoor fireplace, and creekside serenity—all just minutes from McCaysville and Blue Ridge.', 
    3, 3, 'McCaysville', 'GA', '11 Jungle Road', 'River Song- Outdoor Fireplace, Hot Tub, 1 LVL');
INSERT INTO LISTING
    VALUES
    ('L119', 'H131', TO_DATE('03-JAN-2025', 'DD-MON-YYYY'), 3062, 
    'Welcome to Amaru Muru: The Stargate of the Desert, a Joshua Tree luxury desert retreat. This state of the art desert villa has spectacular views in every direction! Enjoy the luxurious pool, hot tub, yoga room, fire pit, outdoor shower and so much space indoors and out! This home has the best location in Joshua Highlands just 5 minutes from the Joshua Tree National Park entrance. Journey with us and you will see the meticulous attention to detail and design throughout this modern desert escape.', 
    3, 2, 'Joshua Tree', 'CA', '301 Massachusetts Ave', 'Amaru Muru - Luxury Pool, Hot Tub and Yoga Studio');
INSERT INTO LISTING
    VALUES
    ('L120', 'H103', TO_DATE('20-NOV-2024', 'DD-MON-YYYY'), 3027, 
    'Mori A-Frame is a newly built minimalist cabin in the Poconos thoughtfully designed by two architects—who also happen to be your hosts! Located in a quiet, wooded community in East Stroudsburg, our design centers on providing a serene and restorative retreat. We hope you enjoy staying at our getaway home as much as we do.', 
    3, 3, 'East Stroudsburg', 'PA', '780 Lynnway', 'New A-Frame Cabin Retreat w/Hot Tub');
INSERT INTO LISTING
    VALUES
    ('L121', 'H104', TO_DATE('29-OCT-2024', 'DD-MON-YYYY'), 2865, 
    'With forest on one side and a glistening lake on the other, this home boasts a modern-meets-mountain aesthetic with space for up to 12 guests. A contemporary design scheme is at once comfortable and chic. Floor-to-ceiling windows allow sunlight to stream inside, while also showcasing the natural beauty of the surrounding property. At night, gather around the fire pit or stargaze in the hot tub.', 
    4, 4.5, 'Westminster', 'SC', '70 Pleasant Valley Street', 'Zoka | Luxe Modern Cabin Near Clemson w/ Hot Tub');
INSERT INTO LISTING
    VALUES
    ('L122', 'H105', TO_DATE('16-MAY-2024', 'DD-MON-YYYY'), 7019, 
    'This four bedroom modern home is perched high on a ridge above Sundance resort. Lasta, a 3700 square-foot home was purposely built for visual drama. Large windows invite expansive views of Alpine peaks, towering Pines and ever shifting skies-each room framing the wilderness like a living set. Located at the end of a quiet road and surrounded by a mature forest, this setting offers total seclusion with golden sunsets on the rear deck over looking the forested mountains.', 
    4, 3.5, 'Sundance', 'UT', '830 Curran Memorial Hwy', 'Luxury Modern Mountain Home');
INSERT INTO LISTING
    VALUES
    ('L123', 'H106', TO_DATE('02-AUG-2025', 'DD-MON-YYYY'), 13175, 
    'A rare architectural gem set above the coastline near Zuma Beach, this contemporary Malibu retreat is defined by unparalleled ocean views, soaring glass walls, and a seamless connection to nature. A zero-edge infinity pool extends toward the horizon, while multiple terraces, fire features, and an open-concept design set the stage for elevated coastal living. The double-height great room is lined with walls of glass, leading to a private rooftop terrace that captures breathtaking views.', 
    4, 3, 'Malibu', 'CA', '1470 S Washington St', 'Surfside Malibu by Stay Awhile Villas');
INSERT INTO LISTING
    VALUES
    ('L124', 'H107', TO_DATE('13-APR-2024', 'DD-MON-YYYY'), 3802, 
    'Welcome to our stunning home in Mountain Village, where mountain views, 3 fireplaces, and two steam showers create a luxurious escape. This 3-level home features Viking appliances, a game room with a foosball table, and a private hot tub, making it ideal for year-round adventures.', 
    4, 5, 'Mountain Village', 'CO', '506 State Road', 'Luxe Mountain Village Retreat | Hot Tub w/ Views');
INSERT INTO LISTING
    VALUES
    ('L125', 'H108', TO_DATE('26-MAR-2025', 'DD-MON-YYYY'), 6075, 
    'Siesta Key Dream’s largest and most luxurious vacation rental, features four levels, totaling 6-bedrooms, 9-beds, and 6 full-bathrooms. Notable attributes include: a heated-pool, hot tub, 2-balconies, a roof-top sundeck, parking, a backyard and an elevator. With a premier location, beach access point #4 is 400 feet away, and the Siesta Key Village is one block away. In addition to a highly desired location, the unique property design allows beach and Gulf of Mexico views from multiple levels.', 
    6, 7, 'Siesta Key', 'FL', '742 Main Street', '400ft to Beach, Ocean View, Pool, in the Village');
INSERT INTO LISTING
    VALUES
    ('L126', 'H109', TO_DATE('08-OCT-2024', 'DD-MON-YYYY'), 7021, 
    'From the pool’s sunken sun loungers to the alfresco kitchen’s marble bar, Paradiso uses every inch of its sprawling 5 acre plot to celebrate its gorgeous surroundings. This luxury gated estate offers full fenced privacy set away from major roads and surrounding properties. Decorated with lush gardens, emerald lawns, and a private pond, this vacation rental is a natural wonder of its own.', 
    5, 4.5, 'Columbus', 'OH', '72 Main St', 'Paradiso');
INSERT INTO LISTING
    VALUES
    ('L127', 'H119', TO_DATE('26-MAR-2024', 'DD-MON-YYYY'), 5111, 
    '600 feet of white sand and thousands of miles of ocean stretch out in front of this Miami Beach haven. A sitting area on the balcony serves up sunshine and views. Floor-to-ceiling windows let the light into the great room, where it bounces off sleek white millwork and blond-wood floors. Set in a beachfront hotel, the residence is an elevator ride from 4 pools and walking distance to nightlife.', 
    2, 2, 'Miami Beach', 'FL', '200 Otis Street', 'Oceanfront Private Condo at 1 Hotel and Homes');
INSERT INTO LISTING
    VALUES
    ('L128', 'H119', TO_DATE('18-JUL-2024', 'DD-MON-YYYY'), 3576, 
    'Experience luxury and comfort in this stunning 4-bedroom, 5-bathroom retreat in Truckee, CA. This expansive 5-floor vacation rental offers a private hot tub, spacious living areas, and a fully equipped kitchen, perfect for group getaways. Relax by the gas fireplace, enjoy high-speed WiFi, and take in serene Martis Valley views. Located near premier skiing, hiking, and dining, this home is ideal for year-round adventures in Lake Tahoe. With space for 8 guests, indulge in a perfect mountain escape', 
    4, 4, 'Truckee', 'CA', '180 North King Street', 'Luxurious Truckee/Schaffer’s Mill Rental');
INSERT INTO LISTING
    VALUES
    ('L129', 'H119', TO_DATE('11-APR-2024', 'DD-MON-YYYY'), 3571, 
    'Heaven’s Cabins offers 50 luxurious vacation homes in Gatlinburg, TN, known for breathtaking views and exceptional outdoor spaces. With 2 to 9-bedroom options, each property provides top-tier amenities and outstanding service. Named Tennessee’s #1 vacation home provider by U.S. Travel News and backed by over 7,000 online reviews with an incredible 4.98 average score. If “Beyond Heaven” isn’t your perfect fit, discover our full collection of stunning, personally owned properties at Heaven’s Cabins to find your ideal getaway.', 
    6, 6, 'Gatlinburg', 'TN', '555 East Main St', 'Luxury Modern Cabin! 6 Masters! Huge Decks! Views!');
INSERT INTO LISTING
    VALUES
    ('L130', 'H145', TO_DATE('18-JAN-2025', 'DD-MON-YYYY'), 4771, 
    'The stars shine exceptionally bright at this scenic villa in the forested foothills of Gatlinburg. Enjoy mountain and treetop views from multiple outdoor lounge areas, the great room’s double-floor windows, and even while relaxing in the hot tub. When you’re not exploring nearby trails, gather in the games room for classic arcades, air hockey, or billiards while watching the big game.', 
    4, 4.5, 'Gatlinburg', 'TN', '555 Hubbard Ave-Suite 12', 'Gatlinburg Starry Night');
INSERT INTO LISTING
    VALUES
    ('L131', 'H146', TO_DATE('05-MAR-2025', 'DD-MON-YYYY'), 5335, 
    'Welcome to TANNENHAUS, a brand new, 2025 build, custom eight bedroom, eleven bed, five bath, 5,000 sq ft home nestled in Park City that sleeps 16. Contemporary Scandinavian design, 15+ ft ceilings, and sweeping mountain views. French oak floors, hot tub, rift oak cabinets, stone fireplaces, and wine room. Two primary bedrooms with ensuites/free-standing tubs, two garage parking spots, four dining areas, two entertainment rooms, two laundry areas, and two Chefs kitchens with Viking appliances.', 
    8, 5, 'Park City', 'UT', '300 Colony Place', 'Ideal Park City Mountain Château');
INSERT INTO LISTING
    VALUES
    ('L132', 'H147', TO_DATE('04-JAN-2025', 'DD-MON-YYYY'), 7448, 
    'Breathtaking beauty at this estate with panoramic pastoral and mountain views. Open floor plan, large windows take every advantage of the spectacular views, chef’s gourmet kitchen, three stack stone interior fireplaces and one outside on the deck, basement with pool table, cozy movie room perfect for movie night and multiple levels of outdoor deck space with a hot tub!', 
    7, 5.5, 'Clyde', 'NC', '301 Falls Blvd', 'Luxury 8400 sq ft Lodge|Hot Tub|Panoramic Views');
INSERT INTO LISTING
    VALUES
    ('L133', 'H148', TO_DATE('06-JAN-2025', 'DD-MON-YYYY'), 12856, 
    'This EXQUISITE four-level 10 bedroom 10 bathroom (9 full and 2 half baths) Gulf-front home has 50 of private deeded-beach, and even has its own steps for access to the beach from the pool deck - - this is as private as it gets!', 
    9, 9, 'Beach', 'FL', '36 Paramount Drive', 'Beach Front! Sleeps 28! Private Beach, Pool ON 30A');
INSERT INTO LISTING
    VALUES
    ('L134', 'H149', TO_DATE('11-AUG-2025', 'DD-MON-YYYY'), 3746, 
    'Ruffled umbrellas and a woven-roof bar bring mid-century charm to this Coachella Valley home. A palapa-covered barbecue faces the pool and hot tub, and the tiki bar area has darts and air hockey. Inside the red-tile-roofed home, welcoming sofas surround a fireplace that anchors the great room. It’s half an hour to shops and dining in Palm Springs and the scenery of Joshua Tree National Park.', 
    5, 4, 'Indio', 'CA', '450 Highland Ave', 'Palma');
INSERT INTO LISTING
    VALUES
    ('L135', 'H121', TO_DATE('16-JAN-2025', 'DD-MON-YYYY'), 8055, 
    'Upon entering Michiana Shores Beach House, you’ll step into a world of sculpted beauty, serenity, and grace. Everywhere you look, you’ll feel the pull to relax in this stunning vacation home’s elegant comfort. The open design of the Kitchen, Dining Room, and Living Room invites you to unwind with your favorite drink, whether at the kitchen’s center island, on the cushy couch in front of the flat-screen TV, or at the chic dining table to share a meal or snack with family or friends. There’s also a tranquil view from any of these spots out to the calming, Zen-like backyard and pool area.', 
    6, 4, 'Michigan City', 'IN', '1180 Fall River Avenue', 'Fab Vacay Home, Pool, Walk to Lake Michigan Beach');
INSERT INTO LISTING
    VALUES
    ('L136', 'H122', TO_DATE('18-OCT-2025', 'DD-MON-YYYY'), 6545, 
    'Perched in the coveted Hollywood Hills, this recently renovated 5-bed, 3.5-bath smart home marries tech and tranquility with Control4 automation, sleek smart toilets, a private outdoor sauna, and beautiful pool and jacuzzi. Gaze out at the glittering city skyline from expansive terraces. Blending modern opulence with serene hillside living, this architectural gem is professionally managed by Stay Awhile Villas.', 
    5, 5, 'Los Angeles', 'CA', '1105 Boston Road', 'LA Reserve by Stay Awhile Villas');
INSERT INTO LISTING
    VALUES
    ('L137', 'H123', TO_DATE('01-DEC-2025', 'DD-MON-YYYY'), 4632, 
    'The newly-built 4-bedroom Blue Valley Chalet blends modern luxury with cozy comfort. The home is secluded in the private Blue River neighborhood surrounded by nature and close to hiking trails, yet a short jaunt to the historic town of Breckenridge.', 
    4, 4.5, 'Breckenridge', 'CO', '100 Charlton Road', 'New Home, Modern Luxury | Blue Valley Chalet');
INSERT INTO LISTING
    VALUES
    ('L138', 'H124', TO_DATE('05-JUN-2024', 'DD-MON-YYYY'), 2471, 
    'Welcome to Orren North, your downtown luxury and bespoke living! Just two blocks from Bozeman’s Main Street, this newly built escape offers modern architecture, high-end furnishings, and a chef’s kitchen that’s top of the line. Whether you’re exploring local restaurants, hiking nearby trails, or unwinding in sleek comfort after a day out, Atelier North is your gateway to Bozeman’s most elevated experience.', 
    2, 2.5, 'Bozeman', 'MT', '262 Swansea Mall Dr', 'Orren North | Downtown Luxury and Bespoke Living');
INSERT INTO LISTING
    VALUES
    ('L139', 'H125', TO_DATE('20-NOV-2024', 'DD-MON-YYYY'), 6333, 
    'Take a tour around the world in this exquisite mountain top architectural wonder! Immerse yourselves in this unique experience thats designed around the 7 continents. Not only is it built into the top of Cheyenne Mountain on 13 private acres, but we dare you to find one with better style or view! It’s a cross between ultra chic and relaxing fun! It has 4 king bedrooms, a set of bunk beds in the North American themed garage game room and a pair of twin rollaways too. Sleeps up to 12', 
    5, 3.5, 'Colorado Springs', 'CO', '333 Main Street', 'King of the mountain amazing views! Sleeps 12');
INSERT INTO LISTING
    VALUES
    ('L140', 'H126', TO_DATE('18-NOV-2024', 'DD-MON-YYYY'), 3297, 
    'Welcome to Seeking Sanctuary, a luxury coastal home professionally managed by Stay on 30a. Nestled between Rosemary and Alys Beach in the Seacrest Beach neighborhood, this spacious 4-bedroom, 3,288 sq. ft. retreat is perfect for families or groups. The open-concept living, dining, and fully stocked kitchen create a relaxed, at-home feel, while multiple patios and a third-floor play/reading area offer plenty of space to unwind. Enjoy on-site parking for 3 cars, 6 complimentary adult bikes, and easy beach access via the nearby tram stop at Villas at Sunset Beach.', 
    4, 4.5, 'Seacrest', 'FL', '550 Providence Hwy', 'Seeking Sanctuary by Stay on 30a');
INSERT INTO LISTING
    VALUES
    ('L141', 'H128', TO_DATE('01-MAY-2024', 'DD-MON-YYYY'), 7118, 
    'Welcome to Samara, a stunning new-construction retreat nestled in the hills of Malibu. Overlooking the ocean and lush Santa Monica Mountains, this serene escape offers high-end finishes, luxury furnishings, and total tranquility. Fully stocked with beach essentials and everything you need for a seamless stay, Samara is the perfect setting for peaceful relaxation and rejuvenation in natures beauty.', 
    3, 2.5, 'Malibu', 'CA', '352 Palmer Road', 'Samara by Stay Awhile Villas');
INSERT INTO LISTING
    VALUES
    ('L142', 'H129', TO_DATE('01-SEP-2024', 'DD-MON-YYYY'), 1654, 
    'Welcome to Marriott Residence 402, located in the heart of the Town of Jackson, just blocks away from the historic Town Square. This exquisite one bedroom, one and a half bathroom, 1,108 square foot condo offers a blend of elegance, comfort, and convenience. Enjoy breathtaking views of Snow King Mountain, where the stunning scenery creates a perfect backdrop for your stay.', 
    4, 3.5, 'Jackson', 'WY', '3005 Cranberry Hwy Rt 6 28', 'Outpost: Marriott Residence 402 - Close to Town');
INSERT INTO LISTING
    VALUES
    ('L143', 'H130', TO_DATE('16-AUG-2024', 'DD-MON-YYYY'), 6252, 
    'Nestled in a serene and private setting along the iconic Chuckanut Drive, Chuckanut Point by Gather is a newly remodeled coastal retreat offering breathtaking views of Puget Sound. This 3-bedroom, 3.5-bathroom sanctuary combines modern elegance with natural beauty, creating the perfect getaway for families or groups of up to eight seeking an unforgettable escape.', 
    3, 3.5, 'Bellingham', 'WA', '250 Rt 59', 'Luxury Waterfront Retreat w/ Dock and Ocean Views');
INSERT INTO LISTING
    VALUES
    ('L144', 'H107', TO_DATE('07-APR-2025', 'DD-MON-YYYY'), 7986, 
    'Welcome to Finestra, a 7,000-square-foot private residence perched at the crest of Queen Anne’s prestigious South Slope. Framed by floor-to-ceiling glass and surrounded by sweeping views of Seattle’s skyline, Elliott Bay, Puget Sound, and the majestic Mount Rainier, Finestra is a luxury home designed to elevate every moment of your stay.', 
    7, 6.5, 'Seattle', 'WA', '141 Washington Ave Extension', '7000 sqft Luxury | Skyline Views | Gym and Deck');
INSERT INTO LISTING
    VALUES
    ('L145', 'H108', TO_DATE('12-FEB-2025', 'DD-MON-YYYY'), 611, 
    'As you step into the Airstream from the huge 16x16 ft deck you will have comfort and convenience within arms reach. Slide into the super soft dinette booth to work or play cards or a boardgame. Or choose to hang out on the deck and covered deck table to enjoy the sunset hitting your private mountain views. As the sun sets head over to the firepit for some yummy smores and stories you will remember for years to come. Then slip into the comfy bed and a quick Netflix show to kick off the most peaceful nights sleep you may have ever experienced. See ya soon campfire is waiting.', 
    1, 1, 'Tucson', 'AZ', '13858 Rt 31 W', 'Amazing Desert Views 300 Acre Private Saguaro Park');
INSERT INTO LISTING
    VALUES
    ('L146', 'H109', TO_DATE('31-MAY-2025', 'DD-MON-YYYY'), 651, 
    'Escape to this rustic western-themed bunkhouse on two acres in North Scottsdale near Cave Creek. Unwind indoors or outside on your patio with Mexican beehive fireplace. The bunkhouse is a unique and casual place to stay...sort of like a cowboy museum, only better because you can cook and sleep here. Sleek and sophisticated it is not it but it is clean, comfy, and lots of fun! No weddings or events per city of Scottsdale.', 
    2, 1, 'Scottsdale', 'AZ', '2055 Niagara Falls Blvd', 'Cowboy Bunkhouse in North Scottsdale');
INSERT INTO LISTING
    VALUES
    ('L147', 'H139', TO_DATE('10-JUL-2025', 'DD-MON-YYYY'), 1682, 
    'Escape to your private sanctuary where tranquility meets luxury. Our Coastal Maine Cottage home is perched on a granite ledge that disappears twice daily with the rising tide. Enjoy the pristine interior bathed in natural light, cherry floors, and gourmet kitchen. Wake to panoramic views of the Penobscot River from the owners suite. Conveniently located 12 minutes to downtown Bangor, our retreat offers easy access to urban amenities, an international airport, and Acadia!', 
    1, 1.5, 'Hampden', 'ME', '101 Sanford Farm Shpg Center', 'Cozy Cottage on the Penobscot — Panoramic Luxury!');
INSERT INTO LISTING
    VALUES
    ('L148', 'H140', TO_DATE('17-APR-2025', 'DD-MON-YYYY'), 417, 
    'This is a very rustic structure on our working suburban farm. There is power, wifi and a composting toilet inside the structure with a curtain for privacy but no running water. There is a foot pump to operate the small sink. The upstairs is accessed by a ladder which is rated for no more than 250 lbs. There are lots of gardens and forest to explore at the back of the property and we are only 2.5 miles from Maines second largest "city" Lewiston, just over a half hour from Portland and less than two and a half hours from Acadia National Park. You can catch a bus 1/2 mile from the house or ride your bike into town if you want to ditch your car for your stay. There are restaurants, shops and lots of hiking and swimming close at hand. Please note we do have farm animals so you might be woken by our crowing rooster. We are also in a suburban setting so though we are surrounded it is not a secluded or free from the sounds of other humans, cars etc.', 
    1, 0, 'Lewiston', 'ME', '297 Grant Avenue', 'Firefly Cottage at Forest Orchard Farm');
INSERT INTO LISTING
    VALUES
    ('L149', 'H121', TO_DATE('31-JAN-2025', 'DD-MON-YYYY'), 1085, 
    'Our Geodome is tucked away on 42 private acres exclusively for you and your guest Enjoy the stars at night, fire pit, hot tub, high speed internet, washer dryer, heat and air-conditioning and all the amenities. We are conveniently located within 15 miles of Madison, IN, Vevay, IN, Clifty Falls, Belterra Casino, also within 62 miles of Cincinnati and Louisville.', 
    2, 1, 'Vevay', 'IN', '4133 Veterans Memorial Drive', 'Hilltop Dome, 42 secluded acres in nature');
INSERT INTO LISTING
    VALUES
    ('L150', 'H122', TO_DATE('15-SEP-2025', 'DD-MON-YYYY'), 2583, 
    'On the main level of the Boondoggle, it features 3 bedrooms (1 king, 1 queen and 1 full bed) , 1 full bath with an open concept kitchen, dinning and living room and a laundry room area just off the main hallway and kitchen. Downstairs there are 2 additional bedrooms (1 king and 2 full size beds, which we call the bunk room), 1 full bath room, living room and a game area. Beautiful large deck off the main living area with ample of seating. There is also a lower sitting area also. Deck is connected to the lower sitting area via ramp.', 
    5, 2, 'Columbus', 'OH', '6265 Brockport Spencerport Rd', 'Lake Front Boondoggle');

--Client Table
INSERT INTO client VALUES ('C001', 'Alex', 'Johnson', 'ajohnson@gmail.com', '317-111-0001', '101 Maple St', 'Indianapolis', 'IN');
INSERT INTO client VALUES ('C002', 'Maria', 'Lopez', 'mlopez@yahoo.com', '317-111-0002', '202 Oak Ave', 'Chicago', 'IL');
INSERT INTO client VALUES ('C003', 'David', 'Kim', 'dkim@gmail.com', '317-111-0003', '303 Pine Rd', 'Columbus', 'OH');
INSERT INTO client VALUES ('C004', 'Sophie', 'Nguyen', 'snguyen@gmail.com', '317-111-0004', '404 Elm St', 'Brooklyn', 'NY');
INSERT INTO client VALUES ('C005', 'Michael', 'Smith', 'msmith@gmail.com', '317-111-0005', '505 Cedar Dr', 'Nashville', 'TN');
INSERT INTO client VALUES ('C006', 'Emma', 'Brown', 'ebrown@gmail.com', '317-111-0006', '606 Birch Ln', 'Los Angeles', 'CA');
INSERT INTO client VALUES ('C007', 'James', 'Taylor', 'jtaylor@gmail.com', '317-111-0007', '707 Walnut Ct', 'Malibu', 'CA');
INSERT INTO client VALUES ('C008', 'Olivia', 'Davis', 'odavis@gmail.com', '317-111-0008', '808 Aspen Way', 'Miami', 'FL');
INSERT INTO client VALUES ('C009', 'Liam', 'Martinez', 'lmartinez@gmail.com', '317-111-0009', '909 Spruce Blvd', 'Denver', 'CO');
INSERT INTO client VALUES ('C010', 'Ava', 'Wilson', 'awilson@gmail.com', '317-111-0010', '111 Willow Pkwy', 'Seattle', 'WA');
INSERT INTO client VALUES ('C011', 'Ethan', 'Anderson', 'eanderson@gmail.com', '317-111-0011', '112 Birch St', 'Austin', 'TX');
INSERT INTO client VALUES ('C012', 'Isabella', 'Thomas', 'ithomas@gmail.com', '317-111-0012', '113 Oak St', 'Boston', 'MA');
INSERT INTO client VALUES ('C013', 'Noah', 'Jackson', 'njackson@gmail.com', '317-111-0013', '114 Pine St', 'Phoenix', 'AZ');
INSERT INTO client VALUES ('C014', 'Mia', 'White', 'mwhite@gmail.com', '317-111-0014', '115 Cedar St', 'Atlanta', 'GA');
INSERT INTO client VALUES ('C015', 'William', 'Harris', 'wharris@gmail.com', '317-111-0015', '116 Maple St', 'Dallas', 'TX');
INSERT INTO client VALUES ('C016', 'Charlotte', 'Clark', 'cclark@gmail.com', '317-111-0016', '117 Elm St', 'San Diego', 'CA');
INSERT INTO client VALUES ('C017', 'Benjamin', 'Lewis', 'blewis@gmail.com', '317-111-0017', '118 Ash St', 'Orlando', 'FL');
INSERT INTO client VALUES ('C018', 'Amelia', 'Young', 'ayoung@gmail.com', '317-111-0018', '119 Spruce St', 'Portland', 'OR');
INSERT INTO client VALUES ('C019', 'Lucas', 'Walker', 'lwalker@gmail.com', '317-111-0019', '120 Walnut St', 'Minneapolis', 'MN');
INSERT INTO client VALUES ('C020', 'Harper', 'Hall', 'hhall@gmail.com', '317-111-0020', '121 Oak St', 'Salt Lake City', 'UT');
INSERT INTO client VALUES ('C021', 'Henry', 'Allen', 'hallen@gmail.com', '317-111-0021', '122 Birch St', 'Cincinnati', 'OH');
INSERT INTO client VALUES ('C022', 'Evelyn', 'King', 'eking@gmail.com', '317-111-0022', '123 Pine St', 'Detroit', 'MI');
INSERT INTO client VALUES ('C023', 'Alexander', 'Scott', 'ascott@gmail.com', '317-111-0023', '124 Cedar St', 'Kansas City', 'MO');
INSERT INTO client VALUES ('C024', 'Ella', 'Green', 'egreen@gmail.com', '317-111-0024', '125 Elm St', 'Raleigh', 'NC');
INSERT INTO client VALUES ('C025', 'Daniel', 'Adams', 'dadams@gmail.com', '317-111-0025', '126 Maple St', 'Tampa', 'FL');
INSERT INTO client VALUES ('C026', 'Scarlett', 'Baker', 'sbaker@gmail.com', '317-111-0026', '127 Oak St', 'Las Vegas', 'NV');
INSERT INTO client VALUES ('C027', 'Matthew', 'Gonzalez', 'mgonzalez@gmail.com', '317-111-0027', '128 Pine St', 'Houston', 'TX');
INSERT INTO client VALUES ('C028', 'Victoria', 'Nelson', 'vnelson@gmail.com', '317-111-0028', '129 Cedar St', 'San Jose', 'CA');
INSERT INTO client VALUES ('C029', 'Jack', 'Carter', 'jcarter@gmail.com', '317-111-0029', '130 Ash St', 'Indianapolis', 'IN');
INSERT INTO client VALUES ('C030', 'Madison', 'Mitchell', 'mmitchell@gmail.com', '317-111-0030', '131 Spruce St', 'Columbus', 'OH');
INSERT INTO client VALUES ('C031', 'Samuel', 'Perez', 'sperez@gmail.com', '317-111-0031', '132 Walnut St', 'Charlotte', 'NC');
INSERT INTO client VALUES ('C032', 'Luna', 'Roberts', 'lroberts@gmail.com', '317-111-0032', '133 Maple St', 'Phoenix', 'AZ');
INSERT INTO client VALUES ('C033', 'Sebastian', 'Turner', 'sturner@gmail.com', '317-111-0033', '134 Elm St', 'Chicago', 'IL');
INSERT INTO client VALUES ('C034', 'Aria', 'Phillips', 'aphillips@gmail.com', '317-111-0034', '135 Oak St', 'Seattle', 'WA');
INSERT INTO client VALUES ('C035', 'Joseph', 'Campbell', 'jcampbell@gmail.com', '317-111-0035', '136 Birch St', 'New York', 'NY');
INSERT INTO client VALUES ('C036', 'Grace', 'Parker', 'gparker@gmail.com', '317-111-0036', '137 Pine St', 'Boston', 'MA');
INSERT INTO client VALUES ('C037', 'Carter', 'Evans', 'cevans@gmail.com', '317-111-0037', '138 Cedar St', 'Denver', 'CO');
INSERT INTO client VALUES ('C038', 'Chloe', 'Edwards', 'cedwards@gmail.com', '317-111-0038', '139 Spruce St', 'Miami', 'FL');
INSERT INTO client VALUES ('C039', 'Owen', 'Collins', 'ocollins@gmail.com', '317-111-0039', '140 Maple St', 'Atlanta', 'GA');
INSERT INTO client VALUES ('C040', 'Zoey', 'Stewart', 'zstewart@gmail.com', '317-111-0040', '141 Oak St', 'Austin', 'TX');
INSERT INTO client VALUES ('C041', 'Wyatt', 'Sanchez', 'wsanchez@gmail.com', '317-111-0041', '142 Birch St', 'Dallas', 'TX');
INSERT INTO client VALUES ('C042', 'Layla', 'Morris', 'lmorris@gmail.com', '317-111-0042', '143 Pine St', 'Los Angeles', 'CA');
INSERT INTO client VALUES ('C043', 'Dylan', 'Rogers', 'drogers@gmail.com', '317-111-0043', '144 Cedar St', 'San Diego', 'CA');
INSERT INTO client VALUES ('C044', 'Nora', 'Reed', 'nreed@gmail.com', '317-111-0044', '145 Elm St', 'Nashville', 'TN');
INSERT INTO client VALUES ('C045', 'Levi', 'Cook', 'lcook@gmail.com', '317-111-0045', '146 Ash St', 'Salt Lake City', 'UT');
INSERT INTO client VALUES ('C046', 'Lily', 'Morgan', 'lmorgan@gmail.com', '317-111-0046', '147 Willow St', 'Portland', 'OR');
INSERT INTO client VALUES ('C047', 'Isaac', 'Bell', 'ibell@gmail.com', '317-111-0047', '148 Spruce St', 'Minneapolis', 'MN');
INSERT INTO client VALUES ('C048', 'Hannah', 'Murphy', 'hmurphy@gmail.com', '317-111-0048', '149 Maple St', 'Raleigh', 'NC');
INSERT INTO client VALUES ('C049', 'Mason', 'Bailey', 'mbailey@gmail.com', '317-111-0049', '150 Oak St', 'Chicago', 'IL');
INSERT INTO client VALUES ('C050', 'Ella', 'Rivera', 'erivera@gmail.com', '317-111-0050', '151 Cedar St', 'Houston', 'TX');

--Amenities Table
INSERT INTO amenity VALUES ('A001', 'WiFi');
INSERT INTO amenity VALUES ('A002', 'Air Conditioning');
INSERT INTO amenity VALUES ('A003', 'Heating');
INSERT INTO amenity VALUES ('A004', 'Kitchen');
INSERT INTO amenity VALUES ('A005', 'TV');
INSERT INTO amenity VALUES ('A006', 'Washer');
INSERT INTO amenity VALUES ('A007', 'Dryer');
INSERT INTO amenity VALUES ('A008', 'Free Parking');
INSERT INTO amenity VALUES ('A009', 'Hot Tub');
INSERT INTO amenity VALUES ('A010', 'Pool');
INSERT INTO amenity VALUES ('A011', 'Pets Allowed');
INSERT INTO amenity VALUES ('A012', 'Gym');
INSERT INTO amenity VALUES ('A013', 'Fireplace');
INSERT INTO amenity VALUES ('A014', 'Breakfast Included');
INSERT INTO amenity VALUES ('A015', 'Private Entrance');
INSERT INTO amenity VALUES ('A016', 'BBQ Grill');
INSERT INTO amenity VALUES ('A017', 'Balcony');
INSERT INTO amenity VALUES ('A018', 'Beach Access');
INSERT INTO amenity VALUES ('A019', 'Elevator');
INSERT INTO amenity VALUES ('A020', 'EV Charger');
INSERT INTO amenity VALUES ('A021', 'Smart Lock');
INSERT INTO amenity VALUES ('A022', 'Dishwasher');
INSERT INTO amenity VALUES ('A023', 'Workspace');
INSERT INTO amenity VALUES ('A024', 'Garden View');
INSERT INTO amenity VALUES ('A025', 'Mountain View');
INSERT INTO amenity VALUES ('A026', 'Ocean View');
INSERT INTO amenity VALUES ('A027', 'Patio');
INSERT INTO amenity VALUES ('A028', 'Terrace');
INSERT INTO amenity VALUES ('A029', 'Game Console');
INSERT INTO amenity VALUES ('A030', 'Board Games');
INSERT INTO amenity VALUES ('A031', 'Bikes Available');
INSERT INTO amenity VALUES ('A032', 'Kayak Rental');
INSERT INTO amenity VALUES ('A033', 'Ski-In/Ski-Out');
INSERT INTO amenity VALUES ('A034', 'Sauna');
INSERT INTO amenity VALUES ('A035', 'Security System');
INSERT INTO amenity VALUES ('A036', 'First Aid Kit');
INSERT INTO amenity VALUES ('A037', 'Smoke Alarm');
INSERT INTO amenity VALUES ('A038', 'CO Detector');
INSERT INTO amenity VALUES ('A039', 'Wheelchair Acc.');
INSERT INTO amenity VALUES ('A040', 'Child-Friendly');
INSERT INTO amenity VALUES ('A041', 'Crib');
INSERT INTO amenity VALUES ('A042', 'High Chair');
INSERT INTO amenity VALUES ('A043', 'Breakfast Pantry');
INSERT INTO amenity VALUES ('A044', 'Coffee Maker');
INSERT INTO amenity VALUES ('A045', 'Toiletries Included');
INSERT INTO amenity VALUES ('A046', 'Hair Dryer');
INSERT INTO amenity VALUES ('A047', 'Iron');
INSERT INTO amenity VALUES ('A048', 'Sound System');
INSERT INTO amenity VALUES ('A049', 'Library');
INSERT INTO amenity VALUES ('A050', 'Outdoor Fireplace');

-- Listing Amenities table

INSERT INTO LISTING_AMENITY VALUES ('A001', 'L101');
INSERT INTO LISTING_AMENITY VALUES ('A003', 'L102');
INSERT INTO LISTING_AMENITY VALUES ('A005', 'L103');
INSERT INTO LISTING_AMENITY VALUES ('A008', 'L104');
INSERT INTO LISTING_AMENITY VALUES ('A008', 'L105');
INSERT INTO LISTING_AMENITY VALUES ('A044', 'L106');
INSERT INTO LISTING_AMENITY VALUES ('A035', 'L107');
INSERT INTO LISTING_AMENITY VALUES ('A007', 'L109');
INSERT INTO LISTING_AMENITY VALUES ('A006', 'L109');
INSERT INTO LISTING_AMENITY VALUES ('A020', 'L110');
INSERT INTO LISTING_AMENITY VALUES ('A029', 'L111');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L112');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L113');
INSERT INTO LISTING_AMENITY VALUES ('A011', 'L114');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L117');
INSERT INTO LISTING_AMENITY VALUES ('A003', 'L117');
INSERT INTO LISTING_AMENITY VALUES ('A002', 'L117');
INSERT INTO LISTING_AMENITY VALUES ('A002', 'L118');
INSERT INTO LISTING_AMENITY VALUES ('A002', 'L119');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L120');
INSERT INTO LISTING_AMENITY VALUES ('A018', 'L123');
INSERT INTO LISTING_AMENITY VALUES ('A011', 'L123');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L123');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L124');
INSERT INTO LISTING_AMENITY VALUES ('A037', 'L125');
INSERT INTO LISTING_AMENITY VALUES ('A037', 'L126');
INSERT INTO LISTING_AMENITY VALUES ('A037', 'L129');
INSERT INTO LISTING_AMENITY VALUES ('A013', 'L129');
INSERT INTO LISTING_AMENITY VALUES ('A011', 'L129');
INSERT INTO LISTING_AMENITY VALUES ('A017', 'L130');
INSERT INTO LISTING_AMENITY VALUES ('A017', 'L131');
INSERT INTO LISTING_AMENITY VALUES ('A008', 'L132');
INSERT INTO LISTING_AMENITY VALUES ('A011', 'L133');
INSERT INTO LISTING_AMENITY VALUES ('A009', 'L134');
INSERT INTO LISTING_AMENITY VALUES ('A002', 'L137');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L137');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L137');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L138');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L139');
INSERT INTO LISTING_AMENITY VALUES ('A016', 'L141');
INSERT INTO LISTING_AMENITY VALUES ('A018', 'L141');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L142');
INSERT INTO LISTING_AMENITY VALUES ('A018', 'L143');
INSERT INTO LISTING_AMENITY VALUES ('A050', 'L145');
INSERT INTO LISTING_AMENITY VALUES ('A024', 'L145');
INSERT INTO LISTING_AMENITY VALUES ('A017', 'L147');
INSERT INTO LISTING_AMENITY VALUES ('A018', 'L147');
INSERT INTO LISTING_AMENITY VALUES ('A001', 'L148');
INSERT INTO LISTING_AMENITY VALUES ('A016', 'L150');
INSERT INTO LISTING_AMENITY VALUES ('A004', 'L150');

-- Bookings table

INSERT INTO BOOKING VALUES ('B101','C005','L112',TO_DATE('04-MAY-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('10-JUN-2025', 'DD-MON-YYYY'),TO_DATE('15-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B102','C002','L102',TO_DATE('02-AUG-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('09-AUG-2025', 'DD-MON-YYYY'),TO_DATE('12-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B103','C024','L113',TO_DATE('08-JUN-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('12-JUL-2025', 'DD-MON-YYYY'),TO_DATE('13-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B104','C003','L150',TO_DATE('18-SEP-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('19-SEP-2025', 'DD-MON-YYYY'),TO_DATE('21-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B105','C001','L102',TO_DATE('14-AUG-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('27-AUG-2025', 'DD-MON-YYYY'),TO_DATE('05-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B106','C010','L147',TO_DATE('19-JUL-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('04-AUG-2025', 'DD-MON-YYYY'),TO_DATE('15-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B107','C011','L108',TO_DATE('01-JAN-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('09-FEB-2025', 'DD-MON-YYYY'),TO_DATE('15-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B108','C025','L114',TO_DATE('27-JUL-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('04-AUG-2025', 'DD-MON-YYYY'),TO_DATE('07-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B109','C040','L117',TO_DATE('03-JUN-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('05-JUN-2025', 'DD-MON-YYYY'),TO_DATE('08-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B110','C045','L129',TO_DATE('16-APR-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('20-MAY-2024', 'DD-MON-YYYY'),TO_DATE('23-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B111','C050','L138',TO_DATE('06-JUN-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('08-AUG-2025', 'DD-MON-YYYY'),TO_DATE('10-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B112','C012','L115',TO_DATE('09-NOV-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('03-DEC-2024', 'DD-MON-YYYY'),TO_DATE('20-DEC-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B113','C001','L112',TO_DATE('23-JUL-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('01-AUG-2025', 'DD-MON-YYYY'),TO_DATE('10-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B114','C013','L120',TO_DATE('15-DEC-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('25-DEC-2024', 'DD-MON-YYYY'),TO_DATE('01-JAN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B115','C035','L136',TO_DATE('20-OCT-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('19-OCT-2025', 'DD-MON-YYYY'),TO_DATE('31-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B116','C034','L104',TO_DATE('05-SEP-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('21-SEP-2025', 'DD-MON-YYYY'),TO_DATE('23-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B117','C032','L101',TO_DATE('23-JAN-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('13-FEB-2025', 'DD-MON-YYYY'),TO_DATE('14-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B118','C023','L145',TO_DATE('14-FEB-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('20-FEB-2025', 'DD-MON-YYYY'),TO_DATE('28-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B119','C025','L138',TO_DATE('08-AUG-2024', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('05-SEP-2024', 'DD-MON-YYYY'),TO_DATE('08-SEP-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B120','C050','L132',TO_DATE('28-MAR-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('04-APR-2025', 'DD-MON-YYYY'),TO_DATE('18-APR-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B121','C018','L105',TO_DATE('19-AUG-2024', 'DD-MON-YYYY'),
 'CHECK',TO_DATE('08-SEP-2024', 'DD-MON-YYYY'),TO_DATE('18-SEP-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B122','C019','L109',TO_DATE('25-AUG-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('01-SEP-2025', 'DD-MON-YYYY'),TO_DATE('13-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B123','C029','L110',TO_DATE('25-MAR-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('16-MAY-2025', 'DD-MON-YYYY'),TO_DATE('20-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B124','C017','L150',TO_DATE('23-SEP-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('01-OCT-2025', 'DD-MON-YYYY'),TO_DATE('09-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B125','C019','L127',TO_DATE('12-JUN-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('03-JUL-2025', 'DD-MON-YYYY'),TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B126','C014','L122',TO_DATE('23-SEP-2024', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('28-SEP-2024', 'DD-MON-YYYY'),TO_DATE('01-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B127','C008','L132',TO_DATE('02-APR-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('24-APR-2025', 'DD-MON-YYYY'),TO_DATE('28-APR-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B128','C033','L102',TO_DATE('05-SEP-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('08-SEP-2025', 'DD-MON-YYYY'),TO_DATE('16-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B129','C006','L105',TO_DATE('21-JAN-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('03-MAR-2025', 'DD-MON-YYYY'),TO_DATE('08-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B130','C009','L112',TO_DATE('04-AUG-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('04-SEP-2025', 'DD-MON-YYYY'),TO_DATE('08-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B131','C011','L128',TO_DATE('22-JUL-2024', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('08-AUG-2024', 'DD-MON-YYYY'),TO_DATE('14-AUG-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B132','C007','L145',TO_DATE('28-APR-2025', 'DD-MON-YYYY'),
 'DEBIT CARD',TO_DATE('01-MAY-2025', 'DD-MON-YYYY'),TO_DATE('12-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B133','C034','L103',TO_DATE('14-SEP-2025', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('20-SEP-2025', 'DD-MON-YYYY'),TO_DATE('28-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B134','C048','L119',TO_DATE('07-APR-2025', 'DD-MON-YYYY'),
 'CHECK',TO_DATE('16-MAY-2025', 'DD-MON-YYYY'),TO_DATE('20-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B135','C043','L136',TO_DATE('29-OCT-2025', 'DD-MON-YYYY'),
 'CHECK',TO_DATE('13-NOV-2025', 'DD-MON-YYYY'),TO_DATE('16-NOV-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B136','C022','L122',TO_DATE('24-DEC-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('13-MAR-2025', 'DD-MON-YYYY'),TO_DATE('18-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B137','C034','L107',TO_DATE('13-DEC-2024', 'DD-MON-YYYY'),
 'CREDIT CARD',TO_DATE('08-JAN-2025', 'DD-MON-YYYY'),TO_DATE('19-JAN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B138','C047','L141',TO_DATE('12-JUN-2024', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('01-AUG-2024', 'DD-MON-YYYY'),TO_DATE('05-AUG-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B139','C004','L115',TO_DATE('20-JAN-2025', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('10-FEB-2025', 'DD-MON-YYYY'),TO_DATE('15-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B140','C007','L130',TO_DATE('08-MAY-2025', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('02-JUL-2025', 'DD-MON-YYYY'),TO_DATE('04-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B141','C050','L148',TO_DATE('27-APR-2025', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('01-JUN-2025', 'DD-MON-YYYY'),TO_DATE('18-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B142','C010','L109',TO_DATE('10-SEP-2025', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('08-OCT-2025', 'DD-MON-YYYY'),TO_DATE('10-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B143','C016','L125',TO_DATE('01-MAY-2025', 'DD-MON-YYYY'),
 'APPLE PAY',TO_DATE('05-JUL-2025', 'DD-MON-YYYY'),TO_DATE('07-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B144','C031','L133',TO_DATE('23-MAR-2025', 'DD-MON-YYYY'),
 'APPLE PAY',TO_DATE('18-AUG-2025', 'DD-MON-YYYY'),TO_DATE('21-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B145','C039','L112',TO_DATE('23-AUG-2025', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('12-DEC-2025', 'DD-MON-YYYY'),TO_DATE('27-DEC-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B146','C018','L140',TO_DATE('01-DEC-2024', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('01-MAR-2025', 'DD-MON-YYYY'),TO_DATE('15-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B147','C049','L106',TO_DATE('12-APR-2024', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('06-JUN-2024', 'DD-MON-YYYY'),TO_DATE('10-JUN-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B148','C012','L128',TO_DATE('18-SEP-2024', 'DD-MON-YYYY'),
 'PAYPAL',TO_DATE('23-OCT-2024', 'DD-MON-YYYY'),TO_DATE('01-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B149','C016','L101',TO_DATE('15-MAR-2025', 'DD-MON-YYYY'),
 'GOOGLE PAY',TO_DATE('12-JUN-2025', 'DD-MON-YYYY'),TO_DATE('15-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO BOOKING VALUES ('B150','C001','L123',TO_DATE('08-AUG-2025', 'DD-MON-YYYY'),
 'CHECK',TO_DATE('11-OCT-2025', 'DD-MON-YYYY'),TO_DATE('14-OCT-2025', 'DD-MON-YYYY'));

--Review Table (Fixed - Only clients who actually booked the listings)

INSERT INTO review VALUES ('R001', 'L112', 'C005', 4.5, 'Guest suite was perfect for my solo trip. Clean and comfortable.', TO_DATE('16-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R002', 'L102', 'C002', 4.8, 'Luxury hotel experience in the heart of Chicago. Highly recommend!', TO_DATE('13-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R003', 'L113', 'C024', 4.2, 'Fabulous views of the city! Great location for exploring LA.', TO_DATE('14-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R004', 'L150', 'C003', 5.0, 'Lake front home was perfect! Great for our group getaway.', TO_DATE('22-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R005', 'L102', 'C001', 4.7, 'Luxury hotel experience was amazing! Perfect for business travel.', TO_DATE('06-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R006', 'L147', 'C010', 4.9, 'Maine cottage was perfect! Ocean views and privacy were amazing.', TO_DATE('16-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R007', 'L108', 'C011', 4.3, 'Tiny home was adorable! Perfect for experiencing minimalist living.', TO_DATE('16-FEB-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R008', 'L114', 'C025', 4.6, 'Luxury penthouse with amazing amenities. Pool and jacuzzi were fantastic!', TO_DATE('08-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R009', 'L117', 'C040', 4.2, 'Luxe loft was nice but parking was a bit challenging.', TO_DATE('09-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R010', 'L129', 'C045', 4.8, 'Gatlinburg cabin was incredible! 6 bedrooms and amazing views.', TO_DATE('24-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R011', 'L138', 'C050', 4.1, 'Bozeman luxury was perfect! Modern design and great location.', TO_DATE('11-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R012', 'L112', 'C005', 4.5, 'Guest suite was perfect for my solo trip. Clean and comfortable.', TO_DATE('11-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R013', 'L113', 'C024', 4.3, 'Fabulous views of the city! Great location for exploring LA.', TO_DATE('14-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R014', 'L114', 'C025', 4.7, 'Luxury penthouse with amazing amenities. Pool and jacuzzi were fantastic!', TO_DATE('08-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R015', 'L115', 'C012', 4.6, 'Luxe room was perfect for my business trip. Great location near LAX.', TO_DATE('21-DEC-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R016', 'L104', 'C034', 4.8, 'Incredible experience knowing our stay helps the homeless. Beautiful room too!', TO_DATE('24-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R017', 'L117', 'C040', 4.2, 'Luxe loft was nice but parking was a bit challenging.', TO_DATE('09-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R018', 'L101', 'C032', 4.9, 'Amazing cabin experience! Perfect for a romantic getaway.', TO_DATE('16-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R019', 'L119', 'C048', 4.7, 'Desert villa was incredible! Pool and hot tub with desert views were amazing.', TO_DATE('21-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R020', 'L120', 'C013', 4.5, 'A-Frame cabin was beautiful and well-designed. Hot tub was perfect!', TO_DATE('02-JAN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R021', 'L145', 'C023', 4.8, 'Desert Airstream was unique! Mountain views and firepit were great.', TO_DATE('01-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R022', 'L122', 'C012', 4.6, 'Luxury mountain home was spectacular! Views were breathtaking.', TO_DATE('02-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R023', 'L123', 'C001', 4.9, 'Malibu retreat was absolutely perfect! Ocean views and infinity pool were incredible.', TO_DATE('15-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R024', 'L132', 'C008', 4.7, 'Luxury lodge was perfect! Hot tub and panoramic views were amazing.', TO_DATE('29-APR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R025', 'L125', 'C016', 4.4, 'Beach house was great! Pool and beach access were perfect for our family.', TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R026', 'L126', 'C008', 4.8, 'Paradiso estate was incredible! Private and luxurious with amazing amenities.', TO_DATE('02-OCT-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R027', 'L127', 'C019', 4.5, 'Oceanfront condo was perfect! Beach access and views were amazing.', TO_DATE('09-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R028', 'L128', 'C019', 4.6, 'Truckee rental was perfect for our ski trip! Hot tub and mountain views were great.', TO_DATE('02-NOV-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R029', 'L129', 'C045', 4.9, 'Gatlinburg cabin was incredible! 6 bedrooms and amazing views.', TO_DATE('24-MAY-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R030', 'L130', 'C007', 4.7, 'Starry night cabin was perfect! Hot tub and mountain views were magical.', TO_DATE('05-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R031', 'L131', 'C016', 4.8, 'Park City chateau was incredible! Perfect for our large group ski trip.', TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R032', 'L132', 'C008', 4.6, 'Luxury lodge was perfect! Hot tub and panoramic views were amazing.', TO_DATE('29-APR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R033', 'L133', 'C031', 4.9, 'Beach front home was incredible! Private beach and pool were perfect.', TO_DATE('22-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R034', 'L134', 'C016', 4.5, 'Coachella Valley home was perfect! Pool and hot tub were great.', TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R035', 'L135', 'C018', 4.7, 'Michiana Shores was perfect! Pool and lake access were amazing.', TO_DATE('16-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R036', 'L136', 'C035', 4.8, 'Hollywood Hills home was incredible! City views and amenities were perfect.', TO_DATE('01-NOV-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R037', 'L137', 'C043', 4.4, 'Blue Valley Chalet was perfect for our ski trip! Modern and comfortable.', TO_DATE('17-NOV-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R038', 'L138', 'C050', 4.6, 'Bozeman luxury was perfect! Modern design and great location.', TO_DATE('19-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R039', 'L139', 'C018', 4.9, 'Mountain top home was incredible! Views and design were spectacular.', TO_DATE('16-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R040', 'L140', 'C016', 4.5, 'Seacrest Beach home was perfect! Beach access and amenities were great.', TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R041', 'L141', 'C047', 4.7, 'Malibu retreat was perfect! Ocean views and privacy were amazing.', TO_DATE('06-AUG-2024', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R042', 'L142', 'C016', 4.3, 'Jackson condo was nice! Mountain views were beautiful.', TO_DATE('08-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R043', 'L143', 'C010', 4.8, 'Waterfront retreat was incredible! Ocean views and dock were perfect.', TO_DATE('11-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R044', 'L144', 'C007', 4.9, 'Seattle luxury home was incredible! Skyline views and amenities were perfect.', TO_DATE('05-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R045', 'L145', 'C023', 4.4, 'Desert Airstream was unique! Mountain views and firepit were great.', TO_DATE('01-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R046', 'L146', 'C010', 4.2, 'Cowboy bunkhouse was fun! Unique experience in Scottsdale.', TO_DATE('11-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R047', 'L147', 'C010', 4.6, 'Maine cottage was perfect! Ocean views and privacy were amazing.', TO_DATE('11-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R048', 'L148', 'C050', 4.3, 'Farm cottage was rustic but fun! Unique experience in Maine.', TO_DATE('19-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R049', 'L149', 'C001', 4.7, 'Geodome was incredible! Secluded and unique experience.', TO_DATE('15-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO review VALUES ('R050', 'L150', 'C017', 4.5, 'Lake front home was perfect! Great for our group getaway.', TO_DATE('10-OCT-2025', 'DD-MON-YYYY'));

--Dates Available Table

INSERT INTO dates_available VALUES ('D001', 'L101', TO_DATE('01-MAR-2025', 'DD-MON-YYYY'), TO_DATE('31-MAR-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D002', 'L102', TO_DATE('01-APR-2025', 'DD-MON-YYYY'), TO_DATE('30-APR-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D003', 'L103', TO_DATE('01-MAY-2025', 'DD-MON-YYYY'), TO_DATE('31-MAY-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D004', 'L104', TO_DATE('01-JUN-2025', 'DD-MON-YYYY'), TO_DATE('30-JUN-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D005', 'L105', TO_DATE('01-JUL-2025', 'DD-MON-YYYY'), TO_DATE('31-JUL-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D006', 'L106', TO_DATE('01-AUG-2025', 'DD-MON-YYYY'), TO_DATE('31-AUG-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D007', 'L107', TO_DATE('01-SEP-2025', 'DD-MON-YYYY'), TO_DATE('30-SEP-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D008', 'L108', TO_DATE('01-OCT-2025', 'DD-MON-YYYY'), TO_DATE('31-OCT-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D009', 'L109', TO_DATE('01-NOV-2025', 'DD-MON-YYYY'), TO_DATE('30-NOV-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D010', 'L110', TO_DATE('01-DEC-2025', 'DD-MON-YYYY'), TO_DATE('31-DEC-2025', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D011', 'L111', TO_DATE('01-JAN-2026', 'DD-MON-YYYY'), TO_DATE('31-JAN-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D012', 'L112', TO_DATE('01-FEB-2026', 'DD-MON-YYYY'), TO_DATE('28-FEB-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D013', 'L113', TO_DATE('01-MAR-2026', 'DD-MON-YYYY'), TO_DATE('31-MAR-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D014', 'L114', TO_DATE('01-APR-2026', 'DD-MON-YYYY'), TO_DATE('30-APR-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D015', 'L115', TO_DATE('01-MAY-2026', 'DD-MON-YYYY'), TO_DATE('31-MAY-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D016', 'L116', TO_DATE('01-JUN-2026', 'DD-MON-YYYY'), TO_DATE('30-JUN-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D017', 'L117', TO_DATE('01-JUL-2026', 'DD-MON-YYYY'), TO_DATE('31-JUL-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D018', 'L118', TO_DATE('01-AUG-2026', 'DD-MON-YYYY'), TO_DATE('31-AUG-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D019', 'L119', TO_DATE('01-SEP-2026', 'DD-MON-YYYY'), TO_DATE('30-SEP-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D020', 'L120', TO_DATE('01-OCT-2026', 'DD-MON-YYYY'), TO_DATE('31-OCT-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D021', 'L121', TO_DATE('01-NOV-2026', 'DD-MON-YYYY'), TO_DATE('30-NOV-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D022', 'L122', TO_DATE('01-DEC-2026', 'DD-MON-YYYY'), TO_DATE('31-DEC-2026', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D023', 'L123', TO_DATE('01-JAN-2027', 'DD-MON-YYYY'), TO_DATE('31-JAN-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D024', 'L124', TO_DATE('01-FEB-2027', 'DD-MON-YYYY'), TO_DATE('28-FEB-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D025', 'L125', TO_DATE('01-MAR-2027', 'DD-MON-YYYY'), TO_DATE('31-MAR-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D026', 'L126', TO_DATE('01-APR-2027', 'DD-MON-YYYY'), TO_DATE('30-APR-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D027', 'L127', TO_DATE('01-MAY-2027', 'DD-MON-YYYY'), TO_DATE('31-MAY-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D028', 'L128', TO_DATE('01-JUN-2027', 'DD-MON-YYYY'), TO_DATE('30-JUN-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D029', 'L129', TO_DATE('01-JUL-2027', 'DD-MON-YYYY'), TO_DATE('31-JUL-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D030', 'L130', TO_DATE('01-AUG-2027', 'DD-MON-YYYY'), TO_DATE('31-AUG-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D031', 'L131', TO_DATE('01-SEP-2027', 'DD-MON-YYYY'), TO_DATE('30-SEP-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D032', 'L132', TO_DATE('01-OCT-2027', 'DD-MON-YYYY'), TO_DATE('31-OCT-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D033', 'L133', TO_DATE('01-NOV-2027', 'DD-MON-YYYY'), TO_DATE('30-NOV-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D034', 'L134', TO_DATE('01-DEC-2027', 'DD-MON-YYYY'), TO_DATE('31-DEC-2027', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D035', 'L135', TO_DATE('01-JAN-2028', 'DD-MON-YYYY'), TO_DATE('31-JAN-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D036', 'L136', TO_DATE('01-FEB-2028', 'DD-MON-YYYY'), TO_DATE('29-FEB-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D037', 'L137', TO_DATE('01-MAR-2028', 'DD-MON-YYYY'), TO_DATE('31-MAR-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D038', 'L138', TO_DATE('01-APR-2028', 'DD-MON-YYYY'), TO_DATE('30-APR-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D039', 'L139', TO_DATE('01-MAY-2028', 'DD-MON-YYYY'), TO_DATE('31-MAY-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D040', 'L140', TO_DATE('01-JUN-2028', 'DD-MON-YYYY'), TO_DATE('30-JUN-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D041', 'L141', TO_DATE('01-JUL-2028', 'DD-MON-YYYY'), TO_DATE('31-JUL-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D042', 'L142', TO_DATE('01-AUG-2028', 'DD-MON-YYYY'), TO_DATE('31-AUG-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D043', 'L143', TO_DATE('01-SEP-2028', 'DD-MON-YYYY'), TO_DATE('30-SEP-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D044', 'L144', TO_DATE('01-OCT-2028', 'DD-MON-YYYY'), TO_DATE('31-OCT-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D045', 'L145', TO_DATE('01-NOV-2028', 'DD-MON-YYYY'), TO_DATE('30-NOV-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D046', 'L146', TO_DATE('01-DEC-2028', 'DD-MON-YYYY'), TO_DATE('31-DEC-2028', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D047', 'L147', TO_DATE('01-JAN-2029', 'DD-MON-YYYY'), TO_DATE('31-JAN-2029', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D048', 'L148', TO_DATE('01-FEB-2029', 'DD-MON-YYYY'), TO_DATE('28-FEB-2029', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D049', 'L149', TO_DATE('01-MAR-2029', 'DD-MON-YYYY'), TO_DATE('31-MAR-2029', 'DD-MON-YYYY'));
INSERT INTO dates_available VALUES ('D050', 'L150', TO_DATE('01-APR-2029', 'DD-MON-YYYY'), TO_DATE('30-APR-2029', 'DD-MON-YYYY'));

SELECT COUNT(*) AS CLIENT_COUNT FROM client;
SELECT COUNT(*) AS AMENITTY_COUNT FROM amenity;
SELECT COUNT(*) AS LISTING_AMENITY_COUNT FROM LISTING_AMENITY;
SELECT COUNT(*) AS BOOKING_COUNT FROM BOOKING;
SELECT COUNT(*) AS REVIEW_COUNT FROM review;
SELECT COUNT(*) AS DATES_AVAILABLE_COUNT FROM dates_available;

COMMIT;