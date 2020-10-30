-- Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

CREATE TABLE dw_copies(copyno char(8) PRIMARY KEY, copyloc char(3), material varchar(30));

CREATE TABLE dw_borrowers(bid int PRIMARY KEY, depcode int, sex char(1));

CREATE TABLE dw_dates(date_key date PRIMARY KEY,date_day int, date_week int, date_month int, date_quarter int, date_year int);

CREATE TABLE dw_loanstats(copyno char(8), bid int, date_key date, total_loans int,
PRIMARY KEY(copyno,bid,date_key), 
FOREIGN KEY(copyno) REFERENCES dw_copies(copyno),
FOREIGN KEY(bid) REFERENCES dw_borrowers(bid),
FOREIGN KEY(date_key) REFERENCES dw_dates(date_key));


INSERT INTO dw_copies 
	SELECT copyno, copyloc, material
	FROM LIBRARY.dbo.copies,LIBRARY.dbo.bibrecs
	WHERE LIBRARY.dbo.bibrecs.bibno = LIBRARY.dbo.copies.bibno; 

INSERT INTO dw_borrowers
	SELECT bid,depcode,sex
	FROM LIBRARY.dbo.borrowers;

INSERT INTO dw_dates
	SELECT DISTINCT loandate, DATEPART(DAY,loandate), DATEPART(WEEK,loandate),
					DATEPART(MONTH,loandate), DATEPART(QUARTER,loandate), DATEPART(YEAR,loandate)
	FROM LIBRARY.dbo.loanstats;

INSERT INTO dw_loanstats
	SELECT copyno, bid, loandate, COUNT(lid)
	FROM LIBRARY.dbo.loanstats
	GROUP BY copyno,bid,loandate;