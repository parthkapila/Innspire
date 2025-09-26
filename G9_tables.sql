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
    tite          VARCHAR2(50)
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

--Host Table
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

--Listing Table
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
    'This house is a MODERN Tiny home featured on the TV show "Modern Tiny Living". 20ft long, it features a kitchen, full bathroom, 1 lofted queen bed, 1 pullout queen bed and lounge area. This home is nestled in the woods on 5 acres of private property. There is a main house on this property which is part of Nashvilles country music royalty landmarks as it had recorded Dolly, George Jones, Tim Mcgraw, Lainey Wilson actually lived on the property for 3 years and many other established famous musicians. This tiny home is a private oasis from the hustle of Nashville. You will feel complete zen being tucked into the woods, while still only 10mins ($12 Uber) to Nashvilles downtown Honky Tonk district. Shopping, Restaurants, a gym, starbucks, mini golf, are all within minutes from this home. There is a lake and private beach only minutes from the Tiny House. If you have never experiences Tiny living, it is time for you to Try It Tiny.', 
    2, 1, 'Nashville', 'TN', '137 Teaticket Hwy', 'Famous Tiny Home from HGTV');
INSERT INTO LISTING
    VALUES
    ('L109', 'H120', TO_DATE('09-AUG-2025', 'DD-MON-YYYY'), 681, 
    'Welcome to The Music City! The peaceful Stolisma Studio is located in trendy Midtown Nashville, on the border of Downtown, Broadway, Music Row, The Parthenon, and Hillsboro Village. Our neighborhood features many chef-driven restaurants and bustling bars. It’s just moments from Vanderbilt Medical Center, Childrens Hospital, the VA Hospital, and Centennial Medical Complex. Its walkability and closeness to both downtown and other unique neighborhoods make it an exceptionally convenient area to stay in Nashville.', 
    1, 1, 'Nashville', 'TV', '42 Fairhaven Commons Way', 'City Apt. | 8 mins. to Broadway, parking/gym/pool');
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
    2, 2, 'Piegon Forge', 'TN', '280 Washington Street', 'Couples getaway w/ hot tub, views, and king beds');
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

select * from host;
select * from listing;
