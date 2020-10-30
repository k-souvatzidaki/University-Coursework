-- Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

--Create a data cube for (year, location, gender)

--1)With the CUBE operator

SELECT date_year,copyloc,sex, SUM(total_loans) AS TOTAL_CUBE
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY CUBE(date_year,copyloc,sex)
ORDER BY date_year,copyloc,sex;

--2)With GROUP BY and aggregation

SELECT null AS date_year,null AS copyloc,null AS sex, SUM(total_loans) AS TOTAL_GROUPBY
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
UNION
SELECT date_year,null,null, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY(date_year)
UNION
SELECT null,copyloc,null, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY(copyloc)
UNION
SELECT null,null,sex, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY(sex)
UNION
SELECT date_year,copyloc,null, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY date_year,copyloc
UNION
SELECT null,copyloc,sex, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY copyloc,sex
UNION
SELECT date_year,null,sex, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY date_year,sex
UNION
SELECT date_year,copyloc,sex, SUM(total_loans)
FROM dw_loanstats,dw_dates,dw_borrowers,dw_copies
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND dw_loanstats.copyno = dw_copies.copyno
GROUP BY date_year, copyloc,sex;
