SET ECHO ON
SET LINESIZE 300
SET PAGESIZE 30
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- Question 1

DROP TABLE MEMBERSHIP CASCADE CONSTRAINTS;
DROP TABLE PRICE CASCADE CONSTRAINTS;
DROP TABLE RENTAL CASCADE CONSTRAINTS;
DROP TABLE GAME CASCADE CONSTRAINTS;
DROP TABLE DETAILRENTAL CASCADE CONSTRAINTS;
DROP TABLE GAMECOPY CASCADE CONSTRAINTS;

CREATE TABLE MEMBERSHIP(
	MEM_NUM CHAR(4) PRIMARY KEY NOT NULL,
	FNAME VARCHAR2(30) NOT NULL,
	LNAME VARCHAR2(30) NOT NULL,
	STREET VARCHAR2(120),
	CITY VARCHAR2(50),
	PROV CHAR(2),
	POSTAL CHAR(7),
	BALANCE NUMBER(10,2),
	CONSTRAINT CKKK_BALANCE CHECK (BALANCE >= 0)
);

CREATE TABLE RENTAL(
	RENT_NUM CHAR(5) PRIMARY KEY NOT NULL,
	RENT_DATE DATE NOT NULL,
	MEM_NUM CHAR(4) NOT NULL
);

CREATE TABLE DETAILRENTAL(
	RENT_NUM CHAR(5) NOT NULL,
	GC_NUM CHAR(6) NOT NULL,
	FEE NUMBER(5,2) NOT NULL,
	DUE_DATE DATE NOT NULL,
	RETURN_DATE DATE,
	DAILY_LATE_FEE NUMBER(5,2) NOT NULL
);

CREATE TABLE GAMECOPY (
	GC_NUM CHAR(6) PRIMARY KEY NOT NULL,
	INDATE DATE NOT NULL,
	GA_NUM CHAR(5) NOT NULL
);

CREATE TABLE GAME(
	GA_NUM CHAR(5) PRIMARY KEY NOT NULL,
	TITLE VARCHAR2(75) NOT NULL,
	YEAR CHAR(4) NOT NULL,
	COST NUMBER(5,2),
	GENRE VARCHAR2(50),
	PRICE_CODE CHAR(2) NOT NULL,
	CONSTRAINT CK_YEAR CHECK (YEAR >= 1970)
);

CREATE TABLE PRICE(
	PRICE_CODE CHAR(2) PRIMARY KEY NOT NULL,
	DESCRIPTION VARCHAR2(20) NOT NULL,
	RENT_FEE NUMBER(5,2) NOT NULL,
	DAILY_LATE_FEE NUMBER(5,2) NOT NULL,
	CONSTRAINT CK_RENT_FEE CHECK (RENT_FEE >= 0),
	CONSTRAINT CK_DAILY_LATE_FEE CHECK (DAILY_LATE_FEE >= 0)
);

ALTER TABLE RENTAL ADD CONSTRAINT FK_MEM_NUM FOREIGN KEY (MEM_NUM) REFERENCES MEMBERSHIP(MEM_NUM);

ALTER TABLE DETAILRENTAL ADD CONSTRAINT FK_RENT_NUM FOREIGN KEY (RENT_NUM) REFERENCES RENTAL(RENT_NUM);

ALTER TABLE DETAILRENTAL ADD CONSTRAINT FK_GC_NUM FOREIGN KEY (GC_NUM) REFERENCES GAMECOPY(GC_NUM);

ALTER TABLE DETAILRENTAL ADD CONSTRAINT PK_DETAILRENTAL PRIMARY KEY (RENT_NUM, GC_NUM);

ALTER TABLE GAMECOPY ADD CONSTRAINT FK_GA_NUM FOREIGN KEY (GA_NUM) REFERENCES GAME(GA_NUM);

ALTER TABLE GAME ADD CONSTRAINT FK_PRICE_CODE FOREIGN KEY (PRICE_CODE) REFERENCES PRICE(PRICE_CODE);

-- Question 2

INSERT INTO PRICE (PRICE_CODE, DESCRIPTION, RENT_FEE, DAILY_LATE_FEE) VALUES(
1, 'Standard', 2, 1.5
);

INSERT INTO PRICE (PRICE_CODE, DESCRIPTION, RENT_FEE, DAILY_LATE_FEE) VALUES(
2, 'New Release', 3.5, 3
);

INSERT INTO PRICE (PRICE_CODE, DESCRIPTION, RENT_FEE, DAILY_LATE_FEE) VALUES(
3, 'Discount', 1.5, 1
);

INSERT INTO PRICE (PRICE_CODE, DESCRIPTION, RENT_FEE, DAILY_LATE_FEE) VALUES(
4, 'Weekly Special', 1, 0.5
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1234, 'BATTLEFIELD 1', 2016, 79.99, 'ACTION', 1
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1235, 'MASS Effect Andromeda', 2017, 89.99, 'ACTION', 2
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1236, 'EverQuest', 1999, 59.95, 'RPG', 3
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1237, 'Fable II', 2010, 49.95, 'RPG', 3
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1238, 'Mario Kart 8 Deluxe', 2017, 89.95, 'RACING', 2
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1239, 'Blur', 2010, 29.49, 'RACING', 1
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1245, 'Grand Theft Auto V', 2012, 45.49, 'ACTION', 1
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1246, 'Halo 4', 2012, 58.29, 'ACTION', 1
);

INSERT INTO GAME (GA_NUM, TITLE, YEAR, COST, GENRE, PRICE_CODE) VALUES(
1247, 'Wipeout 3', 2012, 58.29, 'SIMULATION', 1
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34341, '2017-01-22', 1235
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34342, '2017-01-22', 1235
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34366, '1999-03-02', 1236
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34367, '1999-03-02', 1236
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34368, '1999-03-02', 1236
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
34369, '1999-03-02', 1236
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
44392, '2010-10-21', 1237
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
44397, '2010-10-21', 1237
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
54321, '2016-06-18', 1234
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
54324, '2016-06-18', 1234
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
54325, '2016-06-18', 1234
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
59237, '2010-02-14', 1237
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
61353, '2013-01-28', 1245
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
61354, '2013-01-28', 1245
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
61367, '2012-07-30', 1246
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
61369, '2012-07-30', 1246
);

INSERT INTO GAMECOPY (GC_NUM, INDATE, GA_NUM) VALUES(
61388, '2010-01-25', 1239
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
102, 'TAMI', 'DAWSON', '2632 TAKLI CIRCLE', 'FREDERICTON', 'NB', 'E4C 1X2', 11
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
103, 'CURT', 'KNIGHT', '4025 CORNELL COURT', 'HALIFAX', 'NS', 'E2T 1T2', 6
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
104, 'JAMAL', 'MELENDEZ', '788 EAST 145TH AVENUE', 'MONCTON', 'NB', 'E4T 1U2', 0
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
105, 'IVA', 'MCCLAIN', '6045 MUSKET BALL CIRCLE', 'SUMMIT', 'NS', 'E4C 1J2', 15
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
106, 'MIRANDA', 'PARKS', '4469 MAXWELL PLACE', 'GERMANTOWN', 'NB', 'E2H 1S2', 0
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
107, 'ROSARIO', 'ELLIOT', '7578 DANNER AVENUE', 'TRACEY', 'NB', 'E4C 1G2', 5
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
108, 'MATTIE', 'GUY', '4390 EVERGREEN STREET', 'LILY', 'NS', 'E7C 1F2', 0
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
109, 'CLINT', 'OCHOA', '1711 ELM STREET', 'GREENVILLE', 'NB', 'E2K 1H2', 10
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
110, 'LEWIS', 'ROSALES', '4524 SOUTHWIND CIRCLE', 'SUSSEX', 'NB', 'E7H 1X8', 0
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
111, 'STACY', 'MANN', '2789 EAST COOK AVENUE', 'DIEPPE', 'NB', 'E4C 1C2', 8
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
112, 'LUIS', 'TRUJILLO', '7267 MELVIN AVENUE', 'ST. ANDREWS', 'NB', 'E4A 1X2', 3
);

INSERT INTO MEMBERSHIP (MEM_NUM, FNAME, LNAME, STREET, CITY, PROV, POSTAL, BALANCE) VALUES(
113, 'MINNIE', 'GONZALES', '6430 VASILI DRIVE', 'SAINT JOHN', 'NB', 'E3P 1X5', 0
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1001, '2017-03-01', 103
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1002, '2016-12-12', 105
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1003, '2016-11-13', 102
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1004, '2017-03-10', 110
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1005, '2017-02-04', 111
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1006, '2017-02-25', 107
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1007, '2016-12-12', 104
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1008, '2017-01-01', 105
);

INSERT INTO RENTAL (RENT_NUM, RENT_DATE, MEM_NUM) VALUES(
1009, '2016-10-12', 111
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1001, 34342, 3.5, '2017-03-04', '2017-03-02', 3
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1001, 34366, 1.5, '2017-03-04', '2017-03-03', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1001, 61353, 2, '2017-03-04', '2017-03-02', 1.5
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1002, 59237, 1.5, '2016-12-15', '2016-12-15', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1003, 54325, 2, '2016-11-16', '2016-11-21', 1.5
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1003, 61369, 2, '2016-11-16', '2016-11-18', 1.5
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1003, 61388, 2, '2016-11-16', '2016-11-18', 1.5
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1004, 34341, 3.5, '2017-03-13', '2017-03-13', 3
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1004, 34367, 1.5, '2017-03-13', '2017-03-14', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1004, 44392, 1.5, '2017-03-13', '2017-03-12', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1005, 34342, 3.5, '2017-02-07', '2017-02-07', 3
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1005, 44397, 1.5, '2017-02-07', '2017-02-06', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1006, 34366, 1.5, '2017-02-28', '2017-02-28', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1006, 61367, 2, '2017-02-28', '', 1.5
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1007, 34368, 1.5, '2016-12-15', '', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1008, 34369, 1.5, '2017-01-04', '2017-01-04', 1
);

INSERT INTO DETAILRENTAL (RENT_NUM, GC_NUM, FEE, DUE_DATE, RETURN_DATE, DAILY_LATE_FEE) VALUES(
1009, 54324, 2, '2016-10-15', '', 1.5
);

-- Question 3

COMMIT;

-- Question 4

UPDATE GAME SET YEAR = 2013 WHERE GA_NUM = 1245;

-- Question 5

UPDATE GAME SET PRICE_CODE = 4 WHERE GENRE = 'SIMULATION';

-- Question 6

UPDATE PRICE SET RENT_FEE = (RENT_FEE + 0.50);

-- Question 7

COMMIT;

-- Question 8

COLUMN GENRE FORMAT A12
COLUMN TITLE FORMAT A22
COLUMN YEAR FORMAT A4
COLUMN COST CLEAR
SELECT GENRE, TITLE, YEAR, COST FROM GAME ORDER BY GENRE ASC, YEAR DESC;

-- Question 9

COLUMN "Member #" FORMAT A10
COLUMN "Member Name" FORMAT A30
COLUMN BALANCE FORMAT $99.99
SELECT MEM_NUM as "Member #", LNAME || ', ' || FNAME as "Member Name", BALANCE FROM MEMBERSHIP;

-- Question 10

ALTER TABLE MEMBERSHIP ADD STATUS CHAR(8);
ALTER TABLE MEMBERSHIP ADD CONSTRAINT CK_STATUS CHECK (STATUS = 'ACTIVE' OR STATUS = 'SUSPEND' OR STATUS = 'CLOSE');

COLUMN "Member #" FORMAT A10
COLUMN "Member Name" FORMAT A30
COLUMN BALANCE FORMAT $99.99
SELECT MEM_NUM as "Member #", LNAME || ', ' || FNAME as "Member Name", BALANCE, STATUS FROM MEMBERSHIP;

-- Question 11

UPDATE MEMBERSHIP SET STATUS = 'ACTIVE' WHERE MEM_NUM IN (SELECT MEM_NUM FROM RENTAL);

COLUMN "Member #" FORMAT A10
COLUMN "Member Name" FORMAT A30
COLUMN BALANCE FORMAT $99.99
SELECT MEM_NUM as "Member #", LNAME || ', ' || FNAME as "Member Name", BALANCE, STATUS FROM MEMBERSHIP;

-- Question 12

SELECT GENRE, TITLE, YEAR, COST FROM GAME WHERE LOWER(TITLE) LIKE ('%ef%') ORDER BY GENRE ASC, YEAR DESC;

-- Question 13

SELECT GENRE, TITLE, YEAR, COST FROM GAME WHERE GENRE IN('RPG', 'RACING') AND COST < 60 ORDER BY GENRE ASC, TITLE ASC;

-- Question 14

SELECT GENRE, COUNT(*) AS "# IN STOCK" FROM GAME GROUP BY GENRE;

-- Question 15

COLUMN "AVG. GAME" FORMAT $99.99
SELECT AVG(COST) AS "AVG. GAME" FROM GAME;

-- Question 16

SELECT E.GENRE, (SELECT AVG(COST) FROM GAME WHERE GENRE = E.GENRE) AS "AVG. GAME COST" FROM GAME E GROUP BY GENRE ORDER BY GENRE ASC;

-- Question 17

COLUMN "Game Title" FORMAT A22
COLUMN "Genre" FORMAT A10
COLUMN "Pricing Description" FORMAT A20
COLUMN "Rental Fee" FORMAT $99.99
COLUMN "Game Cost" FORMAT $99.99
SELECT GA.TITLE AS "Game Title", GA.GENRE AS "Genre", (SELECT DESCRIPTION FROM PRICE WHERE PRICE_CODE = GA.PRICE_CODE) AS "Pricing Description", (SELECT RENT_FEE FROM PRICE WHERE PRICE_CODE = GA.PRICE_CODE) AS "Rental Fee", GA.COST AS "Game Cost" FROM GAME GA ORDER BY GA.TITLE ASC;

-- Question 18

COLUMN "Avg. Fee" FORMAT $99.99
SELECT GA.GENRE AS "Genre", AVG((SELECT PR.RENT_FEE FROM PRICE PR WHERE PR.PRICE_CODE = GA.PRICE_CODE)) AS "Avg. Fee" FROM GAME GA GROUP BY GA.GENRE ORDER BY GA.GENRE ASC;

-- Question 19

SELECT GAA.GENRE, GAA.TITLE, GAA.COST FROM GAME GAA WHERE
GAA.COST > (SELECT AVG(COST) FROM GAME WHERE GENRE = GAA.GENRE);

-- Question 20

UPDATE GAME GAA SET COST = (COST - 2.50) WHERE COST > (SELECT AVG(COST) FROM GAME WHERE GENRE = GAA.GENRE);

COMMIT;

SELECT GAA.GENRE, GAA.TITLE, GAA.COST FROM GAME GAA WHERE
GAA.COST > (SELECT AVG(COST) FROM GAME WHERE GENRE = GAA.GENRE);

-- Question 21

COLUMN "BER#" FORMAT 99.99
SELECT GA.TITLE, GA.YEAR, GA.COST/(SELECT RENT_FEE FROM PRICE PR WHERE PR.PRICE_CODE = GA.PRICE_CODE) AS "BER#" FROM GAME GA ORDER BY GA.TITLE;

-- Question 22

COLUMN "Customer Name" FORMAT A20
SELECT ME.MEM_NUM AS "Member #", ME.LNAME || ', ' || ME.FNAME AS "Customer Name", ME.BALANCE FROM MEMBERSHIP ME WHERE ME.MEM_NUM IN(SELECT MEM_NUM FROM RENTAL) ORDER BY ME.LNAME ASC;

-- Question 23

COLUMN "Rental #" FORMAT A10
SELECT dr.rent_num AS "Rental #", (SELECT rent_date FROM rental WHERE rent_num = dr.rent_num) AS "Rented On", (SELECT title FROM game WHERE ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num)) AS "Game Title", dr.fee AS "Rental Fee" FROM DETAILRENTAL dr WHERE dr.return_date <= dr.due_date;

-- Question 24

COLUMN "Due Back By" FORMAT A12
COLUMN "Returned On" FORMAT A12
COLUMN "Copy Number" FORMAT A12
SELECT dr.rent_num AS "Rental #", (SELECT gc_num FROM gamecopy WHERE gc_num = dr.gc_num) AS "Copy Number", (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num)) AS "Game Title", (SELECT rent_date FROM rental WHERE rent_num = dr.rent_num) AS "Rented On", dr.due_date AS "Due Back By", dr.return_date AS "Returned On" FROM DETAILRENTAL dr WHERE dr.return_date > dr.due_date ORDER BY dr.rent_num, (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num));

-- Question 25

SELECT dr.rent_num AS "Rental #", (SELECT gc_num FROM gamecopy WHERE gc_num = dr.gc_num) AS "Copy Number", (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num)) AS "Game Title", (SELECT rent_date FROM rental WHERE rent_num = dr.rent_num) AS "Rented On", dr.due_date AS "Due Back By", dr.return_date AS "Returned On", (dr.return_date - dr.due_date) AS "Days Late" FROM DETAILRENTAL dr WHERE dr.return_date > dr.due_date ORDER BY dr.rent_num, (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num));

-- Question 26

COLUMN "Late Fees Paid" FORMAT $99.99
SELECT dr.rent_num AS "Rental #", (SELECT gc_num FROM gamecopy WHERE gc_num = dr.gc_num) AS "Copy Number", (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num)) AS "Game Title", (SELECT rent_date FROM rental WHERE rent_num = dr.rent_num) AS "Rented On", dr.due_date AS "Due Back By", dr.return_date AS "Returned On", (dr.return_date - dr.due_date) AS "Days Late", ((dr.return_date - dr.due_date)*dr.daily_late_fee) AS "Late Fees Paid" FROM DETAILRENTAL dr WHERE dr.return_date > dr.due_date ORDER BY dr.rent_num, (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num));

-- Question 27

COLUMN "Late Fees Owing" FORMAT $99999.99
COLUMN "Days Late" FORMAT 999999999
SELECT dr.rent_num AS "Rental #", (SELECT gc_num FROM gamecopy WHERE gc_num = dr.gc_num) AS "Copy Number", (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num)) AS "Game Title", (SELECT rent_date FROM rental WHERE rent_num = dr.rent_num) AS "Rented On", dr.due_date AS "Due Back By",
((SELECT current_date FROM DUAL) - dr.due_date) AS "Days Late",
(((SELECT current_date FROM DUAL) - dr.due_date)*dr.daily_late_fee) AS "Late Fees Owing"
FROM DETAILRENTAL dr WHERE dr.return_date IS NULL ORDER BY dr.rent_num, (SELECT game.title FROM game game WHERE game.ga_num IN(SELECT ga_num FROM gamecopy WHERE gc_num = dr.gc_num));

-- Question 28

COLUMN "Late Fee" FORMAT $99.99
COLUMN "Total Fees" FORMAT $99.99
SELECT re.mem_num AS "Member #", (SELECT lname || ', ' || fname FROM membership WHERE mem_num = re.mem_num) AS "Customer Name",
(SELECT COUNT(gc_num) FROM DETAILRENTAL WHERE rent_num = re.rent_num) AS "Games Rented",
(SELECT SUM(fee) FROM DETAILRENTAL WHERE rent_num IN(SELECT rent_num FROM RENTAL WHERE mem_num = re.mem_num)) AS "Rental Fee",
(SELECT SUM((return_date - due_date) * daily_late_fee) FROM DETAILRENTAL WHERE rent_num IN(SELECT rent_num FROM RENTAL WHERE mem_num = re.mem_num) AND return_date > due_date) AS "Late Fee",
(
(SELECT SUM(fee) FROM DETAILRENTAL WHERE rent_num IN(SELECT rent_num FROM RENTAL WHERE mem_num = re.mem_num))
+
(SELECT COALESCE(SUM((return_date - due_date) * daily_late_fee), 0) FROM DETAILRENTAL WHERE rent_num IN(SELECT rent_num FROM RENTAL WHERE mem_num = re.mem_num) AND return_date > due_date)
)
AS "Total Fees"
FROM RENTAL re ORDER BY re.mem_num;

