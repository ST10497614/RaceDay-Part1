-- =============================================
-- RACE DAY DATABASE - SQL SERVER
-- =============================================

CREATE DATABASE RaceDayDB;
GO
USE RaceDayDB;
GO

-- =============================================
-- 1. CREATE TABLES
-- =============================================

-- Organiser
CREATE TABLE Organiser (
    userID INT IDENTITY(1,1) PRIMARY KEY,
    roleID INT NOT NULL,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    passwordHash VARCHAR(255) NOT NULL,
    createdAT DATETIME DEFAULT GETDATE()
);

-- Event
CREATE TABLE Event (
    eventID INT IDENTITY(1,1) PRIMARY KEY,
    organiserID INT NOT NULL,
    title VARCHAR(150) NOT NULL,
    description VARCHAR(500),
    eventDate DATETIME NOT NULL,
    location VARCHAR(150) NOT NULL,
    categoryID INT NULL, -- from diagram, but usually redundant
    CONSTRAINT FK_Event_Organiser FOREIGN KEY (organiserID) REFERENCES Organiser(userID)
);

-- Route Information
CREATE TABLE RouteInformation (
    routeID INT IDENTITY(1,1) PRIMARY KEY,
    eventID INT NOT NULL,
    routeName VARCHAR(100) NOT NULL,
    startPoint VARCHAR(150) NOT NULL,
    endPoint VARCHAR(150) NOT NULL,
    CONSTRAINT FK_Route_Event FOREIGN KEY (eventID) REFERENCES Event(eventID) ON DELETE CASCADE
);

-- Category
CREATE TABLE Category (
    categoryID INT IDENTITY(1,1) PRIMARY KEY,
    eventID INT NOT NULL,
    categoryName VARCHAR(50) NOT NULL,
    distanceKM DECIMAL(5,2) NOT NULL,
    maxParticipants INT NOT NULL,
    CONSTRAINT FK_Category_Event FOREIGN KEY (eventID) REFERENCES Event(eventID) ON DELETE CASCADE
);

-- Event Category - Junction Table M:N
CREATE TABLE EventCategory (
    categoryID INT NOT NULL,
    eventID INT NOT NULL,
    CONSTRAINT PK_EventCategory PRIMARY KEY (categoryID, eventID),
    CONSTRAINT FK_EC_Category FOREIGN KEY (categoryID) REFERENCES Category(categoryID),
    CONSTRAINT FK_EC_Event FOREIGN KEY (eventID) REFERENCES Event(eventID)
);

-- Participant
CREATE TABLE Participant (
    participantID INT IDENTITY(1,1) PRIMARY KEY,
    participantName VARCHAR(50) NOT NULL,
    participantSurname VARCHAR(50) NOT NULL,
    Field VARCHAR(50) -- from diagram
);

-- Event Participant - Junction Table M:N
CREATE TABLE EventParticipant (
    participantID INT NOT NULL,
    eventID INT NOT NULL,
    Field VARCHAR(50),
    CONSTRAINT PK_EventParticipant PRIMARY KEY (participantID, eventID),
    CONSTRAINT FK_EP_Participant FOREIGN KEY (participantID) REFERENCES Participant(participantID),
    CONSTRAINT FK_EP_Event FOREIGN KEY (eventID) REFERENCES Event(eventID)
);

-- Enrolment
CREATE TABLE Enrolment (
    enrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    participantID INT NOT NULL, -- fixed from userID in diagram
    categoryID INT NOT NULL,
    enrolmentDate DATETIME DEFAULT GETDATE(),
    status VARCHAR(20) NOT NULL DEFAULT 'Active',
    CONSTRAINT FK_Enrolment_Participant FOREIGN KEY (participantID) REFERENCES Participant(participantID),
    CONSTRAINT FK_Enrolment_Category FOREIGN KEY (categoryID) REFERENCES Category(categoryID)
);

-- Result
CREATE TABLE Result (
    resultID INT IDENTITY(1,1) PRIMARY KEY,
    enrolmentID INT NOT NULL UNIQUE,
    finishTime TIME NULL,
    position INT NULL,
    CONSTRAINT FK_Result_Enrolment FOREIGN KEY (enrolmentID) REFERENCES Enrolment(enrolmentID) ON DELETE CASCADE
);
GO

-- =============================================
-- 2. INSERT SAMPLE DATA
-- =============================================

-- Organisers: 2
INSERT INTO Organiser (roleID, fullName, email, passwordHash) VALUES
(1, 'Thabo Mokoena', 'thabo@raceday.co.za', 'hash123'),
(1, 'Sarah Johnson', 'sarah@raceday.co.za', 'hash456');

-- Participants: 2
INSERT INTO Participant (participantName, participantSurname, Field) VALUES
('Lerato', 'Dlamini', 'Senior'),
('John', 'Smith', 'Veteran');

-- Events: 3
INSERT INTO Event (organiserID, title, description, eventDate, location) VALUES
(1, 'Mbombela Marathon', 'Annual city marathon', '2026-11-15 06:00:00', 'Mbombela Stadium'),
(2, 'Lowveld Trail Run', 'Mountain trail race', '2026-12-05 07:00:00', 'Kruger Gate'),
(1, 'Nelspruit Fun Run', 'Family charity run', '2026-10-20 08:00:00', 'River Park');

-- Route Information: 1 per event
INSERT INTO RouteInformation (eventID, routeName, startPoint, endPoint) VALUES
(1, 'Marathon Route A', 'Mbombela Stadium Gate 1', 'Mbombela Stadium Finish Line'),
(2, 'Trail Loop 1', 'Kruger Gate Entrance', 'Kruger Gate Viewpoint'),
(3, 'Fun Run Loop', 'River Park Main Entrance', 'River Park Bandstand');

-- Categories: 2 per event = 6 total
INSERT INTO Category (eventID, categoryName, distanceKM, maxParticipants) VALUES
(1, '21km Half Marathon', 21.00, 500),
(1, '42km Full Marathon', 42.00, 300),
(2, '10km Trail', 10.00, 400),
(2, '21km Trail', 21.00, 200),
(3, '5km Fun Run', 5.00, 1000),
(3, '10km Fun Run', 10.00, 600);

-- EventCategory: Link them
INSERT INTO EventCategory (categoryID, eventID)
SELECT categoryID, eventID FROM Category;

-- EventParticipant: Link participants to events
INSERT INTO EventParticipant (participantID, eventID) VALUES
(1, 1),
(1, 3),
(2, 2);

-- Enrolments: Sample
INSERT INTO Enrolment (participantID, categoryID, status) VALUES
(1, 1, 'Confirmed'), -- Lerato in 21km
(1, 5, 'Confirmed'), -- Lerato in 5km
(2, 3, 'Pending');   -- John in 10km Trail

-- Results: Sample
INSERT INTO Result (enrolmentID, finishTime, position) VALUES
(1, '01:45:30', 15);
GO

-- Check data
SELECT * FROM Organiser;
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM Participant;
SELECT * FROM Enrolment;