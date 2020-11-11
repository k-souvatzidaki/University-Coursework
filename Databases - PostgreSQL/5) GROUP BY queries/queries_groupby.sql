/*select the number of amenities per listing if it has any.
Output : 9535 rows*/
SELECT id,name,COUNT(amenity_id) 
FROM Listing_Amenity 
INNER JOIN Listing 
ON listing_id =id
WHERE amenity_id NOT IN( SELECT amenity_id FROM Amenity WHERE amenity_name = '')
GROUP BY id;


/*Select all the Listings that have more than 5 reviews in 2017 
Output : 880 rows */
SELECT Listing.id,name, count(Review.id)
FROM Listing
INNER JOIN Review
ON listing_id = Listing.id
WHERE date >='2017/01/01' AND date <='2017/12/31'
GROUP BY Listing.id
HAVING count(Review.id) > 5
ORDER BY count(Review.id);


/*Select all listings that have been booked in 2017 with an average of their prices <50
Output : 562 rows*/
SELECT id,name, avg(Calendar.price)
FROM Listing
INNER JOIN Calendar
ON listing_id=id
WHERE date>='2017/01/01' AND date<='2017/12/31'
GROUP BY id
HAVING avg(Calendar.price) < 50;


/*Print the lowest price in each neighbourhood
Output : 81 rows*/
SELECT neighborhood_name, MIN(price)
FROM Listing
INNER JOIN Neighborhood
ON neighborhood_name = neighborhood
group by neighborhood_name;


/*Select the number of listings that provide each one of the amenities
Output : 52 rows*/
SELECT amenity_name, COUNT(listing_id)
FROM Amenity 
INNER JOIN  Listing_Amenity
ON Amenity.amenity_id = Listing_Amenity.amenity_id
GROUP BY amenity_name;


/*Select the greatest price for each Listing
Output: 9663 rows*/
SELECT listing_id, MAX(price) 
FROM Calendar 
GROUP BY listing_id
ORDER BY listing_id DESC;