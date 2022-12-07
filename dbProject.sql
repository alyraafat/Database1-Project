CREATE DATABASE FootballDB;

USE  FootballDB;

--2.1 a....
GO;
CREATE PROCEDURE createAllTables
AS
--	CREATE TABLE SystemUser(
--		username VARCHAR(20),
--		password VARCHAR(20),
--		CONSTRAINT pk_system_user PRIMARY KEY(username)
--	);

	CREATE TABLE Stadium(
		id INT IDENTITY,
		name VARCHAR(20),
		capacity INT,
		location VARCHAR(20),
		status BIT DEFAULT 1, -- 1 means available, 0 means unavailable
		CONSTRAINT pk_stadium PRIMARY KEY(id)
	);

	CREATE TABLE Club(
		id INT IDENTITY,
		name VARCHAR(20),
		location VARCHAR(20),
		CONSTRAINT pk_club PRIMARY KEY(id)
	);

	CREATE TABLE StadiumManager(
		username VARCHAR(20) UNIQUE,
		id INT IDENTITY UNIQUE,
		name VARCHAR(20),
		stadium_id INT,
		password VARCHAR(20),
		CONSTRAINT pk_stadium_manager PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE ClubRepresentative(
		username VARCHAR(20) UNIQUE,
		id INT IDENTITY UNIQUE,
		name VARCHAR(20),
		club_id INT,
		password VARCHAR(20),
		CONSTRAINT pk_club_rep PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(club_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE Fan(
		username VARCHAR(20) UNIQUE,
		national_id VARCHAR(20) UNIQUE,
		phone VARCHAR(20),
		name VARCHAR(20),
		address VARCHAR(20),
		status BIT DEFAULT 1, -- 1 means unblocked, 0 means blocked
		birth_date DATE,
		password VARCHAR(20),
		CONSTRAINT pk_fan PRIMARY KEY(username,national_id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE SportsAssociationManager(
		username VARCHAR(20) UNIQUE,
		id INT IDENTITY UNIQUE,
		name VARCHAR(20),
		password VARCHAR(20),
		CONSTRAINT pk_sam PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE SystemAdmin(
		username VARCHAR(20) UNIQUE,
		id INT IDENTITY UNIQUE,
		name VARCHAR(20),
		password VARCHAR(20),
		CONSTRAINT pk_system_admin PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE Matches(
		id INT IDENTITY,
		start_time DATETIME,
		end_time DATETIME,
--		allowed_num_of_attendees INT,
		stadium_id INT,
		host_id INT,
		guest_id INT,
		CONSTRAINT pk_matches PRIMARY KEY(id),
		FOREIGN KEY(host_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(guest_id) REFERENCES Club(id) ON DELETE NO ACTION ON UPDATE NO ACTION,
		FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE Ticket(
		id INT IDENTITY,
		status BIT DEFAULT 1, -- 1 means available, 0 means unavailable
		fan_username VARCHAR(20),
		fan_id VARCHAR(20),
		match_id INT,
		CONSTRAINT pk_ticket PRIMARY KEY(id),
		FOREIGN KEY(fan_username,fan_id) REFERENCES Fan(username,national_id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(match_id) REFERENCES Matches(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE HostRequest(
		id INT IDENTITY,
		status VARCHAR(20) DEFAULT 'unhandled', --unhandled or accepted or rejected
		match_id INT,
		smu VARCHAR(20),
		smd INT,
		cru VARCHAR(20),
		crd INT,
		CONSTRAINT pk_host_request PRIMARY KEY(id),
		CONSTRAINT check_status CHECK(status='accepted' OR status='rejected' OR status='unhandled'),
		FOREIGN KEY(smu,smd) REFERENCES StadiumManager(username,id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(cru,crd) REFERENCES ClubRepresentative(username,id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(match_id) REFERENCES Matches(id) ON DELETE NO ACTION ON UPDATE NO ACTION
	);
GO;
Drop PROC createAllTables;
EXEC createAllTables;


--Test inserting into stadiums
INSERT INTO Stadium (name,capacity,location) VALUES
('camp nou',1000,'bar'),
('santiago',2000,'madrid'),
('2y neela',1000,'cairo');
SELECT * FROM Stadium;

--Test inserting into clubs
INSERT INTO Club (name,location) VALUES
('barca','bar'),
('real madrid','madrid'),
('ahly','cairo');
SELECT * FROM Club;
DELETE FROM CLUB

--Test inserting into stadium manager
--without stadium_id
INSERT INTO StadiumManager (username,name,password) VALUES
('alybaba','f','1234'),
('xxx','c','4567'),
('yyy','d','8900');

--with stadium_id
INSERT INTO StadiumManager (username,name,stadium_id,password) VALUES
('ffff','g',2,'4324');
SELECT * FROM StadiumManager;
SET IDENTITY_INSERT StadiumManager ON;
INSERT INTO StadiumManager (username,id,name,stadium_id,password) VALUES('',3,'',3,'')
SET IDENTITY_INSERT StadiumManager OFF;
DELETE FROM StadiumManager;

--Test inserting into ClubRepresentative
--without club_id
INSERT INTO ClubRepresentative (username,name,password) VALUES
('alybaba','f','1234'),
('gggg','c','4567'),
('hhhh','d','8900');

--with club_id
INSERT INTO ClubRepresentative (username,name,club_id,password) VALUES
('ahly rep','7amaza',9,'4324'),
('madrid rep','k',8,'4324'),
('barca rep','sss',7,'4324');
SELECT * FROM ClubRepresentative;
DELETE FROM ClubRepresentative;

--Test inserting into Fan
INSERT INTO Fan (username,national_id,phone,name,address,birth_date,password) VALUES
('f1','11111','01281002087','a','loc1','2002/10/30','3333'),
('f2','22222','01281002086','b','loc2','2002/11/30','3334'),
('f3','33333','01281002085','c','loc1','2002/10/30','3333'),
('f4','44444','01281002085','c','loc1','2002/10/30','3333');
SELECT * FROM Fan;
DELETE FROM Fan;

--Test inserting into SportsAssociationManager
INSERT INTO SportsAssociationManager (username,name,password) VALUES
('ddd','f','1234'),
('fff','c','4567'),
('gggg','d','8900');
SELECT * FROM SportsAssociationManager;

--Test inserting into Matches
INSERT INTO Matches (start_time,end_time,stadium_id,host_id,guest_id) VALUES
('2022/10/30 08:00:00','2022/10/30 10:00:00',2,8,7),
('2022/10/28 05:00:00','2022/10/28 07:00:00',3,9,7),
('2022/12/10 07:00:00','2022/12/10 09:00:00',1,7,8),
('2022/12/11 07:00:00','2022/12/11 09:00:00',NULL,7,8);
SELECT id ,CAST(start_time AS DATE) FROM Matches;
SELECT * FROM MATCHES;
DELETE FROM MATCHES
DELETE FROM Club WHERE id=3;
SELECT * FROM Club;

--Test inserting into Host Request
SELECT * FROM MATCHES;
SELECT * FROM ClubRepresentative;
SELECT * FROM StadiumManager;
UPDATE StadiumManager
SET stadium_id = 1
WHERE id = 1
INSERT INTO HostRequest (match_id,smu,smd,cru,crd) VALUES
(18,'fffffff','5','barca rep','11'),
(15,'ffff','4','madrid rep','10'),
(16,'fffffff','5','ahly rep','9'),
(17,'alybaba','1','barca rep','11');
UPDATE HostRequest
SET status = 'accepted'
WHERE id IN (2,3,4);
SELECT * FROM HostRequest; 

--2.1 b
GO;
CREATE PROC dropAllTables
AS
	DROP TABLE IF EXISTS 
	SportsAssociationManager,
	SystemAdmin,
	Ticket,
	HostRequest,
	Matches,
	Fan,
	StadiumManager,
	ClubRepresentative,
	SystemUser,
	Stadium,
	Club;
GO;
Drop PROC dropAllTables;
EXEC dropAllTables;
--DROP DATABASE FootballDB;
--EXEC sp_fkeys 'Stadium'

--2.1 d
GO;
CREATE PROC clearAllTables
AS
	DELETE FROM SportsAssociationManager;
	DELETE FROM SystemAdmin;
	DELETE FROM Ticket;
	DELETE FROM HostRequest;
	DELETE FROM Matches;
	DELETE FROM Fan;
	DELETE FROM StadiumManager;
	DELETE FROM ClubRepresentative;
	DELETE FROM SystemUser;
	DELETE FROM Stadium;
	DELETE FROM Club;
GO;
EXEC clearAllTables;

-------------------------------------------------------------------

--2.2 a
GO;
CREATE VIEW allAssocManagers AS
	SELECT S.username , S.name
	FROM SportsAssociationManager S;
GO;

--Test allAssocManagers
SELECT * FROM allAssocManagers;

--2.2 b
GO;
CREATE VIEW allClubRepresentatives AS
	SELECT R.username , R.name AS club_rep_name, C.name AS club_name
	From ClubRepresentative R
		INNER JOIN Club C ON C.id = R.club_id
GO;
--Test allClubRepresentatives
SELECT * FROM ClubRepresentative;
SELECT * FROM Club;
SELECT * FROM allClubRepresentatives;


--2.2 c
GO;
CREATE VIEW allStadiumManagers AS
	SELECT M.username , M.name AS stadium_manager_name, S.name AS stadium_name
	FROM StadiumManager M
		INNER JOIN Stadium S ON S.id = M.stadium_id ;

--2.2 d
GO;
CREATE VIEW allFans AS
	SELECT F.name , F.national_id , F.birth_date , F.status
	From Fan F

--2.2 e 
GO; 
CREATE VIEW allMatches AS
	SELECT C1.name AS first_club_name, C2.name AS second_club_name, C1.name AS host_name , M.start_time
	FROM Matches M
		INNER JOIN Club C1 ON C1.id = M.host_id 
		INNER JOIN Club C2 ON C2.id = M.guest_id; 

--2.2 f
GO; 
CREATE VIEW allTickets AS 
	SELECT H.name AS first_club_name, A.name AS second_club_name, S.name AS stadium_name , M.start_time
	FROM Ticket T
		INNER JOIN Matches M ON M.id = T.match_id 
		INNER JOIN Club H ON H.id = M.host_id
		INNER JOIN CLUB A ON A.id = M.guest_id
		INNER JOIN Stadium S on S.id = M.stadium_id;

--2.2 g
GO;
CREATE VIEW allClubs AS
	SELECT C.name , C.location
	FROM Club C

--2.2 h
GO; 
CREATE VIEW allStadiums AS
	SELECT S.name , S.location , S.capacity , S.status 
	From Stadium S

--2.2 i
GO;
CREATE VIEW allRequests AS 
	SELECT CR.name AS club_rep_name, SM.name AS stadium_manager_name, R.status
	FROM HostRequest R
		INNER JOIN ClubRepresentative CR on CR.username = R.cru and CR.id = R.crd
		INNER JOIN StadiumManager SM ON SM.username = R.smu and SM.id = R.smd
  
-------------------------------------------------------------------

--2.3 i
GO;
CREATE PROC addAssociationManager 
	@name VARCHAR(20),
	@username VARCHAR(20),
	@password VARCHAR(20)
	AS

	INSERT INTO SportsAssociationManager(username, name, password) VALUES (@username , @name, @password);

--Test addAssociationManager
EXEC addAssociationManager @name = 'abbas', @username = 'zzz', @password='4343'
SELECT * FROM SportsAssociationManager
--2.3 ii
GO;
CREATE PROC addNewMatch
	@nameFirstClub VARCHAR(20),
	@nameSecondClub VARCHAR(20),
	@nameHostClub VARCHAR(20),
	@time DATETIME
	AS 

	DECLARE @first INT
	SELECT @first = C.id
	FROM Club C
	WHERE C.name = @nameFirstClub;

	DECLARE @second INT
	SELECT @second = C.id
	FROM Club C
	Where C.name = @nameSecondClub;

	IF @nameFirstClub = @nameHostClub
	INSERT INTO MATCHES (start_time , host_id , guest_id) VALUES (@time , @first , @second)
	ELSE
	INSERT INTO MATCHES (start_time , host_id , guest_id) VALUES (@time , @second , @first)

-- Test addNewMatch
--EXEC addNewMatch @nameFirstClub

SELECT * FROM Matches;
--2.3 iii
GO;
CREATE VIEW clubsWithNoMatches AS
	SELECT C.name
	FROM Club C
	WHERE NOT EXISTS (
			SELECT C1.name 
			FROM Club C1
				INNER JOIN Matches M ON M.host_id = C1.id
			WHERE C.id = C1.id
	)
	AND  NOT EXISTS (
			SELECT C2.name 
			FROM Club C2
				INNER JOIN Matches M ON M.guest_id = C2.id
			WHERE C.id = C2.id
	);
-- OR we can use outer join

--2.3 iv
GO;
CREATE PROC deleteMatch 
	@namefirstclub VARCHAR(20),
	@namesecondclub VARCHAR(20),
	@namehostclub VARCHAR(20)
	AS

	DECLARE @first INT

	SELECT @first = C.id
	FROM Club C
	WHERE C.name = @nameFirstClub;

	DECLARE @second INT

	SELECT @second = C.id
	FROM Club C
	Where C.name = @nameSecondClub;

	IF @nameFirstClub = @nameHostClub
	DELETE FROM Matches 
	WHERE (Matches.host_id = @first AND Matches.guest_id = @second) 

	ELSE
	DELETE FROM Matches 
	WHERE (Matches.host_id = @second AND Matches.guest_id = @first) 

--2.3 v
GO;
CREATE PROC deleteMatchesOnStadium
	@nameOfStadium VARCHAR(20)
	AS

	DECLARE @id INT

	SELECT @id = S.id
	FROM Stadium S
	WHERE S.name = @nameOfStadium;

	DELETE FROM Matches 
	WHERE Matches.stadium_id = @id AND Matches.start_time>CURRENT_TIMESTAMP;

--2.3 vi
GO;
CREATE PROC addClub
	@nameOfClub VARCHAR(20),
	@nameOfLocation VARCHAR(20)
	AS

	INSERT INTO Club (name,location) VALUES (@nameOfClub,@nameOfLocation);

--2.3 vii
GO;
CREATE PROC addTicket
	@nameHostClub VARCHAR(20),
	@nameCompetingClub VARCHAR(20),
	@startTime DATETIME
	AS

	DECLARE @hostId INT

	SELECT @hostId = C.id
	FROM Club C
	WHERE C.name = @nameHostClub;

	DECLARE @guestId INT

	SELECT @guestId = C.id
	FROM Club C
	Where C.name = @nameCompetingClub;

	INSERT INTO Matches(start_time,host_id,guest_id) VALUES (@startTime,@hostId,@guestId);

	DECLARE @matchId INT

	SELECT @matchId = M.id
	FROM Matches M
	WHERE M.start_time = @startTime AND M.host_id = @hostId AND M.guest_id = @guestId

	INSERT INTO Ticket (match_id) VALUES (@matchId);

--2.3 viii
GO;
CREATE PROC deleteClub
	@clubName VARCHAR(20)
	AS

	DECLARE @id INT

	SELECT @id = C.id
	FROM Club C
	WHERE C.name = @clubName;

	DELETE FROM Club
	WHERE Club.id = @id;

--2.3 ix
GO;
CREATE PROC addStadium
	@stadiumName VARCHAR(20),
	@location VARCHAR(20),
	@capacity VARCHAR(20)
	AS

	INSERT INTO Stadium (name,capacity,location) VALUES (@stadiumName,@capacity,@location);

--2.3 x
GO;
CREATE PROC deleteStadium
	@stadiumName VARCHAR(20)
	AS

	DECLARE @id INT

	SELECT @id = S.id
	FROM Stadium S
	WHERE S.name = @stadiumName;

	DELETE FROM Stadium 
	WHERE Stadium.id = @id;

--2.3 xi
GO;
CREATE PROC blockFan
	@fanNationalId VARCHAR(20)
	AS

	UPDATE Fan
	SET status = 0
	WHERE Fan.national_id = @fanNationalId

--2.3 xii
GO;
CREATE PROC unblockFan
	@fanNationalId VARCHAR(20)
	AS

	UPDATE Fan
	SET status = 1
	WHERE Fan.national_id = @fanNationalId

--2.3 xiii
GO;
CREATE PROC addRepresentative
	@repName VARCHAR(20),
	@clubName VARCHAR(20),
	@username VARCHAR(20),
	@password VARCHAR(20)
	AS

	DECLARE @clubId INT

	SELECT @clubId = C.id
	FROM Club C
	WHERE C.name = @clubName

	INSERT INTO ClubRepresentative (username,name,club_id,password) VALUES (@username,@repName,@clubId,@password);

--2.3 xiv
GO;
CREATE FUNCTION viewAvailableStadiumsOn (@datetime DATETIME)
	RETURNS TABLE
	AS
	RETURN
		SELECT S.name,S.location,S.capacity
		FROM Stadium S
		WHERE S.status=1 AND NOT EXISTS(
			SELECT * 
			FROM Matches M
			WHERE  S.id = M.stadium_id AND CAST(M.start_time AS DATE) = @datetime
		)
GO;
--Test viewAvailableStadiumsOn
SELECT * FROM Stadium;
SELECT * FROM Matches;
SELECt * FROM [dbo].viewAvailableStadiumsOn('2022/10/28');

--2.3 xv
GO;
CREATE PROC addHostRequest 
	@clubName VARCHAR(20),
	@stadiumName VARCHAR(20),
	@startTime DATETIME
	AS 

	DECLARE @clubRepId INT;
	DECLARE @clubRepUsername VARCHAR(20);
	DECLARE @hostId INT;
	SELECT @clubRepId = CR.id, @clubRepUsername=CR.username, @hostId = C.id
	FROM ClubRepresentative CR
		INNER JOIN Club C on C.id = CR.club_id
	WHERE C.name = @clubName

	DECLARE @stadiumManagerId INT;
	DECLARE @stadiumManagerUsername VARCHAR(20);
	SELECT @stadiumManagerId = SM.id, @stadiumManagerUsername=SM.username
	FROM StadiumManager SM
		INNER JOIN Stadium S on S.id = SM.stadium_id
	WHERE S.name = @stadiumName

	DECLARE @matchId INT
	SELECT @matchId = M.id
	FROM Matches M
	WHERE M.host_id = @hostId AND M.start_time = @startTime

	INSERT INTO Ticket(match_id,smu,smd,cru,crd) VALUES (@matchId,@stadiumManagerUsername,@stadiumManagerId,@clubRepUsername,@clubRepId);
GO;

--2.3 xvi
GO;
CREATE FUNCTION allUnassignedMatches(@clubName VARCHAR(20))
	RETURNS TABLE
	AS 

	RETURN
		SELECT C2.name, M.start_time
		FROM Matches M
			INNER JOIN Club C1 ON C1.id = M.host_id
			INNER JOIN Club C2 ON C2.id = M.guest_id
		WHERE M.stadium_id IS NULL AND @clubName = C1.name
GO;

--Test allUnassignedMatches
SELECT * FROM [dbo].allUnassignedMatches('barca');

--2.3 xvii
GO;
CREATE PROC addStadiumManager
	@name VARCHAR(20),
	@stadiumName VARCHAR(20),
	@username VARCHAR(20),
	@password VARCHAR(20)
	AS

	DECLARE @stadiumId INT
	SELECT @stadiumId = S.id
	FROM Stadium S
	WHERE S.name = @stadiumName

	INSERT INTO StadiumManager(username,name,stadium_id,password) VALUES (@username,@name,@stadiumId,@password);
GO;

--Test addStadiumManager
EXEC addStadiumManager @name='lol',@stadiumName='2y neela',@username='fffffff',@password='1234';
SELECT * FROM Stadium;
SELECT * FROM StadiumManager;

--2.3 xviii
GO;
CREATE FUNCTION allPendingRequests (@username VARCHAR(20))
	RETURNS TABLE
	AS

	RETURN 
		SELECT CR.name AS club_rep_name, C.name AS competing_club,M.start_time
		FROM HostRequest H
			INNER JOIN StadiumManager SM ON H.smu=SM.username AND H.smd=SM.id
			INNER JOIN ClubRepresentative CR ON H.cru = CR.username AND H.crd = CR.id
			INNER JOIN Matches M ON M.id = H.match_id
			INNER JOIN Club C ON C.id = M.guest_id
		WHERE SM.username = @username AND H.status = 'unhandled'
GO;

--Test allPendingRequests
SELECT * FROM [dbo].allPendingRequests('fffffff');

GO;
--2.3 xix
CREATE PROC acceptRequest

	@stadiummanagername VARCHAR(20),
	@hostingclubName VARCHAR(20),
	@competingclubName VARCHAR(20),
	@matchstarttime VARCHAR(20)
	AS
	DECLARE @hostId INT
	SELECT @hostId = C.id
	FROM Club C
	WHERE C.name = @hostingclubName

	DECLARE @competingId INT
	SELECT @competingId = C.id
	FROM Club C
	WHERE C.name = @hostingclubName
	
	DECLARE @requestId INT
	SELECT @requestId = H.id
	FROM HostRequest H INNER JOIN Matches M ON M.id = H.match_id
	WHERE start_time= @matchstarttime AND host_id= @hostId AND guest_id= @competingId

	UPDATE HostRequest
SET status='Accepted'
where id=@requestId


--2.3 xx
GO;
CREATE PROC rejectRequest

	@stadiummanagername VARCHAR(20),
	@hostingclubName VARCHAR(20),
	@competingclubName VARCHAR(20),
	@matchstarttime VARCHAR(20)
	AS
	DECLARE @hostId INT
	SELECT @hostId = C.id
	FROM Club C
	WHERE C.name = @hostingclubName

	DECLARE @competingId INT
	SELECT @competingId = C.id
	FROM Club C
	WHERE C.name = @hostingclubName
	
	DECLARE @requestId INT
	SELECT @requestId = H.id
	FROM HostRequest H INNER JOIN Matches M ON M.id = H.match_id
	WHERE start_time= @matchstarttime AND host_id= @hostId AND guest_id= @competingId

	UPDATE HostRequest
SET status='Rejected'
where id=@requestId

--2.3 xxi
Go
CREATE PROC addfan
	@name VARCHAR(20),
	@nationalidnumber VARCHAR(20),
	@birthdate date,
	@address VARCHAR(20),
	@phonenumber int
	AS

	INSERT INTO Fan(name,national_id,birth_date,address,phone) VALUES (@name,@nationalidnumber,@birthdate,@address,@phonenumber);
GO;

--2.3 xxii 

CREATE FUNCTION upcomingMatchesOfClub (@clubname VARCHAR(20))
	RETURNS TABLE
	AS

	RETURN 
		SELECT C.name, C2.name,M.start_time,S.name
		FROM Matches M 
			inner join Club C ON C.id = M.host_id
			inner join Club C2 on C2.id =M.guest_id
			inner join Stadium S on s.id=m.stadium_id
		WHERE  C.name = @clubname AND start_time> CURRENT_TIMESTAMP

--2.3 xxiii
go
CREATE FUNCTION availableMatchesToAttend (@date date)
	RETURNS TABLE
	AS

	RETURN 
		SELECT C.name, C2.name,M.start_time,S.name
		FROM Matches M 
			inner join Club C ON C.id = M.host_id
			inner join Club C2 on C2.id =M.guest_id
			inner join Stadium S on s.id=m.stadium_id
			inner join Ticket T on t.match_id=M.id
		WHERE  T.status=1 AND @date =CURRENT_TIMESTAMP

--2.3 xxiv
GO;
CREATE PROC purchaseTicket
    @nationalidnumber int,
	@nameHostClub VARCHAR(20),
	@nameCompetingClub VARCHAR(20),
	@startTime DATETIME
	AS

	DECLARE @hostId INT

	SELECT @hostId = C.id
	FROM Club C
	WHERE C.name = @nameHostClub;

	DECLARE @guestId INT

	SELECT @guestId = C.id
	FROM Club C
	Where C.name = @nameCompetingClub;

	

	DECLARE @matchId INT

	SELECT @matchId = M.id
	FROM Matches M
	WHERE M.start_time = @startTime AND M.host_id = @hostId AND M.guest_id = @guestId

	INSERT INTO Ticket (fan_id,match_id) VALUES (@nationalidnumber,@matchId);

GO;
--2.3 xxv
GO;
CREATE PROC updateMatchHost
    
	@nameHostClub VARCHAR(20),
	@nameCompetingClub VARCHAR(20),
	@startTime DATETIME
	AS

	DECLARE @hostId INT

	SELECT @hostId = C.id
	FROM Club C
	WHERE C.name = @nameHostClub;

	DECLARE @guestId INT

	SELECT @guestId = C.id
	FROM Club C
	Where C.name = @nameCompetingClub;

	

	DECLARE @matchId INT

	SELECT @matchId = M.id
	FROM Matches M
	WHERE M.start_time = @startTime AND M.host_id = @hostId AND M.guest_id = @guestId


	UPDATE Matches
	SET host_id= @guestId,guest_id=@hostId
	WHERE host_id=@hostId AND guest_id=@guestId
