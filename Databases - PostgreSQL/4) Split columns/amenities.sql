--making response_rate in Host table numeric type
UPDATE Host 
SET response_rate = null
WHERE response_rate = 'N/A';
UPDATE Host
SET response_rate = replace(response_rate,'%','');
ALTER TABLE Host ALTER COLUMN response_rate TYPE numeric USING response_rate::numeric;
--split column location to columns city,state,country
ALTER TABLE Host ADD COLUMN city varchar(260), ADD COLUMN state varchar(260), ADD COLUMN country varchar(260);
UPDATE Host
SET city = split_part(location,',',1);
UPDATE Host
SET state = split_part(location,',',2);
UPDATE Host 
SET country = split_part(location,',',3);
ALTER TABLE Host DROP COLUMN location;
--create table Amenity
UPDATE Listing SET amenities = replace(amenities,'{','');
UPDATE Listing SET amenities = replace(amenities,'}','');
UPDATE Listing SET amenities = replace(amenities,'"','');
CREATE TABLE Amenity AS SELECT DISTINCT regexp_split_to_table(amenities,',') FROM Listing;
ALTER TABLE Amenity ADD COLUMN amenity_id SERIAL PRIMARY KEY;
ALTER TABLE Amenity RENAME COLUMN regexp_split_to_table TO amenity_name;
--creating table Listing_Amenity to have a relation between Listing and Amenity
CREATE TABLE Listing_Amenity AS SELECT id,regexp_split_to_table(amenities,',') FROM Listing;
ALTER TABLE Listing_Amenity RENAME COLUMN id TO listing_id;
ALTER TABLE Listing_Amenity ADD COLUMN amenity_id integer;
UPDATE Listing_Amenity SET amenity_id = Amenity.amenity_id from Amenity WHERE amenity_name = regexp_split_to_table;
ALTER TABLE Listing_Amenity DROP COLUMN regexp_split_to_table;
ALTER TABLE Listing_Amenity ADD PRIMARY KEY(listing_id, amenity_id);
ALTER TABLE Listing_Amenity ADD FOREIGN KEY(listing_id) REFERENCES Listing(id);
ALTER TABLE Listing_Amenity ADD FOREIGN KEY(amenity_id) REFERENCES Amenity(amenity_id);
--delete column amenities from Listing 
ALTER TABLE Listing DROP COLUMN amenities;