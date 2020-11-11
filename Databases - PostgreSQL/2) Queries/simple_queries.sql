set client_encoding to 'utf-8';

--INNER JOIN QUERIES


/*1 ) Select all Listings that are good for families (have enough beds) ,
and have been booked in Summer of 2017
Output: 2809 rows*/
SELECT DISTINCT id,name,beds
FROM Listings
INNER JOIN Calendar
ON id = listing_id
WHERE beds>=3 AND beds<=6 AND date >='2017/06/01' AND date<='2017/08/31';


/*2 ) Select all reviews for all Listings from a specific Neighbourhood 
Output: 1728 rows*/
SELECT Listings.id, name,  Reviews.comments, neighbourhood_cleansed
FROM Listings
INNER JOIN Reviews
ON Listings.id = Reviews.listing_id
WHERE neighbourhood_cleansed = 78756
ORDER BY Listings.id;


/*3 ) Select first 1000 Listings which were available in June 2017
Output : 1000 rows*/
SELECT DISTINCT Listings.id,name, available 
FROM Listings
INNER JOIN Calendar
ON listing_id = id
WHERE available = true AND date>='2017-06-01' AND date<='2017-06-30'
LIMIT 1000;


/*4 ) Select the reviews posted on the last review date of all listings
Output : 5999 rows*/
SELECT Listings.id,last_review,comments
FROM Listings
INNER JOIN Reviews
ON listing_id = Listings.id AND date = cast(last_review AS date)
ORDER BY listing_id;

	
/*5 )Select the sum of all profits by rentals, in North Loop neighbourhood, in December 2017
Output : 1 row*/
SELECT SUM(cast(substring(replace(Calendar.price, ',', ''),2,10) as float))
FROM Calendar
INNER JOIN Listings
ON listing_id = id 
WHERE neighbourhood= 'North Loop' AND date>='2017/12/24' AND date<='2017/12/31';
	
	
/*6 ) Select all available Listings with a host that is a super host, that were available in New Years Eve of 2015-2018
Output : 929 rows*/
SELECT DISTINCT listing_id,host_name,host_is_superhost,date
FROM Calendar
INNER JOIN Listings
ON listing_id = id
WHERE available = true AND host_is_superhost=true and (DATE='2015/12/31' or DATE='2016/12/31' or DATE='2017/12/31' or DATE='2018/12/31');
	
	
/*7 ) Select the sum of all revenues of all Listings in neighbourhood 'North Loop'
Output : 134 rows*/
SELECT listing_id,SUM(cast(substring(replace(Calendar.price, ',', ''),2,10) as float))
FROM Listings
INNER JOIN Calendar
ON listing_id=id
WHERE neighbourhood = 'North Loop'
GROUP BY listing_id;


/*8 ) Select all reviewers who own a listing
Output : 812 rows */
SELECT DISTINCT reviewer_id, host_id, Listings.id, name
FROM Listings
INNER JOIN Reviews
ON reviewer_id = host_id;


--OUTER JOIN QUERIES 

/*9 ) Show the date and price of all listings available on 17th June of 2017, else print null
Output : 9663 rows*/
SELECT DISTINCT Listings.id,name,date,Calendar.price
FROM Listings
LEFT OUTER JOIN Calendar
ON listing_id = id AND date ='2017/06/17' AND available = true;


/*10 ) Select all reviews posted on the date of the first review of a listing, if there is one
Output : 9714 rows*/
SELECT Listings.id,first_review,comments
FROM Listings
LEFT OUTER JOIN Reviews
ON listing_id = Listings.id AND date = cast(first_review AS date)
ORDER BY Listings.id;


--MORE

/*11 ) Select all the listings with a price greater than the average price
Output : 2911 rows */
SELECT id,name,price
FROM Listings
WHERE (cast(substring(replace(price, ',', ''),2,10) as float)) >
	( SELECT AVG(cast(substring(replace(price, ',', ''),2,10) as float)) FROM Listings);


/*12 )Print how many listings where booked in December 2017
Output : 1 row*/
SELECT COUNT(DISTINCT listing_id)
FROM Calendar 
WHERE date>='2017/12/01' AND date<='2017/12/31' AND available = false;
