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
		username VARCHAR(20),
		id INT IDENTITY,
		name VARCHAR(20),
		stadium_id INT,
		password VARCHAR(20),
		CONSTRAINT pk_stadium_manager PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE ClubRepresentative(
		username VARCHAR(20),
		id INT IDENTITY,
		name VARCHAR(20),
		club_id INT,
		password VARCHAR(20),
		CONSTRAINT pk_club_rep PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(club_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE Fan(
		username VARCHAR(20),
		national_id VARCHAR(20),
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
		username VARCHAR(20),
		id INT IDENTITY,
		name VARCHAR(20),
		password VARCHAR(20),
		CONSTRAINT pk_sam PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE SystemAdmin(
		username VARCHAR(20),
		id INT IDENTITY,
		name VARCHAR(20),
		password VARCHAR(20),
		CONSTRAINT pk_system_admin PRIMARY KEY(username,id),
--		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE Matches(
		id INT IDENTITY,
		start_time DATETIME,
		end_time DATETIME,
		allowed_num_of_attendees INT,
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
		FOREIGN KEY(smu,smd) REFERENCES StadiumManager(username,id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(cru,crd) REFERENCES ClubRepresentative(username,id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(match_id) REFERENCES Matches(id) ON DELETE NO ACTION ON UPDATE NO ACTION
	);
GO;
Drop PROC createAllTables;
EXEC createAllTables;

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

--2.2 b
GO;
CREATE VIEW allClubRepresentatives AS
	SELECT R.username , R.name AS club_rep_name, C.name AS club_name
	From ClubRepresentative R
		INNER JOIN Club C ON C.id = R.club_id

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


