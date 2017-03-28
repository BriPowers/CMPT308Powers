--Brian Powers
--Database Management
--3/28/17
--Lab 8

--2. 
DROP TABLE IF EXISTS Movie_People;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Actors;
DROP TABLE IF EXISTS Directors;
DROP TABLE IF EXISTS Cast_and_Crew;

CREATE TABLE Movie_People(
	PID char(4) not null,
	FIRST_NAME text not null,
    LAST_NAME text not null,
    DOB date not null,
    ADDRESS text,
    SPOUSE_NAME text,
    primary key(PID)
);
CREATE TABLE Movies(
	MOVIEID int not null,
	MOVIE_NAME text not null,
	YEAR_RELEASED integer not null,
	DBOS_USD integer,
	FBOS_USD integer,
	DVD_BLURAY_USD integer,
	primary key(MOVIEID)
);
CREATE TABLE Actors(
	PID char(4) not null references Movie_People(PID),
	SAGUILD_ANNIVERSARY date,
    FAVORITE_COLOR text,
    HAIR_COLOR text,
    EYE_COLOR text,
    HEIGHT_IN integer not null,
    WEIGHT_LBS integer not null,
	primary key(PID)
);
CREATE TABLE Directors(
	PID char(4) not null references Movie_People(PID),
	FILMSCHOOL text,
    GRAD_DATE text,
	DGUILD_ANNIVERSARY date,
	LENS_MAKER text,
	primary key(PID)
);
CREATE TABLE Cast_and_crew(
	MOVIEID integer not null references Movies(MOVIEID),
    PID char(4) not null references Movie_People(PID),
    EMP_TITLE text not null,
    ROYALTIES_BY_PERC float,
    Salary integer,
    primary key(MOVIEID,PID,EMP_TITLE)
);
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (007, 'Sean', 'Conery','Aug_25_1930', '123 hollywood dr', 'Micheline Roquebrune');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (008, 'Sidney', 'Lumet','Jun_25_1924', '321 hollywood rd', 'Mary Gimbel');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (009, 'Mr.', 'Actorman','Jul_2_1944', '580 main st', 'Mrs. Actorlady');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (010, 'Mr.', 'Directorman','Nov_25_1924', '731 hollywood bl', 'Mrs. Directorlady');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (011, 'Mrs.', 'Actorlady','Jul_2_1959', '580 main st', 'Mr. Actorman');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (012, 'Mrs.', 'Directorlady','Nov_25_1961', '731 hollywood bl', 'Mr. Directorman');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (013, 'Ursula', 'Andress','Mar_29_1936', '428 berns dr', 'John Derek');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (014, 'Terence', 'Young','Jun_20_1915', '994 shangi st', 'Dorothea Bennett');
INSERT INTO Movie_People (PID, FIRST_NAME, LAST_NAME,DOB,ADDRESS,SPOUSE_NAME)  
VALUES (015, 'Jose', 'Gonzalo','Jun_20_1942', '44th st', 'Tiffiney Hernandez');


INSERT INTO Actors (PID,SAGUILD_ANNIVERSARY,HAIR_COLOR,EYE_COLOR,HEIGHT_IN,WEIGHT_LBS)  
VALUES (007, 'FEB_02_1951', 'White','Brown',74,180);
INSERT INTO Actors (AID,PID,SAGUILD_ANNIVERSARY,HAIR_COLOR,EYE_COLOR,HEIGHT_IN,WEIGHT_LBS)  
VALUES (009, 'FEB_02_1951', 'black','blue',75,170);
INSERT INTO Actors (AID,PID,SAGUILD_ANNIVERSARY,HAIR_COLOR,EYE_COLOR,HEIGHT_IN,WEIGHT_LBS)  
VALUES (011, 'JUN_08_1959', 'blonde','blue',65,130);
INSERT INTO Actors (AID,PID,SAGUILD_ANNIVERSARY,HAIR_COLOR,EYE_COLOR,HEIGHT_IN,WEIGHT_LBS)  
VALUES (013, 'JUN_08_1935', 'blonde','brown',65,140);

INSERT INTO Directors (DID,PID,FILMSCHOOL, GRAD_DATE,DGUILD_ANNIVERSARY,LENS_MAKER)  
VALUES (008, null, null, 'MAY_7_1939','Zeiss');
INSERT INTO Directors (DID,PID,FILMSCHOOL, GRAD_DATE,DGUILD_ANNIVERSARY,LENS_MAKER)  
VALUES (010, 'LA school of film arts', 'FEB_7_1942', 'MAY_7_1939','Olympus');
INSERT INTO Directors (DID,PID,FILMSCHOOL, GRAD_DATE,DGUILD_ANNIVERSARY,LENS_MAKER)  
VALUES (012, 'new york filmschool', 'JAN_8_1937', 'MAY_7_1939','Olympus');
INSERT INTO Directors (DID,PID,FILMSCHOOL, GRAD_DATE,DGUILD_ANNIVERSARY,LENS_MAKER)  
VALUES (014, null, null, 'Apr_7_1941','Leica');

INSERT INTO Movies (MOVIEID,MOVIE_NAME,YEAR_RELEASED, DBOS_USD,FBOS_USD,DVD_BLURAY_USD)  
VALUES (1,'Dr.No', '1962', '300,237', '971,332','71,000');
INSERT INTO Movies (MOVIEID,MOVIE_NAME,YEAR_RELEASED, DBOS_USD,FBOS_USD,DVD_BLURAY_USD)  
VALUES (2,'The Offence', '1972', '561,237', '971,323','37,746');
INSERT INTO Movies (MOVIEID,MOVIE_NAME,YEAR_RELEASED, DBOS_USD,FBOS_USD,DVD_BLURAY_USD)  
VALUES (3,'bad movie', '1954', '41,851', '58,729','73,786');
INSERT INTO Movies (MOVIEID,MOVIE_NAME,YEAR_RELEASED, DBOS_USD,FBOS_USD,DVD_BLURAY_USD)  
VALUES (4,'worse movie', '1958', '21,851', '38,729','9,786');

INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(1,014,'Director',.035,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(1,007,'Male Lead',.021,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(1,013,'Female Lead',.021,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(2,008,'Director',.014,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(2,007,'Male Lead',.037,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(3,010,'Director',.033,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(3,009,'Male Lead',.027,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(4,012,'Director',.015,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(4,011,'Female Lead',.033,null);
INSERT INTO Cast_and_crew (MOVIEID,PID,EMP_TITLE,ROYALTIES_BY_PERC,Salary)
VALUES(1,015,'Custodian',null,20000);

SELECT *
FROM cast_and_crew;

3. Functional Dependencies

•	movie_people
◦	PID → FIRST_NAME,LAST_NAME,DOB, ADDRESS, SPOUSE_NAME

•	actors
◦	PID → AID
◦	AID → HAIR_COLOR, EYE_COLOR, HEIGHT_IN, WEIGHT_LBS, SAGUILD_ANNIVERSARY,FAVORITE_COLOR

•	directors
◦	PID → DID
◦	DID → FILMSCHOOL,GRAD_DATE, DGUILD_ANNIVERSARY, LENS_MAKER

•	movies
◦	MOVIEID → MOVIE_NAME, YEAR_RELEASED, DBOS_USD, FBOS_USD, DVD_BLURAY_USD

•	cast_and_crew
◦	MOVIEID,PID,EMP_TITLE → ROYALTIES_BY_PERC,Salary

4. 
SELECT FIRST_NAME,LAST_NAME
FROM movie_people
WHERE PID in (
SELECT PID
FROM cast_and_crew
WHERE EMP_TITLE = 'Director'and MOVIEID in(
SELECT MOVIEID
FROM cast_and_crew
WHERE EMP_TITLE =  'Male Lead' and PID = '007'));







