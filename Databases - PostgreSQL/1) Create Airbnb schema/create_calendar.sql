create table Calendar(
   listing_id int,
   date date,
   available boolean,
   price varchar(20),
   PRIMARY KEY(listing_id , date)
);