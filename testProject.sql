insert into SystemUser(username,password) values('sara.amr','sara123')
insert into SystemUser(username,password) values('malak.amer','malak123')
insert into SystemUser(username,password) values('ahmed.amer','ahmed123')

insert into Fan(national_id,username,phone,name,address,status,birth_date) values ('812','sara.amr',01021112055,'sara','7daye2',0,'01/05/2002')
insert into Fan(national_id,username,phone,name,address,status,birth_date) values ('3428','malak.amer',01000981553,'malak','nargis3',0,'8/12/2002')
insert into Fan(national_id,username,phone,name,address,status,birth_date) values ('3434','ahmed.amer',01021112055,'ahmed','nargis3',1,'8/12/2002')


insert into Stadium(name,status,location,capacity) values('Camp nou',1, 'Barcelona',80000)
insert into Stadium(name,status,location,capacity) values('Stamford bridge',1, 'London',45000)
insert into Stadium(name,status,location,capacity) values('Allianz arena',0, 'Munich',70000)

insert into Club(name,location) values( 'Chelsea','London')
insert into Club(name,location) values( 'Bayern Munich','Munich')
insert into Club(name,location) values( 'Barcelona','Barcelona')


insert into SystemUser(username,password) values('shobeer','sara123')
insert into SystemUser(username,password) values('treka','malak123')
insert into SystemUser(username,password) values('owayran','ahmed123')

INSERT INTO SportsAssociationManager(username,name) VALUES ('shobeer','ahmed')
INSERT INTO SportsAssociationManager(username,name) VALUES ('treka','mohamed')
INSERT INTO SportsAssociationManager(username,name) VALUES ('owayran','saeed')

insert into SystemUser(username,password) values('haleem','haleem123')
insert into SystemUser(username,password) values('hamza','hamza123')
insert into SystemUser(username,password) values('hend','hend123')


INSERT INTO SystemAdmin(username,name) VALUES('haleem','omar')
INSERT INTO SystemAdmin(username,name) VALUES('hamza','aly')
INSERT INTO SystemAdmin(username,name) VALUES('hend','henda')

insert into SystemUser(username,password) values('omar.ashraf','omar123')
insert into SystemUser(username,password) values('ali.3agamy','ali123')
insert into SystemUser(username,password) values('karim.gamaleldin','123')

insert into StadiumManager(username,name,stadium_id) values('omar.ashraf','omar',1)
insert into StadiumManager(username,name,stadium_id) values('ali.3agamy','ali',2)
insert into StadiumManager(username,name,stadium_id) values('karim.gamaleldin','Karim',3)

insert into SystemUser(username,password) values('mostafa.elkout','mostafa123')
insert into SystemUser(username,password) values('mirna.haitham','mirna123')
insert into SystemUser(username,password) values('pep.guardiola','pep123')

insert into ClubRepresentative(username,name,club_id) values('mostafa.elkout','mostafa',2)
insert into ClubRepresentative(username,name,club_id) values('mirna.haitham','mirna',1)
insert into ClubRepresentative(username,name,club_id) values('pep.guardiola','pep',3)

insert into Match(start_time,end_time,stadium_id,host_id,guest_id) values('2022/10/10 9:45:00','2022/10/10 11:00:00',2,1,2)
insert into Match(start_time,end_time,stadium_id,host_id,guest_id) values('2022/11/20 7:45:00','2022/11/20 9:00:00',1,3,2)
insert into Match(start_time,end_time,stadium_id,host_id,guest_id) values('2022/9/11 8:00:00','2022/9/11 11:00:00',3,2,1)


insert into Ticket(status,match_id) values(1,1)
insert into Ticket(status,match_id) values(0,2)
insert into Ticket(status,match_id) values(1,3)


insert into TicketBuyingTransactions(fan_national_id,ticket_id) values('3434',1);
insert into TicketBuyingTransactions(fan_national_id,ticket_id) values('3428',2);
insert into TicketBuyingTransactions(fan_national_id,ticket_id) values('812',3);

insert into HostRequest(status,match_id,smd,crd) values ('accepted',1,2,2) 
insert into HostRequest(status,match_id,smd,crd) values ('rejected',2,1,3)
insert into HostRequest(status,match_id,smd,crd) values ('accepted',3,3,1)

SELECT * FROM SystemUser;
SELECT * FROM Stadium;
SELECT * FROM Club;
SELECT * FROM StadiumManager;
SELECT * FROM ClubRepresentative;
SELECT * FROM Fan;
SELECT * FROM SportsAssociationManager;
SELECT * FROM Match;
SELECT * FROM Ticket;
SELECT * FROM TicketBuyingTransactions;
SELECT * FROM HostRequest;

DELETE FROM HostRequest WHERE match_id IS NULL 
EXEC addNewMatch @hostclub='Chelsea' ,@guestclub='Barcelona', @starttime='2022/12/20 05:00:00', @endtime='2022/12/20 07:00:00'



--Test inserting into stadiums
INSERT INTO Stadium (name,capacity,location) VALUES
('camp nou',1000,'bar'),
('santiago',2000,'madrid'),
('2y neela',1000,'cairo');
SELECT * FROM Stadium;
SELECT * FROM Match
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

--Test inserting into Match
INSERT INTO Match (start_time,end_time,stadium_id,host_id,guest_id) VALUES
('2022/10/30 08:00:00','2022/10/30 10:00:00',2,8,7),
('2022/10/28 05:00:00','2022/10/28 07:00:00',3,9,7),
('2022/12/10 07:00:00','2022/12/10 09:00:00',1,7,8),
('2022/12/11 07:00:00','2022/12/11 09:00:00',NULL,7,8);
SELECT id ,CAST(start_time AS DATE) FROM Match;
SELECT * FROM Match;
DELETE FROM Match
DELETE FROM Club WHERE id=3;
SELECT * FROM Club;

--Test inserting into Host Request
SELECT * FROM Match;
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
