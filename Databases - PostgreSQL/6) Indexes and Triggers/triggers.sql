/*Trigger and trigger function to increase/decrease the total reviews counter from Listing
every time a review is inserted/deleted from the Review table*/

CREATE OR REPLACE FUNCTION change_num_of_reviews() RETURNS TRIGGER AS $num$
BEGIN
IF (TG_OP = 'INSERT') THEN 
	UPDATE Listing SET number_of_reviews = number_of_reviews +1 WHERE Listing.id = NEW.listing_id;
	RETURN NEW;
ELSIF (TG_OP = 'DELETE') THEN
	UPDATE Listing SET number_of_reviews = number_of_reviews -1 WHERE Listing.id = OLD.listing_id;
	RETURN OLD;
END IF;
RETURN NULL;
END; $num$ LANGUAGE plpgsql;

CREATE TRIGGER change_num_of_reviews
AFTER DELETE OR INSERT
ON Review
FOR EACH ROW
EXECUTE PROCEDURE change_num_of_reviews();

/*Trigger and trigger function to insert a summary review in table Summary_Review every time 
a review is inserted in table Review, if not already exists*/
  
CREATE OR REPLACE FUNCTION add_summary_review() RETURNS TRIGGER AS $sum_rev$
BEGIN 
INSERT INTO Summary_Review(listing_id,date) 
SELECT NEW.listing_id,NEW.date 
WHERE NOT EXISTS(SELECT * FROM Summary_Review WHERE listing_id=NEW.listing_id AND date =NEW.date);
RETURN NEW;
END; $sum_rev$ LANGUAGE plpgsql;

CREATE TRIGGER add_summary_review
AFTER INSERT 
ON Review
FOR EACH ROW
EXECUTE PROCEDURE add_summary_review();


--TEST THE TRIGGERS
--(We tested these on copy tables, not on the originals)

/* number_of_reviews = 31*/
SELECT number_of_reviews FROM Listing WHERE id=2583106;
--DELETE
DELETE FROM Review WHERE listing_id = 2583106 AND id = 13979227;
/* number_of_reviews = 30*/
SELECT number_of_reviews FROM Listing WHERE id=2583106;
--DELETE
DELETE FROM Review WHERE listing_id = 2583106;
/* number_of_reviews = 0*/
SELECT number_of_reviews FROM Listing WHERE id=2583106;
--INSERT
INSERT INTO Review (listing_id,id,date,reviewer_id,reviewer_name,comments)
VALUES (2583106,000001,'2017/12/31',13770615,'Robert','Very good');
/* number_of_reviews = 1*/
SELECT number_of_reviews FROM Listing WHERE id=2583106;

--ADD SOME MORE REVIEWS
SELECT COUNT(*) FROM Summary_Review WHERE listing_id=1078; --167
INSERT INTO Review (listing_id,id,date,reviewer_id,reviewer_name,comments)
VALUES (1078,0000003,'2018/01/09',1344,'Amy','I REALLY HATED IT :(');
INSERT INTO Review (listing_id,id,date,reviewer_id,reviewer_name,comments)
VALUES (1078,0000002,'2018/01/09',1344,'Amy','I actually liked it after all :)');
SELECT COUNT(*) FROM Summary_Review WHERE listing_id=1078; --168
