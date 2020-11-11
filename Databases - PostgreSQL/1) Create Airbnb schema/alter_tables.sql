ALTER TABLE Calendar ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);
ALTER TABLE Summary_Listings ADD FOREIGN KEY (id) REFERENCES Listings(id);
ALTER TABLE Reviews ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);
ALTER TABLE Listings ADD FOREIGN KEY (neighbourhood_cleansed) REFERENCES Neighbourhoods(neighbourhood);
ALTER TABLE Summary_Reviews ADD FOREIGN KEY (listing_id) REFERENCES Listings(id);