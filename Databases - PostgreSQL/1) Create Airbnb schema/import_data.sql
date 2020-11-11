set client_encoding to 'utf-8';
\copy Listings FROM 'airbnb/listings.csv' DELIMITER ',' CSV HEADER
\copy Calendar FROM 'airbnb/calendar.csv' DELIMITER ',' CSV HEADER
\copy Summary_Reviews FROM 'airbnb/summary_reviews.csv' DELIMITER ',' CSV HEADER
\copy Reviews FROM 'airbnb/reviews.csv' DELIMITER ',' CSV HEADER
\copy Summary_Listings FROM 'airbnb/summary_listings.csv' DELIMITER ',' CSV HEADER
\copy Neighbourhoods FROM 'airbnb/neighbourhoods.csv' DELIMITER ',' CSV HEADER