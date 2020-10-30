-- Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

CHECKPOINT
DBCC DROPCLEANBUFFERS

SET STATISTICS IO ON


--Exercise 1: Create an index to make the query faster

SELECT title FROM bibrecs WHERE title like 'Οικ%' ORDER BY title;

CREATE INDEX title_index ON bibrecs(title);



--Exercise 2: Queries

--1) Records with titles starting with Οικ (288 rows)
SELECT title FROM bibrecs WHERE title like 'Οικ%' ORDER BY title;

--2a) Records with titles including the word πληροφορική (78 rows)
SELECT title FROM bibrecs WHERE title like '%πληροφορική%';

--2b) Records titled Economics (63 rows)
SELECT title,material FROM bibrecs WHERE title = 'Economics';

--2c) Records with titles staring with the word Economics (513 rows)
SELECT title,material FROM bibrecs WHERE title like 'Economics%';



-- Exercise 3: Write queries and create indexes to make them run faster

--Queries

--1) The title and language of records published by Κλειδάριθμος
SELECT title,lang,pubname 
FROM bibrecs,publishers 
WHERE bibrecs.pubid = publishers.pubid AND pubname = 'Κλειδάριθμος';

--2) The name of each department with their total number of borrowings done in 2000
SELECT depname, COUNT(lid)
FROM departments,loanstats,borrowers 
WHERE loanstats.bid = borrowers.bid AND borrowers.depcode = departments.depcode AND loandate > '1-1-2000' AND loandate <'1-1-2001'
GROUP BY depname;

--3) Title, language and name of the author(s) of records related to the topic "Databases"
SELECT DISTINCT title,lang,author,term,bibrecs.bibno
FROM authors, bibrecs, bibauthors, sterms, bibterms
WHERE bibauthors.bibno = bibrecs.bibno
AND bibauthors.aid = authors.aid
AND sterms.tid = bibterms.tid
AND bibterms.bibno = bibrecs.bibno
AND term = 'Databases';

--Indexes

--For 1)
CREATE INDEX pubid_index ON bibrecs(pubid);

--For 2)
CREATE INDEX loanstats_loandate_bid ON loanstats(loandate,bid);
CREATE INDEX borrowers_depcode ON borrowers(depcode);

--For 3)
CREATE INDEX bibterms_tid ON bibterms(tid);
CREATE INDEX sterms_term ON sterms(term);
CREATE INDEX bibauthors_bibno_aid ON bibauthors(bibno,aid);



-- Exercise 3: Write 3 SQL queries to answer the question:
--"Give the title and number of books with at least one copy in each of the locations: 'OPA' and 'ANA'. "

--1st : with a join
SELECT DISTINCT bibrecs.bibno,title
FROM copies c1, copies c2,bibrecs 
WHERE c1.bibno = bibrecs.bibno AND c1.bibno = c2.bibno
AND c1.copyloc = 'OPA' AND c2.copyloc = 'ANA';

--2nd : with INTERSECT
SELECT bibrecs.bibno , title
FROM copies,bibrecs
WHERE copies.bibno = bibrecs.bibno AND copies.copyloc = 'OPA'
INTERSECT
SELECT bibrecs.bibno, title
FROM copies,bibrecs
WHERE copies.bibno = bibrecs.bibno AND copies.copyloc = 'ANA'

--3rd: with EXISTS
SELECT DISTINCT bibrecs.bibno, title
FROM bibrecs
WHERE EXISTS(SELECT bibno FROM copies WHERE copies.bibno = bibrecs.bibno AND copies.copyloc = 'ANA')
AND EXISTS(SELECT bibno FROM copies WHERE copies.bibno = bibrecs.bibno AND copies.copyloc = 'OPA');

--Create an index to speed up the first query
CREATE INDEX copies_copyloc ON copies(copyloc,bibno);



--Exercise 4: Create tables to store the words referenced in records.
--Then create an index to speed up queries like:
--"SELECT bibno FROM bibwords, words WHERE bibwords.wid = words.wid AND words.word = '...'; "

CREATE TABLE words(
	wid int PRIMARY KEY, 
	word varchar(255));

CREATE TABLE bibwords(
	wid int, 
	bibno int, 
	PRIMARY KEY(wid,bibno),
	FOREIGN KEY(wid) REFERENCES words(wid),
	FOREIGN KEY(bibno) REFERENCES bibrecs(bibno));

CREATE INDEX words_wid_word ON words(wid,word);



SET STATISTICS IO OFF
