--Creating Calendar_Summary table with data from Listings
CREATE TABLE Calendar_Summary AS 
	SELECT id, calendar_updated, calendar_last_scraped, availability_30,availability_60, availability_90 FROM Listings;
--Renaming the columns of table Calendar_Summary
ALTER TABLE Calendar_Summary RENAME COLUMN id TO listing_id;
ALTER TABLE Calendar_Summary RENAME COLUMN calendar_last_scraped TO from_date;
--Setting Calendar_Summary primary and foreign keys
ALTER TABLE Calendar_Summary ADD PRIMARY KEY(listing_id,from_date);
ALTER TABLE Calendar_Summary ADD FOREIGN KEY(listing_id) REFERENCES Listings(id);
--Deleting columns from Listings
ALTER TABLE Listings DROP COLUMN calendar_updated,DROP COLUMN calendar_last_scraped, DROP COLUMN availability_30, DROP COLUMN availability_60,DROP COLUMN availability_90;