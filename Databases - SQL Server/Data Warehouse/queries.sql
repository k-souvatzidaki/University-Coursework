-- Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

--1) The number of borrowings per year and department

SELECT date_year, depcode, SUM(total_loans) as TOTAL_PER_YEAR_AND_DEPCODE
FROM dw_loanstats, dw_dates, dw_borrowers
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
GROUP BY date_year,depcode
ORDER BY date_year,depcode;


--2) The number of borrowings per location and material

SELECT copyloc,material, SUM(total_loans) as TOTAL_PER_LOCATION_AND_MATERIAL
FROM dw_loanstats, dw_copies
WHERE dw_loanstats.copyno = dw_copies.copyno
GROUP BY copyloc,material
ORDER BY copyloc,material;


--3) The number of borrowings per month and sex in 2000

SELECT date_year, date_month, sex, SUM(total_loans) as TOTAL_PER_MONTH_AND_SEX_2000
FROM dw_loanstats, dw_dates, dw_borrowers
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
AND date_year=2000
GROUP BY date_year,date_month,sex
ORDER BY date_month,sex;


--4) The months of each year with more than 800 borrowings

SELECT date_year,date_month, SUM(total_loans) AS TOTAL_PER_YEAR_MONTH
FROM dw_loanstats, dw_dates
WHERE dw_loanstats.date_key = dw_dates.date_key
GROUP BY date_year,date_month
HAVING COUNT(total_loans) > 800
ORDER BY date_year,date_month;


--5) The total number of borrowings, the number of borrowings per year,
--per year and department, per year,department and sex, in one query

SELECT date_year,depcode,sex,SUM(total_loans) AS TOTAL_ROLLUP
FROM dw_loanstats, dw_dates, dw_borrowers
WHERE dw_loanstats.date_key = dw_dates.date_key
AND dw_loanstats.bid = dw_borrowers.bid
GROUP BY ROLLUP(date_year,depcode,sex)
ORDER BY date_year,depcode,sex;


--6) The departments with a greater total number of borrowings by female students, than male students

SELECT depcode, SUM(case when sex = 'F' then total_loans end) AS TOTAL_FEMALE, SUM(case when sex = 'M' then total_loans end) AS TOTAL_MALE
FROM dw_loanstats, dw_borrowers
WHERE dw_loanstats.bid = dw_borrowers.bid
GROUP BY depcode
HAVING SUM(case when sex = 'F' then total_loans end) > SUM(case when sex = 'M' then total_loans end)
ORDER BY depcode;
