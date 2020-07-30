CREATE DATABASE projectDB;
GO



CREATE TABLE Clients (
    ClientID int IDENTITY(1,1),
    LastName varchar(255),
    FirstName varchar(255),
    Address varchar(255),
    City varchar(255),
	CONSTRAINT PK_Client PRIMARY KEY (ClientID)
);
GO



CREATE TABLE Rooms (
    RoomID int IDENTITY(1,1),
    category varchar(255),
    number_of_seats int,
	CONSTRAINT PK_Room PRIMARY KEY (RoomID)
);
GO



CREATE TABLE Reservations (
    ReservationID int IDENTITY(1,1),
    date_of_reservation datetime,
	end_of_reservation datetime,
    ClientID int,
	CONSTRAINT PK_Reservation PRIMARY KEY (ReservationID),
	FOREIGN KEY (ClientID) REFERENCES Clients(ClientID)
);
GO




CREATE TABLE Reservation_Details (
    ReservationID int,
    type_of_service varchar(255),
	status  varchar(255),
	FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);
GO




CREATE TABLE Reservation_Rooms (
    ReservationID int,
    RoomID int,
	FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
	FOREIGN KEY (ReservationID) REFERENCES Reservations(ReservationID)
);
GO




INSERT INTO Clients (LastName, FirstName, Address, City) VALUES
('Erikson', 'Tom', 'Green 8', 'New York'),
('Mosby', 'Ted', 'Red 3', 'New York'),
('Ent', 'Lily', 'Yellow 5', 'LA'),
('Green', 'Rachel', 'Candy 9', 'New York'),
('Sherbatsky', 'Robin', 'Melody 4', 'Vancouver'),
('Esen', 'Barney', 'Rose 6', 'Washington'),
('Kin', 'John', 'Future 2', 'Phoenix'),
('Titarelli', 'Monica', 'Purple 8', 'Atlanta'),
('Tompson', 'Ross', 'Blue 1', 'Miami'),
('Titarelli', 'Gabriella', 'Pink 7', 'London')
; 
GO

INSERT INTO Rooms (category, number_of_seats) VALUES
('meeting room', 50),
('seminar room', 250),
('seminar room', 150),
('seminar room', 180),
('meeting room', 65),
('seminar room', 270),
('meeting room', 38),
('seminar room', 170),
('meeting room', 80),
('seminar room', 265)
; 
GO


INSERT INTO Reservations (date_of_reservation, end_of_reservation, ClientID) VALUES
(convert(datetime,'18-06-20 10:00:00 AM',5), convert(datetime,'18-06-20 02:30:00 PM',5), 2),
(convert(datetime,'20-07-20 09:00:00 AM',5), convert(datetime,'20-07-20 11:30:00 AM',5), 3),
(convert(datetime,'27-05-20 03:30:00 PM',5), convert(datetime,'27-05-20 06:00:00 PM',5), 3),
(convert(datetime,'27-05-20 09:30:00 AM',5), convert(datetime,'27-05-20 02:00:00 PM',5), 7),
(convert(datetime,'25-05-20 09:30:00 AM',5), convert(datetime,'25-05-20 02:00:00 PM',5), 6),
(convert(datetime,'26-05-20 03:30:00 PM',5), convert(datetime,'26-05-20 06:00:00 PM',5), 9),
(convert(datetime,'22-06-20 09:00:00 AM',5), convert(datetime,'22-06-20 03:30:00 PM',5), 1),
(convert(datetime,'23-06-20 09:00:00 AM',5), convert(datetime,'23-06-20 02:30:00 PM',5), 7),
(convert(datetime,'21-07-20 09:00:00 AM',5), convert(datetime,'21-07-20 11:30:00 AM',5), 5),
(convert(datetime,'20-07-20 09:00:00 AM',5), convert(datetime,'22-07-20 03:30:00 PM',5), 10),
(convert(datetime,'21-07-20 09:00:00 AM',5), convert(datetime,'22-07-20 03:30:00 PM',5), 10)
; 
GO

INSERT INTO Reservations (date_of_reservation, end_of_reservation, ClientID) VALUES
(convert(datetime,'03-08-20 09:00:00 AM',5), convert(datetime,'03-08-20 03:30:00 PM',5), 7),
(convert(datetime,'03-08-20 09:00:00 AM',5), convert(datetime,'03-08-20 03:30:00 PM',5), 5);

INSERT INTO Reservations (date_of_reservation, end_of_reservation, ClientID) VALUES
(convert(datetime,'04-08-20 09:00:00 AM',5), convert(datetime,'04-08-20 03:30:00 PM',5), 3);



INSERT INTO Reservation_Details (ReservationID, type_of_service, status) VALUES
(1, 'catering', 'confirmed'),
(10, 'party', 'confirmed'),
(3, 'catering', 'confirmed'),
(2, 'catering', 'cancelled'),
(4, 'catering', 'confirmed'),
(5, 'party', 'confirmed'),
(6, 'catering', 'confirmed'),
(7, 'party', 'confirmed'),
(8, 'party', 'confirmed'),
(9, 'catering', 'cancelled')
; 
GO

INSERT INTO Reservation_Details (ReservationID, type_of_service) VALUES
(11, 'catering'),
(12, 'catering'),
(13, 'catering')
; 

INSERT INTO Reservation_Details (ReservationID, type_of_service) VALUES
(14, 'catering');

INSERT INTO Reservation_Rooms (ReservationID, RoomID) VALUES
(1, 2),
(1, 3),
(2, 1),
(3, 7),
(10, 1),
(10, 2),
(10, 3),
(10, 4),
(10, 5),
(10, 6),
(10, 7),
(10, 8),
(10, 9),
(10, 10),
(4, 2),
(5, 3),
(6, 1),
(7, 7),
(8, 5),
(9, 8)
; 
GO

INSERT INTO Reservation_Rooms (ReservationID, RoomID) VALUES
(12, 5),
(11, 8),
(13, 7);

INSERT INTO Reservation_Rooms (ReservationID, RoomID) VALUES
(14, 5);



INSERT INTO Reservation_Rooms (ReservationID, RoomID) VALUES
(12, 5),
(11, 8),
(13, 7);




-- Index in Reservation_Details on ReservationID can be used to easily find all the reservation details
-- records belonging to reservation 10

create Clustered index CI_Reservation_Details_IDX
	 on Reservation_Details(ReservationID)

create Clustered index CI_Reservation_Rooms_IDX
	 on Reservation_Rooms(ReservationID, RoomID)


-- Index all columns freqently use for JOIN (SEARCH) operations 
--to improve performance while searching for records matching a condition (WHERE and JOIN clause)
-- or sorting them (ORDER BY)

--select .... from .... join ... where ClientID = 7  
-- can be used to sort Table by some column (Order By)
 
create nonclustered index IX_Reservation_Client 
	on Reservations(ClientID)

create nonclustered index IX_Client 
	on Clients(ClientID)

create nonclustered index IX_Client_Name 
	on Clients(LastName, FirstName)

create nonclustered index IX_Client_Address 
	on Clients(Address, City)

Drop index PK_Reservation_Detail ON Reservation_Details

-- Clients is done

create nonclustered index IX_ReservStatus 
	on Reservation_Details(status)

create nonclustered index IX_ReservService 
	on Reservation_Details(type_of_service)

-- Reservation_Details is done

-- Reservation_Rooms is done

create nonclustered index IX_RoomCategory 
	on Rooms(category, number_of_seats)

-- Rooms is done

create nonclustered index IX_IDX3 on Reservations(ReservationID, ClientID) 

create nonclustered index IX_Reservation_dates
	on Reservations(ReservationID, date_of_reservation, end_of_reservation)

-- Reservations is done


-- 1. Displays the number of meeting and seminar rooms (each category separately) 
-- reserved each day – please include only days where there is any reservation,


--test1 seminar rooms
with DateTable as
(
    select R.ReservationID, R.date_of_reservation as Dt, R.end_of_reservation
    from Reservations R
    union all
    select DateTable.ReservationID, DATEADD(D, 1, Dt), end_of_reservation
    from DateTable
    where DATEADD(D, 1, Dt) <= end_of_reservation
)
--a select statement that catenates the test name and the case statement
select concat( 
-- the test name
'seminar rooms: ', 
-- the case statement
   case when 
-- one or more subqueries
-- in this case, an expected value and an actual value 
-- that must be equal for the test to pass
  ( select SUM(T.NumberOfRooms) FROM (select COUNT(RR.RoomID) AS NumberOfRooms, Dt as Dates
from DateTable JOIN Reservations R ON R.ReservationID = DateTable.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID =  R.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Rooms RM ON RM.RoomID =  RR.RoomID
WHERE RD.status = 'confirmed' and RM.category = 'seminar room'
GROUP BY Dt) T ) 
  --expected value,
  = (SELECT SUM(T.AmountOfDays) AS N_SeminarRooms FROM Rooms RM 
JOIN (SELECT RR.RoomID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays FROM Reservation_Rooms RR
JOIN Reservations R ON R.ReservationID = RR.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' 
GROUP BY RR.RoomID, R.end_of_reservation, R.date_of_reservation) T ON RM.RoomID=T.RoomID
WHERE RM.category = 'seminar room')  
  -- actual value
  -- the then and else branches of the case statement
  then 'passed' else 'failed' end
  -- close the concat function and terminate the query 
  ); 
  -- test result. 22

--test1 meeting rooms
with DateTable as
(
    select R.ReservationID, R.date_of_reservation as Dt, R.end_of_reservation
    from Reservations R
    union all
    select DateTable.ReservationID, DATEADD(D, 1, Dt), end_of_reservation
    from DateTable
    where DATEADD(D, 1, Dt) <= end_of_reservation
)
--a select statement that catenates the test name and the case statement
select concat( 
-- the test name
'meeting rooms: ', 
-- the case statement
   case when 
-- one or more subqueries
-- in this case, an expected value and an actual value 
-- that must be equal for the test to pass
  ( select SUM(T.NumberOfRooms) FROM (select COUNT(RR.RoomID) AS NumberOfRooms, Dt as Dates
from DateTable JOIN Reservations R ON R.ReservationID = DateTable.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID =  R.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Rooms RM ON RM.RoomID =  RR.RoomID
WHERE RD.status = 'confirmed' and RM.category = 'meeting room'
GROUP BY Dt) T ) 
  --expected value,
  = (SELECT SUM(T.AmountOfDays) AS N_SeminarRooms FROM Rooms RM 
JOIN (SELECT RR.RoomID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays FROM Reservation_Rooms RR
JOIN Reservations R ON R.ReservationID = RR.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' 
GROUP BY RR.RoomID, R.end_of_reservation, R.date_of_reservation) T ON RM.RoomID=T.RoomID
WHERE RM.category = 'meeting room')  
  -- actual value
  -- the then and else branches of the case statement
  then 'passed' else 'failed' end
  -- close the concat function and terminate the query 
  ); 
  -- test result. 16



with DateTable as
(
    select R.ReservationID, R.date_of_reservation as Dt, R.end_of_reservation
    from Reservations R
    union all
    select DateTable.ReservationID, DATEADD(D, 1, Dt), end_of_reservation
    from DateTable
    where DATEADD(D, 1, Dt) <= end_of_reservation
)
select COUNT(RR.RoomID) AS NumberOfRooms, Dt as Dates
from DateTable JOIN Reservations R ON R.ReservationID = DateTable.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID =  R.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Rooms RM ON RM.RoomID =  RR.RoomID
WHERE RD.status = 'confirmed' and RM.category = 'seminar room'
GROUP BY Dt
order by Dt


with DateTable as
(
    select R.ReservationID, R.date_of_reservation as Dt, R.end_of_reservation
    from Reservations R
    union all
    select DateTable.ReservationID, DATEADD(D, 1, Dt), end_of_reservation
    from DateTable
    where DATEADD(D, 1, Dt) <= end_of_reservation
)
select COUNT(RR.RoomID) AS NumberOfRooms, Dt as Dates
from DateTable JOIN Reservations R ON R.ReservationID = DateTable.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID =  R.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Rooms RM ON RM.RoomID =  RR.RoomID
WHERE RD.status = 'confirmed' and RM.category = 'meeting room'
GROUP BY Dt
order by Dt




----------------------------------------------------------------------------------
 

-- 2. displays the clients that actually booked something, ordered by the number of total booked room-days,

-- 2 test COUNT(Cl)=COUNT(Cl) that have reservations

select concat( 
-- the test name
'the clients that actually booked something: ', 
-- the case statement
   case when 
-- one or more subqueries
-- in this case, an expected value and an actual value 
-- that must be equal for the test to pass
  (SELECT COUNT(TD.ClientID) FROM (SELECT C.ClientID, SUM(T.AmountOfDays_perRoom) AS totalBookedRoomDays FROM Clients C
JOIN (SELECT C.ClientID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays_perRoom FROM Clients C
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID=R.ReservationID 
WHERE RD.status = 'confirmed' GROUP BY C.ClientID, R.end_of_reservation, R.date_of_reservation) T ON C.ClientID=T.ClientID
GROUP BY C.ClientID) TD) 
  --expected value,
  = (SELECT COUNT( DISTINCT C.ClientID) FROM Clients C  
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed')  
  -- actual value
  -- the then and else branches of the case statement
  then 'passed' else 'failed' end
  -- close the concat function and terminate the query 
  ); 
   -- test result.  7


-- room-days
SELECT C.ClientID, SUM(T.AmountOfDays_perRoom) AS totalBookedRoomDays FROM Clients C
JOIN (SELECT C.ClientID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays_perRoom FROM Clients C
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID=R.ReservationID 
WHERE RD.status = 'confirmed' GROUP BY C.ClientID, R.end_of_reservation, R.date_of_reservation) T ON C.ClientID=T.ClientID
GROUP BY C.ClientID
ORDER BY SUM(T.AmountOfDays_perRoom) DESC;


--3. displays the clients ordered by their total number of unconfirmed room-days reservations,


-- 3 test COUNT(Cl)=COUNT(Cl) that have no reservations

select concat( 
-- the test name
'the clients of unconfirmed room-days reservations: ', 
-- the case statement
   case when 
-- one or more subqueries
-- in this case, an expected value and an actual value 
-- that must be equal for the test to pass
  (SELECT COUNT(TD.ClientID) FROM (SELECT C.ClientID, SUM(T.AmountOfDays_perRoom) AS totalBookedRoomDays FROM Clients C
JOIN (SELECT C.ClientID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays_perRoom FROM Clients C
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID=R.ReservationID 
WHERE RD.status = 'cancelled' GROUP BY C.ClientID, R.end_of_reservation, R.date_of_reservation) T ON C.ClientID=T.ClientID
GROUP BY C.ClientID) TD) 
  --expected value,
  = (SELECT COUNT( DISTINCT C.ClientID) FROM Clients C  
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'cancelled')  
  -- actual value
  -- the then and else branches of the case statement
  then 'passed' else 'failed' end
  -- close the concat function and terminate the query 
  ); 
   -- test result.  2


-- room-days
SELECT C.ClientID, SUM(T.AmountOfDays_perRoom) AS totalBookedRoomDays FROM Clients C
JOIN (SELECT C.ClientID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays_perRoom FROM Clients C
JOIN Reservations R ON R.ClientID = C.ClientID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
JOIN Reservation_Rooms RR ON RR.ReservationID=R.ReservationID 
WHERE RD.status = 'cancelled' GROUP BY C.ClientID, R.end_of_reservation, R.date_of_reservation) T ON C.ClientID=T.ClientID
GROUP BY C.ClientID
ORDER BY SUM(T.AmountOfDays_perRoom) DESC;



--4. finds the nearest date with no reservations at all. Remember that ‘’Mermaid’’ is closed on Sundays,

-- 4 test if this date<>Sunday and not exists in table

DECLARE @Avail AS datetime = NULL;
 
  with DateTable as
(
    select R.ReservationID, R.date_of_reservation as Dt, R.end_of_reservation
    from Reservations R
    union all
    select DateTable.ReservationID, DATEADD(D, 1, Dt), end_of_reservation
    from DateTable
    where DATEADD(D, 1, Dt) <= end_of_reservation
)
SELECT @Avail FROM
(select Dt as Dates
from DateTable JOIN Reservations R ON R.ReservationID = DateTable.ReservationID 
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' 
GROUP BY Dt
INTERSECT 
SELECT m.Closest_free_day FROM
(SELECT TOP 1 c.needed_date, 
CASE WHEN (datediff(DAY,  GETDATE(), c.needed_date)>1) THEN GETDATE() ELSE c.needed_date END as Closest_free_day FROM  
(SELECT TOP 1 b.beginning_date+1 as needed_date FROM
(SELECT TOP 1 R.end_of_reservation as beginning_date, LEAD(R.date_of_reservation) over (order by R.date_of_reservation) as End_day,
DATENAME(WEEKDAY, R.end_of_reservation) AS DAY_OF_WEEK FROM Reservations R
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID  
WHERE R.end_of_reservation >= GETDATE() and RD.status='confirmed' ORDER BY R.date_of_reservation) b 
GROUP BY b.beginning_date, b.End_day
HAVING DAY(b.End_day)-DAY(b.beginning_date)>1 ) c) m
WHERE DATENAME(WEEKDAY, m.Closest_free_day)<>'Sunday') MN; 
  -- actual value
  -- the then and else branches of the case statement
IF @Avail is NULL
    SELECT 0 AS Passed
ELSE 
    SELECT @Avail AS failed



SELECT m.Closest_free_day FROM
(SELECT TOP 1 c.needed_date, 
CASE WHEN (datediff(DAY,  GETDATE(), c.needed_date)>1) THEN GETDATE() ELSE c.needed_date END as Closest_free_day FROM  
(SELECT TOP 1 b.beginning_date+1 as needed_date FROM
(SELECT TOP 1 R.end_of_reservation as beginning_date, LEAD(R.date_of_reservation) over (order by R.date_of_reservation) as End_day,
DATENAME(WEEKDAY, R.end_of_reservation) AS DAY_OF_WEEK FROM Reservations R
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID  
WHERE R.end_of_reservation >= GETDATE() and RD.status='confirmed' ORDER BY R.date_of_reservation) b 
GROUP BY b.beginning_date, b.End_day
HAVING DAY(b.End_day)-DAY(b.beginning_date)>1 ) c) m
WHERE DATENAME(WEEKDAY, m.Closest_free_day)<>'Sunday';


--5. displays five least popular rooms; 

-- 5 test count()=count(roomID) in Res_Rooms

DECLARE @Avail AS int = NULL;

SELECT @Avail FROM
  (SELECT TOP 5 TD.RoomID FROM
(SELECT TOP 5 T.RoomID FROM Rooms RM 
JOIN (SELECT RR.RoomID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays FROM Reservation_Rooms RR
JOIN Reservations R ON R.ReservationID = RR.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' 
GROUP BY RR.RoomID, R.end_of_reservation, R.date_of_reservation) T ON RM.RoomID=T.RoomID
GROUP BY T.RoomID
ORDER BY SUM(T.AmountOfDays)) TD 
  --expected value,
  EXCEPT SELECT TOP 5 T.RoomID FROM(SELECT TOP 5 RR.RoomID FROM Reservation_Rooms RR JOIN Reservations R ON R.ReservationID = RR.ReservationID JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' GROUP BY RR.RoomID ORDER BY COUNT(RR.RoomID)) T ORDER BY T.RoomID ) TT; 
  -- actual value
  -- the then and else branches of the case statement
IF @Avail is NULL
    SELECT 0 AS Passed
ELSE 
    SELECT @Avail as failed
--CASE WHEN @Avail = ''  then 'passed' else 'failed' end;
  -- close the concat function and terminate the query 
  --); 
   -- test result.  


SELECT TOP 5 RM.RoomID FROM Rooms RM 
WHERE RM.RoomID IN
(SELECT TOP 5 RM.RoomID FROM Rooms RM 
JOIN (SELECT RR.RoomID, CASE WHEN (DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) > 1 THEN COUNT(RR.RoomID)*(DAY(R.end_of_reservation)-DAY(R.date_of_reservation)+1) ELSE COUNT(RR.RoomID) END AS AmountOfDays FROM Reservation_Rooms RR
JOIN Reservations R ON R.ReservationID = RR.ReservationID
JOIN Reservation_Details RD ON RD.ReservationID =  R.ReservationID 
WHERE RD.status = 'confirmed' 
GROUP BY RR.RoomID, R.end_of_reservation, R.date_of_reservation) T ON RM.RoomID=T.RoomID
GROUP BY RM.RoomID
ORDER BY SUM(T.AmountOfDays))
OR  RM.RoomID IN
(SELECT TOP 5 RM.RoomID FROM Rooms RM 
WHERE RM.RoomID NOT IN (SELECT RoomID FROM Reservation_Rooms))
GROUP BY RM.RoomID;


--------------------------------------------------------------------------------------

-- Stored Procedure of the reservation's confirmation

-- The procedure takes one parameter – the reservation id. 
-- If all the rooms (and terrace) are still available, 
-- the reservation is marked as confirmed. 
-- Otherwise an error is printed. 
-- In case reservation is successful, all colliding reservations are marked as ‘’cancelled’’ 
-- and their list is printed out.



IF OBJECT_ID ( 'ConfirmationOfReservations', 'P' ) IS NOT NULL   
    DROP PROCEDURE ConfirmationOfReservations;  
GO  
create procedure ConfirmationOfReservations @ReservationID int
as
begin
	declare @rooms table (roomid int not null)-- This variable will hold the rooms of ResID
	declare @start_date date -- This variable will hold the start date of ResID
	declare @end_date date-- This variable will hold the end date of ResID
	insert into @rooms
		select R.RoomID from Reservation_Rooms R where R.ReservationID=@ReservationID

	select @start_date=R.date_of_reservation, @end_date=R.end_of_reservation from Reservations R where R.ReservationID=@ReservationID
	

	if exists(
	select * from Reservations R join Reservation_Rooms RR on R.ReservationID = RR.ReservationID join Reservation_Details RD on R.ReservationID = RD.ReservationID inner join @rooms rm on RR.RoomID = rm.roomid
	where ((@start_date < R.date_of_reservation and R.date_of_reservation < @end_date) or (@start_date < R.end_of_reservation and R.end_of_reservation < @end_date)) and (R.ReservationID != @ReservationID) and (RD.status = 'confirmed')
	)
	begin
		print('Sorry! this slot is already taken')
	end
	Else
	begin
		update Reservation_Details set status='confirmed' where ReservationID=@ReservationID


		declare @conflictID table (rid int not null)

		insert into @conflictID
			select R.ReservationID from Reservations R join Reservation_Rooms RR on R.ReservationID = RR.ReservationID join Reservation_Details RD on R.ReservationID = RD.ReservationID inner join @rooms rm on RR.RoomID = rm.roomid
			where ((@start_date < R.date_of_reservation and R.date_of_reservation < @end_date) or (@start_date < R.end_of_reservation and R.end_of_reservation < @end_date)) and (R.ReservationID != @ReservationID) 
		
		
		update Reservation_Details set status='cancelled' from @conflictID c inner join Reservation_Details rd on c.rid = rd.ReservationID
		print('canceled reservations IDs:')
		
		--Printing the conflicted dates
		DECLARE @PractitionerId int

		DECLARE MY_CURSOR CURSOR 
			LOCAL STATIC READ_ONLY FORWARD_ONLY
		FOR 
			SELECT DISTINCT rid 
			FROM @conflictID

		OPEN MY_CURSOR
		FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
		WHILE @@FETCH_STATUS = 0
		BEGIN 
			PRINT CAST(@PractitionerId as varchar)+', '
		FETCH NEXT FROM MY_CURSOR INTO @PractitionerId
		END
		CLOSE MY_CURSOR
		DEALLOCATE MY_CURSOR

	end
end
go

EXEC ConfirmationOfReservations @ReservationID = 10;  




-- test script for the stored procedure
BEGIN
SELECT * FROM Reservation_Details WHERE ReservationID = 14; 

EXEC ConfirmationOfReservations @ReservationID = 14;  
  
SELECT * FROM Reservation_Details WHERE ReservationID = 14; 
END

Select * FROM Reservations;




