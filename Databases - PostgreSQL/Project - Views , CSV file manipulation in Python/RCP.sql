--Creating views 


/* TOTAL: 1,921 rows without nulls (Rental_Price.price != null), 2,143 with nulls  */


/* Boston: 837 rows without nulls (Rental_Price.price != null), 897 with nulls */
CREATE VIEW boston_v_Revenue_Crossover AS SELECT zip_code, Rental_Price.date, Rental_Price.bedrooms, Rental_Price.price AS zillow_price,
	   percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END ) as airbnb_median
		,ceil(Rental_Price.price/percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END )) AS revenue_crossover_point
		
FROM Rental_Price 
INNER JOIN Listing
ON TRIM(LEADING '0' FROM Listing.zipcode) = cast(Rental_Price.zip_code AS varchar) and CASE 
																   						  WHEN rental_price.bedrooms < 5 THEN Listing.bedrooms = Rental_Price.bedrooms
																   						  ELSE Listing.bedrooms > 4 END
INNER JOIN Calendar
ON date(date_trunc('month',Calendar.date)) = Rental_Price.date AND Calendar.listing_id = Listing.id
WHERE zip_code IN (SELECT zip_code FROM Location WHERE city = 'Boston') AND Rental_Price.price IS NOT NULL 
				   AND Rental_Price.date IS NOT NULL AND Rental_Price.zip_code IS NOT NULL 
				   AND Listing.room_type = 'Entire home/apt'
				   
GROUP BY zip_code,Rental_Price.date,Rental_Price.bedrooms
ORDER BY Rental_Price.bedrooms;


/* Denver: 255 rows without nulls (Rental_Price.price != null), 390 with nulls */
CREATE VIEW denver_v_Revenue_Crossover AS SELECT zip_code, Rental_Price.date, Rental_Price.bedrooms, Rental_Price.price AS zillow_price,
	   percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END ) as airbnb_median
		,ceil(Rental_Price.price/percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END )) AS revenue_crossover_point
		
FROM Rental_Price 
INNER JOIN Listing
ON TRIM(LEADING '0' FROM Listing.zipcode) = cast(Rental_Price.zip_code AS varchar) and CASE 
																   						  WHEN rental_price.bedrooms < 5 THEN Listing.bedrooms = Rental_Price.bedrooms
																   						  ELSE Listing.bedrooms > 4 END
INNER JOIN Calendar
ON date(date_trunc('month',Calendar.date)) = Rental_Price.date AND Calendar.listing_id = Listing.id
WHERE zip_code IN (SELECT zip_code FROM Location WHERE city = 'Denver') AND Rental_Price.price IS NOT NULL 
				   AND Rental_Price.date IS NOT NULL AND Rental_Price.zip_code IS NOT NULL 
				   AND Listing.room_type = 'Entire home/apt'
				   
GROUP BY zip_code,Rental_Price.date,Rental_Price.bedrooms
ORDER BY Rental_Price.bedrooms


/* Portland: 246 rows without nulls (Rental_Price.price != null), 273 with nulls  */
CREATE VIEW portland_v_Revenue_Crossover AS SELECT zip_code, Rental_Price.date, Rental_Price.bedrooms, Rental_Price.price AS zillow_price,
	   percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END ) as airbnb_median
		,ceil(Rental_Price.price/percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END )) AS revenue_crossover_point
		
FROM Rental_Price 
INNER JOIN Listing
ON TRIM(LEADING '0' FROM Listing.zipcode) = cast(Rental_Price.zip_code AS varchar) and CASE 
																   						  WHEN rental_price.bedrooms < 5 THEN Listing.bedrooms = Rental_Price.bedrooms
																   						  ELSE Listing.bedrooms > 4 END
INNER JOIN Calendar
ON date(date_trunc('month',Calendar.date)) = Rental_Price.date AND Calendar.listing_id = Listing.id
WHERE zip_code IN (SELECT zip_code FROM Location WHERE city = 'Portland') AND Rental_Price.price IS NOT NULL 
				   AND Rental_Price.date IS NOT NULL AND Rental_Price.zip_code IS NOT NULL 
				   AND Listing.room_type = 'Entire home/apt'
				   
GROUP BY zip_code,Rental_Price.date,Rental_Price.bedrooms
ORDER BY Rental_Price.bedrooms;


/* Austin: 583 rows without nulls (Rental_Price.price != null), 583 with nulls  */
CREATE VIEW austin_v_Revenue_Crossover AS SELECT zip_code, Rental_Price.date, Rental_Price.bedrooms, Rental_Price.price AS zillow_price,
	   percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END ) as airbnb_median
		,ceil(Rental_Price.price/percentile_cont(0.5) within group(order by 
										 CASE
										 	WHEN Calendar.price IS NULL THEN Listing.price
											ELSE Calendar.price END )) AS revenue_crossover_point
		
FROM Rental_Price 
INNER JOIN Listing
ON TRIM(LEADING '0' FROM Listing.zipcode) = cast(Rental_Price.zip_code AS varchar) and CASE 
																   						  WHEN rental_price.bedrooms < 5 THEN Listing.bedrooms = Rental_Price.bedrooms
																   						  ELSE Listing.bedrooms > 4 END
INNER JOIN Calendar
ON date(date_trunc('month',Calendar.date)) = Rental_Price.date AND Calendar.listing_id = Listing.id
WHERE zip_code IN (SELECT zip_code FROM Location WHERE city = 'Austin') AND Rental_Price.price IS NOT NULL 
				   AND Rental_Price.date IS NOT NULL AND Rental_Price.zip_code IS NOT NULL 
				   AND Listing.room_type = 'Entire home/apt'
				   
GROUP BY zip_code,Rental_Price.date,Rental_Price.bedrooms
ORDER BY Rental_Price.bedrooms;


--Running views

SELECT * FROM boston_v_Revenue_Crossover;
SELECT * FROM denver_v_Revenue_Crossover;
SELECT * FROM portland_v_Revenue_Crossover;
SELECT * FROM austin_v_Revenue_Crossover;