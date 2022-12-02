CREATE DATABASE FootballDB;

GO;
CREATE PROCEDURE createAllTables
AS
	CREATE TABLE SystemUser(
		username VARCHAR(20),
		password VARCHAR(20),
		CONSTRAINT pk_system_user PRIMARY KEY(username)
	);

	CREATE TABLE Stadium(
		id int IDENTITY,
		name VARCHAR(20),
		capacity int,
		location VARCHAR(20),
		status BIT,
		CONSTRAINT pk_stadium PRIMARY KEY(id)
	);

	CREATE TABLE Club(
		id int IDENTITY,
		name VARCHAR(20),
		location VARCHAR(20),
		CONSTRAINT pk_club PRIMARY KEY(id)
	);

	CREATE TABLE StadiumManager(
		username VARCHAR(20),
		id int IDENTITY,
		name VARCHAR(20),
		stadium_id int,
		CONSTRAINT pk_stadium_manager PRIMARY KEY(username,id),
		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE ClubRepresentative(
		username VARCHAR(20),
		id int IDENTITY,
		name VARCHAR(20),
		club_id int,
		CONSTRAINT pk_club_rep PRIMARY KEY(username,id),
		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(club_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE Fan(
		username VARCHAR(20),
		national_id VARCHAR(20),
		phone VARCHAR(20),
		name VARCHAR(20),
		address VARCHAR(20),
		status BIT,
		birth_date DATE,
		CONSTRAINT pk_fan PRIMARY KEY(username,national_id),
		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE SportsAssociationManager(
		username VARCHAR(20),
		id int IDENTITY,
		name VARCHAR(20),
		CONSTRAINT pk_sam PRIMARY KEY(username,id),
		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE SystemAdmin(
		username VARCHAR(20),
		id int IDENTITY,
		name VARCHAR(20),
		CONSTRAINT pk_system_admin PRIMARY KEY(username,id),
		FOREIGN KEY(username) REFERENCES SystemUser(username) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE Match(
		id int IDENTITY,
		start_time DATETIME,
		end_time DATETIME,
		allowed_num_of_attendees int,
		stadium_id int,
		host_id int,
		guest_id int,
		CONSTRAINT pk_match PRIMARY KEY(id),
		FOREIGN KEY(host_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(guest_id) REFERENCES Club(id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(stadium_id) REFERENCES Stadium(id) ON DELETE CASCADE ON UPDATE CASCADE
	);

	CREATE TABLE Ticket(
		id int IDENTITY,
		status BIT,
		fan_username VARCHAR(20),
		fan_id int,
		match_id int,
		CONSTRAINT pk_ticket PRIMARY KEY(id),
		FOREIGN KEY(fan_username,fan_id) REFERENCES Fan(username,id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(match_id) REFERENCES Match(id) ON DELETE CASCADE ON UPDATE CASCADE,
	);

	CREATE TABLE HostRequest(
		id int IDENTITY,
		status BIT,
		match_id int,
		smd int,
		crd int,
		CONSTRAINT pk_host_request PRIMARY KEY(id),
		FOREIGN KEY(smd) REFERENCES StadiumManager(id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(match_id) REFERENCES Match(id) ON DELETE CASCADE ON UPDATE CASCADE,
		FOREIGN KEY(crd) REFERENCES ClubRepresentative(id) ON DELETE CASCADE ON UPDATE CASCADE
	);
GO;
Drop PROC createAllTables;
EXEC createAllTables;

GO;
CREATE PROC dropAllTables
AS
	DROP TABLE IF EXISTS 
	SystemUser,
	StadiumManager,
	ClubRepresentative,
	Fan,
	SportsAssociationManager,
	SystemAdmin,
	Ticket,
	MATCH,
	Stadium,
	Club,
	HostRequest;
GO;
Drop PROC dropAllTables;
EXEC dropAllTables;