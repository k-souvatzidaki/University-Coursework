--Creating Neighborhood table with data from Listings
CREATE TABLE Neighborhood AS 	
	SELECT DISTINCT neighbourhood,neighbourhood_cleansed FROM Listings;
--Renaming Neighborhood columns and deleting NULL values
ALTER TABLE Neighborhood RENAME COLUMN neighbourhood TO neighborhood_name;
DELETE FROM Neighborhood WHERE neighborhood_name IS NULL;
ALTER TABLE Neighborhood RENAME COLUMN neighbourhood_cleansed TO zip_code;
DELETE FROM Neighborhood WHERE zip_code IS NULL;
--Removing column neighbourhood_group_cleansed from table Listings
ALTER TABLE Listings DROP COLUMN neighbourhood_group_cleansed;
--Deleting table Neighbourhoods (removing foreign key from Listings first)
ALTER TABLE Listings DROP CONSTRAINT listings_neighbourhood_cleansed_fkey;
DROP TABLE Neighbourhoods;
--Renaming column neighbourhood in Listings table
ALTER TABLE Listings RENAME COLUMN neighbourhood TO neighborhood;
--Adding primary key in Neighborhood
ALTER TABLE Neighborhood ADD PRIMARY KEY(neighborhood_name,zip_code);
--Adding foreign key in Listings
ALTER TABLE Listings ADD FOREIGN KEY(neighborhood,neighbourhood_cleansed) REFERENCES Neighborhood(neighborhood_name,zip_code);
--Renaming column neighbourhood in Summary_Listings
ALTER TABLE Summary_Listings RENAME COLUMN neighbourhood TO zip_code;
--Removing column neighbourhood_group in Summary_Listings
ALTER TABLE Summary_Listings DROP COLUMN neighbourhood_group;
