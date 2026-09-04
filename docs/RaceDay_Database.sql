/* RaceDay database: SQL Server / SSMS. Run this file on a clean SQL Server instance. */
IF DB_ID(N'RaceDayDb') IS NULL CREATE DATABASE RaceDayDb;
GO
USE RaceDayDb;
GO

CREATE TABLE dbo.Users (
    UserId INT IDENTITY(1,1) CONSTRAINT PK_Users PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(255) NOT NULL CONSTRAINT UQ_Users_Email UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL CONSTRAINT CK_Users_Role CHECK (Role IN ('Organiser', 'Participant')),
    PhoneNumber NVARCHAR(30) NULL,
    CreatedAt DATETIME2 NOT NULL CONSTRAINT DF_Users_CreatedAt DEFAULT SYSUTCDATETIME()
);

CREATE TABLE dbo.Events (
    EventId INT IDENTITY(1,1) CONSTRAINT PK_Events PRIMARY KEY,
    OrganiserId INT NOT NULL,
    Name NVARCHAR(150) NOT NULL,
    Description NVARCHAR(1000) NULL,
    EventDate DATETIME2 NOT NULL,
    Venue NVARCHAR(200) NOT NULL,
    Status VARCHAR(20) NOT NULL CONSTRAINT DF_Events_Status DEFAULT 'Draft'
        CONSTRAINT CK_Events_Status CHECK (Status IN ('Draft', 'Published', 'Cancelled', 'Completed')),
    CONSTRAINT FK_Events_Organiser FOREIGN KEY (OrganiserId) REFERENCES dbo.Users(UserId)
);

CREATE TABLE dbo.Categories (
    CategoryId INT IDENTITY(1,1) CONSTRAINT PK_Categories PRIMARY KEY,
    EventId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL CONSTRAINT CK_Categories_Distance CHECK (DistanceKm > 0),
    EntryFee DECIMAL(10,2) NOT NULL CONSTRAINT CK_Categories_Fee CHECK (EntryFee >= 0),
    Capacity INT NOT NULL CONSTRAINT CK_Categories_Capacity CHECK (Capacity > 0),
    CONSTRAINT UQ_Categories_Event_Name UNIQUE (EventId, Name),
    CONSTRAINT FK_Categories_Event FOREIGN KEY (EventId) REFERENCES dbo.Events(EventId)
);

CREATE TABLE dbo.Enrolments (
    EnrolmentId INT IDENTITY(1,1) CONSTRAINT PK_Enrolments PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    BibNumber INT NULL,
    EnrolledAt DATETIME2 NOT NULL CONSTRAINT DF_Enrolments_EnrolledAt DEFAULT SYSUTCDATETIME(),
    Status VARCHAR(20) NOT NULL CONSTRAINT DF_Enrolments_Status DEFAULT 'Active'
        CONSTRAINT CK_Enrolments_Status CHECK (Status IN ('Active', 'Cancelled', 'Withdrawn')),
    CONSTRAINT UQ_Enrolments_Participant_Category UNIQUE (ParticipantId, CategoryId),
    CONSTRAINT UQ_Enrolments_Category_Bib UNIQUE (CategoryId, BibNumber),
    CONSTRAINT FK_Enrolments_Participant FOREIGN KEY (ParticipantId) REFERENCES dbo.Users(UserId),
    CONSTRAINT FK_Enrolments_Category FOREIGN KEY (CategoryId) REFERENCES dbo.Categories(CategoryId)
);

CREATE TABLE dbo.Results (
    ResultId INT IDENTITY(1,1) CONSTRAINT PK_Results PRIMARY KEY,
    EnrolmentId INT NOT NULL CONSTRAINT UQ_Results_Enrolment UNIQUE,
    FinishTimeSeconds INT NULL,
    Position INT NULL,
    ResultStatus VARCHAR(10) NOT NULL CONSTRAINT CK_Results_Status CHECK (ResultStatus IN ('Finished', 'DNF', 'DNS', 'DSQ')),
    RecordedAt DATETIME2 NOT NULL CONSTRAINT DF_Results_RecordedAt DEFAULT SYSUTCDATETIME(),
    CONSTRAINT CK_Results_FinishTime CHECK (FinishTimeSeconds IS NULL OR FinishTimeSeconds > 0),
    CONSTRAINT CK_Results_Position CHECK (Position IS NULL OR Position > 0),
    CONSTRAINT FK_Results_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES dbo.Enrolments(EnrolmentId)
);

CREATE TABLE dbo.Payments (
    PaymentId INT IDENTITY(1,1) CONSTRAINT PK_Payments PRIMARY KEY,
    EnrolmentId INT NOT NULL CONSTRAINT UQ_Payments_Enrolment UNIQUE,
    Amount DECIMAL(10,2) NOT NULL CONSTRAINT CK_Payments_Amount CHECK (Amount >= 0),
    PaymentReference NVARCHAR(80) NOT NULL CONSTRAINT UQ_Payments_Reference UNIQUE,
    PaymentStatus VARCHAR(20) NOT NULL CONSTRAINT DF_Payments_Status DEFAULT 'Pending'
        CONSTRAINT CK_Payments_Status CHECK (PaymentStatus IN ('Pending', 'Paid', 'Refunded', 'Failed')),
    PaidAt DATETIME2 NULL,
    CONSTRAINT FK_Payments_Enrolment FOREIGN KEY (EnrolmentId) REFERENCES dbo.Enrolments(EnrolmentId)
);
GO

INSERT INTO dbo.Users (FullName, Email, PasswordHash, Role, PhoneNumber) VALUES
(N'Naledi Mokoena', N'naledi@raceday.test', N'SeedHash_NotForProduction_1', 'Organiser', N'0825550101'),
(N'James Petersen', N'james@raceday.test', N'SeedHash_NotForProduction_2', 'Organiser', N'0825550102'),
(N'Ayesha Khan', N'ayesha@raceday.test', N'SeedHash_NotForProduction_3', 'Participant', N'0825550201'),
(N'Sipho Dlamini', N'sipho@raceday.test', N'SeedHash_NotForProduction_4', 'Participant', N'0825550202'),
(N'Emma Botha', N'emma@raceday.test', N'SeedHash_NotForProduction_5', 'Participant', N'0825550203');

INSERT INTO dbo.Events (OrganiserId, Name, Description, EventDate, Venue, Status) VALUES
(1, N'Joburg Spring 10K', N'A city road race for runners of all levels.', '2026-10-10T06:30:00', N'Emmarentia Park, Johannesburg', 'Published'),
(1, N'Cradle Mountain Challenge', N'A trail-running event through the Cradle area.', '2026-11-14T06:00:00', N'Cradle Moon Lakeside Game Lodge', 'Published'),
(2, N'Pretoria Family Fun Run', N'An accessible family-oriented community race.', '2026-12-05T07:00:00', N'Loftus Park, Pretoria', 'Published');

INSERT INTO dbo.Categories (EventId, Name, DistanceKm, EntryFee, Capacity) VALUES
(1, N'5 km Fun Run', 5.00, 120.00, 300), (1, N'10 km Road Race', 10.00, 220.00, 500),
(2, N'12 km Trail', 12.00, 280.00, 180), (2, N'25 km Trail', 25.00, 420.00, 120),
(3, N'3 km Family Run', 3.00, 80.00, 400), (3, N'8 km Fun Run', 8.00, 150.00, 250);

INSERT INTO dbo.Enrolments (ParticipantId, CategoryId, BibNumber, Status) VALUES
(3, 2, 101, 'Active'), (4, 1, 55, 'Active'), (5, 3, 201, 'Active'), (3, 5, 20, 'Active');

INSERT INTO dbo.Payments (EnrolmentId, Amount, PaymentReference, PaymentStatus, PaidAt) VALUES
(1, 220.00, N'RD-2026-0001', 'Paid', '2026-09-01T10:00:00'),
(2, 120.00, N'RD-2026-0002', 'Paid', '2026-09-01T10:05:00'),
(3, 280.00, N'RD-2026-0003', 'Paid', '2026-09-01T10:10:00'),
(4, 80.00, N'RD-2026-0004', 'Pending', NULL);
GO
