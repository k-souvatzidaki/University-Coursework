set enable_seqscan = off;

VACUUM ANALYZE Listing;
VACUUM ANALYZE Listing_Amenity;
VACUUM ANALYZE Review;
VACUUM ANALYZE Amenity;
VACUUM ANALYZE Calendar;
VACUUM ANALYZE Calendar_Summary;
VACUUM ANALYZE Summary_Review;
VACUUM ANALYZE Summary_Listing;
VACUUM ANALYZE Host;
VACUUM ANALYZE Neighborhood;


--QUERY 1
CREATE INDEX review_listing_id ON Review(listing_id);

--make some Listing values numeric
ALTER TABLE Listing ALTER COLUMN review_scores_location TYPE numeric USING review_scores_location::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_value TYPE numeric USING review_scores_value::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_communication TYPE numeric USING review_scores_communication::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_checkin TYPE numeric USING review_scores_checkin::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_cleanliness TYPE numeric USING review_scores_cleanliness::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_accuracy TYPE numeric USING review_scores_accuracy::numeric;
ALTER TABLE Listing ALTER COLUMN review_scores_rating TYPE numeric USING review_scores_rating::numeric;

--QUERY 2 
CREATE INDEX listing_query_2 ON Listing(guests_included,review_scores_rating,price);



--ASSIGNMENT QUERIES

--1,5 TEST INDEXES
CREATE INDEX li_amen ON Listing_Amenity(listing_id);
DROP INDEX li_amen;
CREATE INDEX amen_id ON Listing_Amenity(amenity_id);
DROP INDEX amen_id;
CREATE INDEX amen_name ON Amenity(amenity_name);
DROP INDEX amen_name;

--2 TEST INDEXES
CREATE INDEX li_date ON Review(listing_id, date);
DROP INDEX li_date;
CREATE INDEX li ON Review(listing_id);
DROP INDEX li;
CREATE INDEX da ON Review(date);
DROP INDEX da;
CREATE INDEX na ON Listing(name);
DROP INDEX na;

--3
CREATE INDEX listingid_date_price ON Calendar(listing_id,date,price);
--TEST INDEXES
CREATE INDEX calendar_price ON Calendar(price);
CREATE INDEX calendar_listingid_price ON Calendar(listing_id,price);
DROP INDEX calendar_price;
DROP INDEX calendar_listingid_price;

--4
CREATE INDEX neigh_prices ON Listing(neighborhood,price);

--6
CREATE INDEX price_listingid ON Calendar(price,listing_id);