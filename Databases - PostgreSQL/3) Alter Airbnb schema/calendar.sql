--Removing dollar signs and commas from price field in Calendar table
UPDATE Calendar
SET price = replace(price, ',', '');
UPDATE Calendar
SET price = replace(price, '$', '');
--Changing price field's type from varchar to numeric in Calendar table
ALTER TABLE Calendar ALTER COLUMN price TYPE numeric USING price::numeric;