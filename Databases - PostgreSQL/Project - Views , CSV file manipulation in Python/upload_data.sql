set client_encoding to 'utf-8';

/* UPLOAD NEW AIRBNB DATA */

/*upload hosts*/
\copy host FROM 'data/output/all_hosts_noduplicates.csv' DELIMITER ',' CSV HEADER

/*upload neighborhoods*/
\copy neighborhood FROM 'data/output/neighborhoodB_fixed.csv' DELIMITER ',' CSV HEADER
\copy neighborhood FROM 'data/denver_normalizedCSVs/neighborhood.csv' DELIMITER ',' CSV HEADER
\copy neighborhood FROM 'data/output/neighborhoodP_fixed.csv' DELIMITER ',' CSV HEADER

/* upload listings*/
--some values where too long for this field
ALTER TABLE listing ALTER COLUMN city TYPE varchar(150) USING city::varchar;
ALTER TABLE listing ALTER COLUMN market TYPE varchar(150) USING market::varchar;
ALTER TABLE listing ALTER COLUMN license TYPE text USING license::text;
ALTER TABLE listing ALTER COLUMN jurisdiction_names TYPE varchar(150) USING jurisdiction_names::varchar;
ALTER TABLE listing ALTER COLUMN description TYPE text USING description::text;
ALTER TABLE listing ALTER COLUMN transit TYPE text USING transit::text;
ALTER TABLE listing ALTER COLUMN space TYPE text USING space::text;
ALTER TABLE listing ALTER COLUMN neighborhood_overview TYPE text USING neighborhood_overview::text;
\copy listing FROM 'data/output/listingB_fixed.csv' DELIMITER ',' CSV HEADER
\copy listing FROM 'data/output/listingD_fixed.csv' DELIMITER ',' CSV HEADER
\copy listing FROM 'data/output/listingP_fixed.csv' DELIMITER ',' CSV HEADER

/*upload amenities and listing amenities*/
\copy amenity FROM 'data/output/amenityB_noduplicates.csv' DELIMITER ',' CSV HEADER
\copy listing_amenity FROM 'data/output/listing2amenityB_fixed.csv' DELIMITER ',' CSV HEADER
\copy listing_amenity FROM 'data/output/listing2amenityD_fixed.csv' DELIMITER ',' CSV HEADER
\copy listing_amenity FROM 'data/output/listing2amenityP_fixed.csv' DELIMITER ',' CSV HEADER

/*upload calendar summary*/
\copy calendar_summary FROM 'data/boston_normalizedCSVs/calendar_summary.csv' DELIMITER ',' CSV HEADER
\copy calendar_summary FROM 'data/denver_normalizedCSVs/calendar_summary.csv' DELIMITER ',' CSV HEADER
\copy calendar_summary FROM 'data/portland_normalizedCSVs/calendar_summary.csv' DELIMITER ',' CSV HEADER


/*upload calendar*/
\copy calendar FROM 'data/output/calendarB_fixed.csv' DELIMITER ',' CSV HEADER
\copy calendar FROM 'data/denver_normalizedCSVs/calendar.csv' DELIMITER ',' CSV HEADER
\copy calendar FROM 'data/portland_normalizedCSVs/calendar.csv' DELIMITER ',' CSV HEADER

/*upload review*/
\copy review FROM 'data/output/reviewB_fixed.csv' DELIMITER ',' CSV HEADER
\copy review FROM 'data/denver_normalizedCSVs/review.csv' DELIMITER ',' CSV HEADER
\copy review FROM 'data/portland_normalizedCSVs/review.csv' DELIMITER ',' CSV HEADER

/*upload summary listing*/
\copy summary_listing FROM 'data/output/summary_listingB_fixed.csv' DELIMITER ',' CSV HEADER
\copy summary_listing FROM 'data/output/summary_listingD_fixed.csv' DELIMITER ',' CSV HEADER
\copy summary_listing FROM 'data/output/summary_listingP_fixed.csv' DELIMITER ',' CSV HEADER


/*upload summary review*/
\copy summary_review FROM 'data/output/summary_reviewB_fixed.csv' DELIMITER ',' CSV HEADER
\copy summary_review FROM 'data/output/summary_review_D.csv' DELIMITER ',' CSV HEADER
\copy summary_review FROM 'data/portland_normalizedCSVs/summary_review.csv' DELIMITER ',' CSV HEADER

/* UPLOAD ZILLOW DATA */

CREATE TABLE Location(zip_code integer PRIMARY KEY, city varchar(150), state varchar(100), metro varchar(150), country_name varchar(100));
CREATE TABLE Rental_Price(zip_code integer, bedrooms integer, sizeRank integer, date date, available boolean,price numeric);
ALTER TABLE Rental_Price ADD PRIMARY KEY(zip_code,date,bedrooms);
ALTER TABLE Rental_Price ADD FOREIGN KEY(zip_code) REFERENCES Location(zip_code);

\copy Location FROM 'data/output/locations.csv' DELIMITER ',' CSV HEADER
\copy Rental_Price FROM 'data/output/rental_price.csv' DELIMITER ',' CSV HEADER