--=========================================================
--------------Create Database that commit for github ---------------------------
--=========================================================
Create Database SmartClinicTest
go 
use SmartClinicTest
go 
--=========================================================
--------------Create Tables ---------------------------
--=========================================================
Create table TbEmployees
(
EmployeesID int primary key identity(1,1),
BirthDate date,
Gender nvarchar(20),
BaseSalary decimal(9,2),
BankName nvarchar(50),
BankAccount nvarchar(50),
Flag char(1) default 'A',
NationalID varchar(15) ,
JobTitleID int ,
DepartmentID int , 
StaffID int , 
DoctorID int ,
WorkTimeID int
)
Go 
Create table TbJobTitles
(
JobTitleID int primary key identity(1,1),
Title nvarchar(150),
Flag char(1) default 'A'
)
go 
Create table TbDepartments
(
DepartmentID int primary key identity(1,1),
DepartmentName nvarchar(150),
Flag char(1) default 'A'
)
go
Create table TbStaffs
(
StaffID int primary key identity(1,1),
StaffName nvarchar(50),
Flag char(1) default 'A'
)
go
Create table TbDoctors
(
DoctorID int primary key identity(1,1),
DoctorName nvarchar(50),
Flag char(1) default 'A'
)
go 
--=========================================================
--------------Constraint Foreign Keys ---------------------
--=========================================================
Alter table TbEmployees
add constraint fk_TbEmployees_TbJobtitle  foreign key (JobTitleID) references TbJobTitles(JobTitleID)
go 
Alter table TbEmployees
add constraint fk_TbEmployees_TbDepartments foreign key (DepartmentID) references TbDepartments(DepartmentID)
go 
Alter table TbEmployees
add constraint fk_TbEmployees_TbStaffs foreign key (StaffID) references TbStaffs(StaffID)
go 
Alter table TbEmployees 
add constraint fk_TbEmployees_TbDoctors foreign key (DoctorID) references TbDoctors(DoctorID)
go 

--add foregin key for workTime
Alter table TbEmployees
add constraint fk_TbEmployees_TbWorkTimes  foreign key (WorkTimeID) references TbWorkTimes(ID)


--====================================
-------------TbContactTypes-----------
--====================================

CREATE TABLE TbContactTypes(
    ContactTypeID INT IDENTITY(1,1) NOT NULL,
    ContactType NVARCHAR(100) NOT NULL,
    ContactConstraint NVARCHAR(500) NOT NULL,
    Flag CHAR(1) NOT NULL
    -----------------------------------------
    CONSTRAINT PK_TbContactTypes PRIMARY KEY (ContactTypeID)
)
GO


--====================================
-------------TbContacts---------------
--====================================

CREATE TABLE TbContacts (
    ContactID INT IDENTITY(1,1) NOT NULL,
    Contact NVARCHAR(150) NOT NULL,
    TypeOfEmployee NVARCHAR(100) NOT NULL,
    ForeignKey INT NOT NULL,
    ContactTypeID INT NOT NULL,
    Flag CHAR(1) NOT NULL
    -------------------------------------------
    CONSTRAINT PK_TbContacts PRIMARY KEY (ContactID),
    CONSTRAINT FK_TbContacts_TbContactType FOREIGN KEY (ContactTypeID) REFERENCES TbContactTypes(ContactTypeID)
)
GO


--====================================
-------------TbSalaryTypes------------
--====================================

-- CREATE TABLE TbSalaryTypes(
--     ID INT IDENTITY(1,1) NOT NULL,
--     SalaryType NVARCHAR(150) NOT NULL,
--     Flag CHAR(1) NOT NULL
--     -----------------------------------
--     CONSTRAINT PK_TbSalaryTypes PRIMARY KEY(ID)
-- )
-- GO

--====================================
-------------TbSalaries-----------------
--====================================

CREATE TABLE TbSalaries (
    SalaryID INT IDENTITY(1,1) NOT NULL, 
    Tax DECIMAL(9,2) NOT NULL,
    Insurance DECIMAL(9,2) DEFAULT 0,
    ComeLate DECIMAL(9,2) DEFAULT 0,
    LeaveEarly DECIMAL(9,2) DEFAULT 0,
    Absent DECIMAL(9,2) DEFAULT 0,
    Vacations DECIMAL(9,2) DEFAULT 0,
    Overtime DECIMAL(9,2) DEFAULT 0,
    Note NVARCHAR(MAX),
    Flag CHAR(1) NOT NULL,
    -------------Foreign keys---------
    EmployeeID INT NOT NULL,
    SalaryTypeID INT NOT NULL
    ------------------------------------
    CONSTRAINT PK_TbSalary PRIMARY KEY(SalaryID),
    -- CONSTRAINT FK_TbSalary_TbSalaryTypes FOREIGN KEY(SalaryTypeID) REFERENCES TbSalaryTypes(ID),
    CONSTRAINT FK_TbSalary_TbEmployees FOREIGN KEY(EmployeeID) REFERENCES TbEmployees(EmployeeID) 
)
GO

--====================================
-------------TbRewardTypes------------
--====================================

CREATE TABLE TbRewardTypes(
    RewardTypeID INT IDENTITY(1,1) NOT NULL,
    RewardType NVARCHAR(200) NOT NULL,
    --Defualt quantity for type of reward
    DefualtQuantity DECIMAL(9,2),
    Flag CHAR(1) NOT NULL
    -----------------------------------
    CONSTRAINT PK_TbRewardTypes PRIMARY KEY(RewardTypeID)
)

--====================================
-------------TbRewards----------------
--====================================

CREATE TABLE TbRewards (
    RewardID INT IDENTITY(1,1) NOT NULL,
    Quantity DECIMAL(9,2) NOT NULL,
    Description NVARCHAR(MAX),
    Flag CHAR(1) NOT NULL,
    ----------Foreign Keys----------
    SalaryID INT NOT NULL,
    RewardTypeID INT NOT NULL
    -----------------------------------
    CONSTRAINT PK_TbRewards PRIMARY KEY(RewardID),
    CONSTRAINT FK_TbRewards_TbSalaries FOREIGN KEY(SalaryID) REFERENCES TbSalaries(SalaryID),
    CONSTRAINT FK_TbRewards_TbRewardTypes FOREIGN KEY(RewardTypeID) REFERENCES TbRewardTypes(RewardTypeID) 
)


GO
--====================================
-------------TbAttendaceDays-----------
--====================================

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TbAttendaceDays](
	[AttendaceDaysID] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_TbAttendaceDay] PRIMARY KEY CLUSTERED 
(
	[AttendaceDaysID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TbAttendaceDays] ADD  CONSTRAINT [DF_TbAttendaceDays_Flag]  DEFAULT ('A') FOR [Flag]
GO

--====================================
-------------TbVacationTypes-----------
--====================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TbVacationTypes](
	[VacationTypesID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_TbVacationType] PRIMARY KEY CLUSTERED 
(
	[VacationTypesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TbVacationTypes] ADD  CONSTRAINT [DF_TbVacationTypes_Flag]  DEFAULT ('A') FOR [Flag]
GO


--====================================
-------------TbAttendances-----------
--====================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TbAttendances](
	[AttendancesID] [int] IDENTITY(1,1) NOT NULL,
	[AttendDayID] [int] NULL,
	[EmployeeID] [int] NULL,
	[From] [datetime] NULL,
	[TO] [datetime] NULL,
	[Lateness] [int] NULL,
	[LeaveEarly] [int] NULL,
	[OverTime] [int] NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_TbAttendance] PRIMARY KEY CLUSTERED 
(
	[AttendancesID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TbAttendances] ADD  CONSTRAINT [DF_TbAttendances_Flag]  DEFAULT ('A') FOR [Flag]
GO

ALTER TABLE [dbo].[TbAttendances]  WITH CHECK ADD  CONSTRAINT [FK_TbAttendance_TbAttendaceDay] FOREIGN KEY([AttendDayID])
REFERENCES [dbo].[TbAttendaceDays] ([ID])
GO

ALTER TABLE [dbo].[TbAttendances] CHECK CONSTRAINT [FK_TbAttendance_TbAttendaceDay]
GO

--====================================
-------------TbEmployeeVacations-----------
--====================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TbEmployeeVacations](
	[EmployeeVacationID] [int] IDENTITY(1,1) NOT NULL,
	[Vtype] [int] NULL,
	[Days] [int] NULL,
	[EmployeeID] [int] NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_TbEmployeeVacation] PRIMARY KEY CLUSTERED 
(
	[EmployeeVacationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TbEmployeeVacations] ADD  CONSTRAINT [DF_TbEmployeeVacations_Flag]  DEFAULT ('A') FOR [Flag]
GO

ALTER TABLE [dbo].[TbEmployeeVacations]  WITH CHECK ADD  CONSTRAINT [FK_TbEmployeeVacation_TbVacationType] FOREIGN KEY([Vtype])
REFERENCES [dbo].[TbVacationTypes] ([ID])
GO

ALTER TABLE [dbo].[TbEmployeeVacations] CHECK CONSTRAINT [FK_TbEmployeeVacation_TbVacationType]
GO


--====================================
-------------TbTakeVacations-----------
--====================================
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[TbTakeVacations](
	[TakeVacationsID] [int] IDENTITY(1,1) NOT NULL,
	[DateTacked] [date] NULL,
	[EmployeeVacationID] [int] NULL,
	[Flag] [char](1) NULL,
 CONSTRAINT [PK_TbTakeVacation] PRIMARY KEY CLUSTERED 
(
	[TakeVacationsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TbTakeVacations] ADD  CONSTRAINT [DF_TbTakeVacations_Flag]  DEFAULT ('A') FOR [Flag]
GO
/*
-----------------------
ReadME!
I remove FK form TakeVacation form VacationType
and I Add Fk for EmployeeTable
-----------------------
*/
--ALTER TABLE [dbo].[TbTakeVacations]  WITH CHECK ADD  CONSTRAINT [FK_TbTakeVacation_Tb] FOREIGN KEY([VacationTypeID])
--REFERENCES [dbo].[TbVacationTypes] ([ID])
--GO

ALTER TABLE [dbo].[TbTakeVacations]  WITH CHECK ADD  CONSTRAINT [FK_TbEmployeeVacation_Tb] FOREIGN KEY([EmployeeVacationID])
REFERENCES [dbo].[TbEmployeeVacations] ([ID])



--ALTER TABLE [dbo].[TbTakeVacations] CHECK CONSTRAINT [FK_TbTakeVacation_TbVacationType]
--GO
--====================================
-------------TbWorkTimes-----------
--====================================
create table [dbo].[TbWorkTimes]
(WorkTimeID int  identity(1,1) not null,
StartTime time,
LeaveTime time,
StaffName nvarchar(50),
Flag char(1) default 'A',
 CONSTRAINT [PK_TbWorkTimes] PRIMARY KEY CLUSTERED 
(
	[WorkTimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
--====================================
-------------TbFixedVacations-----------
--====================================
create table [dbo].[TbFixedVacations]
(
FixedVacationID int identity(1,1) not null,
FixedVacationName nvarchar(50),
[From] datetime,
[To] datetime,
Flag char(1) default 'A',

 CONSTRAINT [PK_TbFixedVacations] PRIMARY KEY CLUSTERED 
(
	FixedVacationID ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
Go


/*=================================================================================
								TbContactTypes proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_ContactTypesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbContactTypes WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO

-------------Read By Id Store Procedure-----------------------
CREATE PROCEDURE Sp_ContactTypesReadByID 
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbContactTypes WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbContactTypes WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------Insert Store Procedure--------------
CREATE PROCEDURE Sp_ContactTypesInsert 
@ContactType NVARCHAR(100),
@Flag CHAR(1) = 'A',
@ContactConstraint NVARCHAR(500),
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
	BEGIN TRANSACTION
        --make sure the value not exist
        IF NOT EXISTS(SELECT ContactType FROM TbContactTypes WHERE ContactType LIKE @ContactType)
            BEGIN
                --Make sure the value not empty or null
                IF @ContactType NOT IN('', ' ', NULL)
                    BEGIN
                        INSERT INTO TbContactTypes (ContactType, ContactConstraint,Flag) VALUES (@ContactType, @ContactConstraint,@Flag)
                        SELECT @Message = 1
                    END
                ELSE
                    BEGIN
                        SElECT @Message = 0
                    END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH
GO

-------Update Store Procedure---------------
CREATE PROCEDURE Sp_ContactTypesUpdate 
@Id int, 
@ContactType NVARCHAR(100),
@ContactConstraint NVARCHAR(500),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbContactTypes WHERE ID = @Id AND Flag NOT LIKE 'D')
            BEGIN
                IF @ContactType NOT IN('', ' ', NULL)
                    BEGIN
                        UPDATE TbContactTypes SET ContactType = @ContactType, ContactConstraint = @ContactConstraint,Flag = @Flag WHERE ID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

---------Detele Store Procedure------------
CREATE PROCEDURE Sp_ContactTypesDelete 
@Id INT,
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbContactTypes WHERE ID = @Id AND Flag NOT LIKE 'D')
                BEGIN
                    UPDATE TbContactTypes SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH


GO


/*=================================================================================
								TbContacts proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_ContactsReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbContacts WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH

GO

-------------Read By Id Store Procedure-----------------------
CREATE PROCEDURE Sp_ContactsReadByID 
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbContacts WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbContacts WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------Insert Store Procedure--------------
CREATE PROCEDURE Sp_ContactsInsert 
@Contact NVARCHAR(150), 
@TypeOfEmployee NVARCHAR(100), 
@ForeignKey INT,
@ContactTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
	BEGIN TRANSACTION
        --make sure the value not exist
        IF NOT EXISTS(SELECT Contact FROM TbContacts WHERE Contact LIKE @Contact)
            BEGIN
                --Make sure the value not empty or null
                IF @Contact NOT IN('', ' ', NULL) AND @TypeOfEmployee NOT IN('', ' ', NULL) AND @ForeignKey > 0 AND @ContactTypeID > 0
                    BEGIN
                        INSERT INTO TbContacts (Contact, TypeOfEmployee, ForeignKey, Flag, ContactTypeID) VALUES (@Contact, @TypeOfEmployee, @ForeignKey, @Flag, @ContactTypeID)
                        SELECT @Message = 1
                    END
                ELSE
                    BEGIN
                        SElECT @Message = 0
                    END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------Update Store Procedure----------------
CREATE PROCEDURE Sp_ContactsUpdate 
@Id INT, 
@Contact NVARCHAR(150), 
@TypeOfEmployee NVARCHAR(100), 
@ForeignKey INT, 
@ContactTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbContacts WHERE ID = @Id AND Flag NOT LIKE 'D')
            BEGIN
                IF @Contact NOT IN('', ' ', NULL) AND @TypeOfEmployee NOT IN('', ' ', NULL) AND @ForeignKey > 0 AND @ContactTypeID > 0
                    BEGIN
                        UPDATE TbContacts SET Contact = @Contact, TypeOfEmployee = @TypeOfEmployee, ForeignKey = @ForeignKey, Flag = @Flag, ContactTypeID = @ContactTypeID WHERE ID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------Delete Store Procedure----------------
CREATE PROCEDURE Sp_ContactsDelete 
@Id INT, 
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbContacts WHERE ID = @Id AND Flag NOT LIKE 'D')
                BEGIN
                    UPDATE TbContacts SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO


/*=================================================================================
								TbSalaryTypes proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
-- CREATE PROCEDURE Sp_SalaryTypesReadAll 
-- @Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
-- AS
-- BEGIN TRY
--     SELECT * FROM TbSalaryTypes WHERE Flag NOT LIKE 'D'
--     SELECT @Message = 1 
-- END TRY 
-- BEGIN CATCH
--     IF @@ERROR <> 0
--         BEGIN
--             SELECT @Message = 3
--             PRINT ERROR_MESSAGE()  
--         END
-- END CATCH

-- GO

-- -------------Read By Id Store Procedure-----------------------
-- CREATE PROCEDURE Sp_SalaryTypesReadByID 
-- @Id INT,
-- @Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
-- AS
-- BEGIN TRY
--     IF EXISTS (SELECT ID FROM TbSalaryTypes WHERE ID = @Id)
--         BEGIN
--             SELECT * FROM TbSalaryTypes WHERE ID = @Id AND Flag NOT LIKE 'D'
--             SELECT @Message = 1 
--         END
--     ELSE
--         BEGIN
--             SELECT @Message = 0
--         END
-- END TRY
-- BEGIN CATCH
-- 	IF @@ERROR <> 0
-- 		BEGIN
-- 			SELECT @Message = 3
-- 			PRINT ERROR_MESSAGE()
-- 		END
-- END CATCH

-- GO

-- ----------------Insert Store Procedure------------------------
-- CREATE PROCEDURE Sp_SalaryTypesInsert 
-- @SalaryType NVARCHAR(150),
-- @Flag CHAR(1) = 'A',
-- @Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
-- AS
-- BEGIN TRY
-- 	BEGIN TRANSACTION
--         --make sure the value not exist
--         IF NOT EXISTS(SELECT SalaryType FROM TbSalaryTypes WHERE SalaryType LIKE @SalaryType)
--             BEGIN
--                 --Make sure the value not empty or null
--                 IF @SalaryType NOT IN('', ' ', NULL)
--                     BEGIN
--                         INSERT INTO TbSalaryTypes (SalaryType, Flag) VALUES (@SalaryType, @Flag)
--                         SELECT @Message = 1
--                     END
--                 ELSE
--                     BEGIN
--                         SElECT @Message = 0
--                     END
--             END
--         ELSE
--             BEGIN
--                 SELECT @Message = 2
--             END
-- END TRY
-- BEGIN CATCH
-- 	IF @@ERROR <> 0
-- 		BEGIN
-- 			ROLLBACK TRANSACTION
-- 			SELECT @Message = 3
-- 			PRINT ERROR_MESSAGE()
-- 		END
-- END CATCH

-- GO

-- ----------------Update Store Procedure--------------------------
-- CREATE PROCEDURE Sp_SalaryTypesUpdate 
-- @Id INT, 
-- @SalaryType NVARCHAR(150),
-- @Flag CHAR(1) = 'A',
-- @Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
-- AS
-- BEGIN TRY
--     BEGIN TRANSACTION
--         IF EXISTS (SELECT ID FROM TbSalaryTypes WHERE ID = @Id AND Flag NOT LIKE 'D')
--             BEGIN
--                 IF @SalaryType NOT IN('', ' ', NULL)
--                     BEGIN
--                         UPDATE TbSalaryTypes SET SalaryType = @SalaryType, Flag = @Flag WHERE ID = @Id
--                         SELECT @Message = 1
--                     END
--                 ELSE
--                 BEGIN
--                     SELECT @Message = 0
--                 END
--             END
--         ELSE
--         BEGIN
--             SELECT @Message = 2
--         END
--     COMMIT TRANSACTION
-- END TRY
-- BEGIN CATCH
-- 	IF @@ERROR <> 0
-- 		BEGIN
-- 			ROLLBACK TRANSACTION
-- 			SELECT @Message = 3
-- 			PRINT ERROR_MESSAGE()
-- 		END
-- END CATCH

-- GO

-- ----------------DELETE Store Procedure---------------------
-- CREATE PROCEDURE Sp_SalaryTpyesDelete 
-- @Id INT, 
-- @Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
-- AS
-- BEGIN TRY
--     BEGIN TRANSACTION
--             IF EXISTS (SELECT ID FROM TbSalaryTypes WHERE ID = @Id AND Flag NOT LIKE 'D') 
--                 BEGIN
--                     UPDATE TbSalaryTypes SET Flag = 'D' WHERE ID = @Id   
--                     SELECT @Message = 1
--                 END
--             ELSE
--                 BEGIN
--                     SELECT @Message = 2
--                 END
--     COMMIT TRANSACTION
-- END TRY
-- BEGIN CATCH
-- 	IF @@ERROR <> 0
-- 		BEGIN
-- 			ROLLBACK TRANSACTION
-- 			SELECT @Message = 3
-- 			PRINT ERROR_MESSAGE()
-- 		END
-- END CATCH

-- GO

/*=================================================================================
								TbSalaries proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_SalariesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbSalaries WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1 
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO


-------------Read By ID Store Procedure-----------------------
CREATE PROCEDURE Sp_SalariesReadByID 
@Id INT, 
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbSalaries WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbSalaries WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO


----------------Insert Store Procedure------------------------
CREATE PROCEDURE Sp_SalariesInsert 
@Tax DECIMAL(9,2), 
@Insurance DECIMAL(9,2), 
@ComeLate DECIMAL(9,2), 
@LeaveEarly DECIMAL(9,2), 
@Absent DECIMAL(9,2), 
@Vacations DECIMAL(9,2), 
@Overtime DECIMAL(9,2), 
@Note NVARCHAR(MAX), 
@EmployeeID INT, 
@SalaryTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
	BEGIN TRANSACTION
        --Make sure the value not empty or null
        IF @Tax > 0 AND @Insurance > 0 AND @ComeLate > 0 AND @LeaveEarly > 0 AND @Absent > 0 AND @vacations > 0 AND @Overtime > 0 AND @Note NOT IN('', ' ', NULL) AND @EmployeeID > 0 AND @SalaryTypeID > 0
            BEGIN
                INSERT INTO TbSalaries (Tax, Insurance, ComeLate, LeaveEarly, Absent, Vacations, Overtime, Note, Flag, EmployeeID, SalaryTypeID)
                VALUES
                (@Tax, @Insurance, @ComeLate, @LeaveEarly, @Absent, @Vacations, @Overtime, @Note, @Flag, @EmployeeID, @SalaryTypeID)
                SELECT @Message = 1
            END
        ELSE
            BEGIN
                SElECT @Message = 0
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

---------------Update Store Procedure---------------------------
CREATE PROCEDURE Sp_SalariesUpdate 
@Id INT, 
@Tax DECIMAL(9,2), 
@Insurance DECIMAL(9,2), 
@ComeLate DECIMAL(9,2), 
@LeaveEarly DECIMAL(9,2), 
@Absent DECIMAL(9,2), 
@Vacations DECIMAL(9,2), 
@Overtime DECIMAL(9,2), 
@Note NVARCHAR(MAX), 
@EmployeeID INT, 
@SalaryTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbSalaries WHERE ID = @Id AND Flag NOT LIKE 'D')
            BEGIN
                IF @Tax > 0 AND @Insurance > 0 AND @ComeLate > 0 AND @LeaveEarly > 0 AND @Absent > 0 AND @vacations > 0 AND @Overtime > 0 AND @Note NOT IN('', ' ', NULL) AND @EmployeeID > 0 AND @SalaryTypeID > 0
                    BEGIN
                        UPDATE TbSalaries SET 
                        Tax = @Tax, Insurance = @Insurance, ComeLate = @ComeLate, LeaveEarly = @LeaveEarly, Absent = @Absent, Vacations = @Vacations, Note = @Note, Flag = @Flag, EmployeeID = @EmployeeID, SalaryTypeID = @SalaryTypeID
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------------Delete Store Procedure----------------------
CREATE PROCEDURE Sp_SalariesDelete 
@Id INT, 
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbSalaries WHERE ID = @Id AND Flag NOT LIKE 'D')
                BEGIN
                    UPDATE TbSalaries SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO


/*=================================================================================
								TbRewardTypes proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_RewardTypesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbRewardTypes WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH


GO

-------------Read By ID Store Procedure-----------------------
CREATE PROCEDURE Sp_RewardTypesReadByID 
@Id INT, 
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbRewardTypes WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbRewardTypes WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

----------------Insert Store Procedure------------------------
CREATE PROCEDURE Sp_RewardTypesInsert 
@RewardType NVARCHAR(200),
@DefualtQuantity DECIMAL(9,2),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
	BEGIN TRANSACTION
        --make sure the value not exist
        IF NOT EXISTS(SELECT RewardType FROM TbRewardTypes WHERE RewardType LIKE @RewardType)
            BEGIN
                --Make sure the value not empty or null
                IF @RewardType NOT IN('', ' ', NULL)
                    BEGIN
                        INSERT INTO TbRewardTypes (RewardType, DefualtQuantity,Flag) VALUES (@RewardType, @DefualtQuantity,@Flag)
                        SELECT @Message = 1
                    END
                ELSE
                    BEGIN
                        SElECT @Message = 0
                    END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO
--------------Update Store Procedure-------------------------
CREATE PROCEDURE Sp_RewardTypesUpdate 
@Id INT, 
@RewardType NVARCHAR(200),
@DefualtQuantity DECIMAL(9,2),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbRewardTypes WHERE ID = @Id AND Flag NOT LIKE 'D')
            BEGIN
                IF (@RewardType NOT IN('', ' ', NULL))
                    BEGIN
                        UPDATE TbRewardTypes SET RewardType = @RewardType, DefualtQuantity = @DefualtQuantity, Flag = @Flag WHERE ID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-----------Delete Store Procedure-------------------------
CREATE PROCEDURE Sp_RewardTypesDelete 
@Id INT,
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbRewardTypes WHERE ID = @Id AND Flag NOT LIKE 'D')
                BEGIN
                    UPDATE TbRewardTypes SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO


/*=================================================================================
								TbRewards proc
===================================================================================*/
CREATE PROCEDURE Sp_RewardsReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbRewards WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH

GO

-------------Read By ID Store Procedure-----------------------
CREATE PROCEDURE Sp_RewardsReadByID
@Id INT, 
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbRewards WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbRewards WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH


GO

----------------Insert Store Procedure------------------------
CREATE PROCEDURE Sp_RewardsInsert 
@Quantity DECIMAL(9,2), 
@Description NVARCHAR(MAX), 
@SalaryID INT, 
@RewardTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 3 -> ERROR
AS
BEGIN TRY
	BEGIN TRANSACTION
    
        --Make sure the value not empty or null
        IF @Quantity > 0 AND @SalaryID > 0 AND @RewardTypeID > 0
            BEGIN
                INSERT INTO TbRewards (Quantity, [Description], SalaryID, Flag,RewardTypeID) VALUES (@Quantity, @Description, @SalaryID, @Flag,@RewardTypeID)
                SELECT @Message = 1
            END
        ELSE
            BEGIN
                SElECT @Message = 0
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

-------------Update Store Procedure-------------------------
CREATE PROCEDURE Sp_RewardsUpdate 
@Id INT, 
@Quantity DECIMAL(9,2), 
@Description NVARCHAR(MAX), 
@SalaryID INT, 
@RewardTypeID INT,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbRewards WHERE ID = @Id AND Flag NOT LIKE 'D')
            BEGIN
                IF @Quantity > 0 AND @SalaryID > 0 AND @RewardTypeID > 0
                    BEGIN
                        UPDATE TbRewards SET Quantity = @Quantity, [Description] = @Description, SalaryID = @SalaryID, RewardTypeID = @RewardTypeID, Flag = @Flag
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO

----------Delete Store Procedure------------------------------
CREATE PROCEDURE Sp_RewardsDelete 
@Id INT,
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbRewards WHERE ID = @Id AND Flag NOT LIKE 'D')
                BEGIN
                    UPDATE TbRewards SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH

GO
-------------Read all Store Procedure-----------------------
 
CREATE PROCEDURE Sp_TbContactTypesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbDepartments WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO
-------------Read By Id Store Procedure-----------------------
Create PROCEDURE Sp_DepartmentsReadByID 
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbDepartments WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbDepartments WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO
-------Insert Store Procedure--------------
CREATE PROCEDURE TbDepartmentsInsert 
@DepartmentName NVARCHAR(100),
@Flag CHAR(1),
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
        --make sure the value not exist
        IF NOT EXISTS(SELECT DepartmentName FROM TbDepartments WHERE DepartmentName LIKE @DepartmentName)
            BEGIN
                --Make sure the value not empty or null
                IF @DepartmentName NOT IN('', ' ', NULL)
                    BEGIN
                        INSERT INTO TbDepartments (DepartmentName, Flag) VALUES (@DepartmentName, @Flag)
                        SELECT @Message = 1
                    END
                ELSE
                    BEGIN
                        SElECT @Message = 0
                    END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
-------Update Store Procedure---------------
CREATE PROCEDURE Sp_DepartmentsUpdate 
@Id int, 
@DepartmentName NVARCHAR(100),
@Flag CHAR(1),
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbDepartments WHERE ID = @Id)
            BEGIN
                IF (@DepartmentName NOT IN('', ' ', NULL))
                    BEGIN
                        UPDATE TbDepartments SET DepartmentName = @DepartmentName, Flag = @Flag WHERE ID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO
---------Detele Store Procedure------------
CREATE PROCEDURE TbDepartmentsDelete 
@Id INT,
@Message TINYINT OUT
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbDepartments WHERE ID = @Id)
                BEGIN
                    UPDATE TbDepartments SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH


GO
--Insert Doctors
Create proc [dbo].[sp_InsertDoctors]
@DoctorName nvarchar(150),
@DateOfBirth date, 
@Gender nvarchar(20),
@BaseSalary decimal(9,2),
@BankName nvarchar(50),
@BankAccount nvarchar(50),
@JobTitleID int , 
@DepartmentID int ,
@NationalID varchar(15),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT
as 
begin try
begin transaction 
if not exists(Select *  from TbDoctors as st inner join TbEmployees as tb on st.ID =tb.DoctorID where NationalID=@NationalID and st.DoctorName =@DoctorName )
begin 
			if @DoctorName  is not null and 
			@NationalID is not null and 
			@Gender is not null and 
			@DateOfBirth is not null and 
			@BaseSalary is not null and 
			@DepartmentID is not null and 
			@JobTitleID is not null
			begin

			Insert into TbDoctors(DoctorName)  VALUES(@DoctorName);
			declare @DoctorID as int;
			set @DoctorID =IDENT_CURRENT('TbDoctors');
			Insert into TbEmployees (BankAccount,BankName,BaseSalary,BirthDate,DepartmentID,Gender,JobTitleID,NationalID,DoctorID,Flag)
			values(@BankAccount,@BankName,@BaseSalary,@DateOfBirth,@DepartmentID,@Gender,@JobTitleID,@NationalID,@DoctorID,@Flag);
			Select @Message =1;
			end 

			else
			begin 
			Select @Message =0;
			end 
end 
else 
begin 
    SElECT @Message = 0
end 
commit transaction
end try

begin catch 
rollback transaction
end catch
GO

---------------------------------------------------------------------------------------
--Edit or Update Doctor
Create proc [dbo].[Sp_DoctorsEdit] 
@DoctorID int,
@DoctorName nvarchar(150),
@DateOfBirth date, 
@Gender nvarchar(20),
@BaseSalary decimal(9,2),
@BankName nvarchar(50),
@BankAccount nvarchar(50),
@NationalID varchar(15),
@JobTitleID int , 
@DepartmentID int,
@Flag CHAR(1),
@Message TINYINT OUT
as 
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbStaffs WHERE ID = @DoctorID)
            BEGIN
                IF @DoctorName is not null and 
				   @BankAccount  is not null and 
				   @BankName is not null and 
				   @BankAccount is not null and 
				   @JobTitleID is not Null and 
				   @DepartmentID is not Null and 
				   @Gender is not null and 
				   @DateOfBirth is not null 
				   
                    BEGIN
                        UPDATE TbDoctors SET DoctorName =@DoctorName  where ID =@DoctorID
						Update TbEmployees set BankAccount =@BankAccount , BankName =@BankName,
						BaseSalary =@BaseSalary , BirthDate=@DateOfBirth, DepartmentID =@DepartmentID,
						Gender = @Gender ,NationalID =@NationalID, Flag = @Flag where DoctorID =@DoctorID

                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
----------------------------------------------------------------------------------------------------
--Reall All
Create PROCEDURE dbo.Sp_DoctorReadAll
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbDoctors as dc inner join TbEmployees emp
	on dc.ID = emp.ID
	 WHERE dc.Flag NOT LIKE 'D'
	
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
end catch
GO
-------------------------------------------------------------------
--read by ID
Create PROCEDURE Sp_DoctorssReadByID 
@Id INT,
@Message TINYINT OUT
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbDoctors WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbDoctors WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END  catch
--------------------------------------------------------------
--delete Doctor
GO

Create PROCEDURE [dbo].[Sp_DoctorsDelete] 
@Id INT,
@Flag CHAR(1),
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbDoctors WHERE ID = @Id)
                BEGIN
                    UPDATE TbDoctors SET Flag = @Flag WHERE ID = @Id 
					Update TbEmployees Set Flag = @Flag where DoctorID =@Id  
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
--Insert
Create proc [dbo].[Sp_StaffsInsert] 
@StaffName nvarchar(150),
@DateOfBirth date, 
@Gender nvarchar(20),
@BaseSalary decimal(9,2),
@BankName nvarchar(50),
@BankAccount nvarchar(50),
@JobTitleID int , 
@DepartmentID int ,
@NationalID varchar(15),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT
as 
begin try
begin transaction 
if not exists(Select *  from TbStaffs as st inner join TbEmployees as tb on st.ID =tb.StaffID where NationalID=@NationalID and st.StaffName =@StaffName )
begin 
			if @StaffName is not null and 
			@NationalID is not null and 
			@Gender is not null and 
			@DateOfBirth is not null and 
			@BaseSalary is not null and 
			@DepartmentID is not null and 
			@JobTitleID is not null
			begin

			Insert into TbStaffs (StaffName)  VALUES(@StaffName);
			declare @StaffID as int;
			set @StaffID =IDENT_CURRENT('TbStaffs');
			Insert into TbEmployees (BankAccount,BankName,BaseSalary,BirthDate,DepartmentID,Gender,JobTitleID,NationalID,StaffID,Flag)
			values(@BankAccount,@BankName,@BaseSalary,@DateOfBirth,@DepartmentID,@Gender,@JobTitleID,@NationalID,@StaffID,@Flag);
			Select @Message =1;
			end 

			else
			begin 
			Select @Message =0;
			end 
end 
else 
begin 
    SElECT @Message = 0
end 
commit transaction
end try

begin catch 
rollback transaction
end catch
GO  
-----------------------------------------------------------------------
--Edit Update
Create proc [dbo].[Sp_StaffEdit] 
@StaffID int,
@StaffName nvarchar(150),
@DateOfBirth date, 
@Gender nvarchar(20),
@BaseSalary decimal(9,2),
@BankName nvarchar(50),
@BankAccount nvarchar(50),
@NationalID varchar(15),
@JobTitleID int , 
@DepartmentID int,
@Flag CHAR(1) = 'A',
@Message TINYINT OUT
as 
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbStaffs WHERE ID = @StaffID)
            BEGIN
                IF @StaffID is not null and 
				   @BankAccount  is not null and 
				   @BankName is not null and 
				   @BankAccount is not null and 
				   @JobTitleID is not Null and 
				   @DepartmentID is not Null and 
				   @Gender is not null and 
				   @DateOfBirth is not null 
				   
                    BEGIN
                        UPDATE TbStaffs SET StaffName =@StaffName  where ID =@StaffID
						Update TbEmployees set BankAccount =@BankAccount , BankName =@BankName,
						BaseSalary =@BaseSalary , BirthDate=@DateOfBirth, DepartmentID =@DepartmentID,
						Gender = @Gender ,NationalID =@NationalID, Flag = @Flag where StaffID =@StaffID

                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
-----------------------------------------------------------------------------------
--read all
Create PROCEDURE [dbo].[Sp_StaffsReadAll] 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbStaffs as st inner join TbEmployees emp
	on st.ID = emp.ID
	 WHERE st.Flag NOT LIKE 'D'
	
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
end CATCH
GO
------------------------------------------------------------------------------------
--Read by ID
Create PROCEDURE [dbo].[Sp_StaffsReadByID] 
@Id INT,
@Message TINYINT OUT
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbStaffs WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbStaffs WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
-----------------------------------------------------------------------------
GO
Create PROCEDURE [dbo].[Sp_StaffsDelete] 
@Id INT,
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbStaffs WHERE ID = @Id)
                BEGIN
                    UPDATE TbStaffs SET Flag = 'D' WHERE ID = @Id 
					Update TbEmployees Set Flag = 'D' where StaffID =@Id  
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
------------------------------------------------------------------------------
--ReadAll JobTitels
Create PROCEDURE Sp_JobTitlesReadAll 
@Message TINYINT OUT 
AS
BEGIN TRY
    SELECT * FROM TbJobTitles WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO
-----------------------------------------------------------------------------
--read by ID
CREATE PROCEDURE JobTitleReadByID 
@Id INT,
@Message TINYINT OUT
AS
BEGIN TRY
    IF EXISTS (SELECT ID FROM TbJobTitles WHERE ID = @Id)
        BEGIN
            SELECT * FROM TbJobTitles WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
------------------------------------------------------------------------------------
--Insert JobTitle (there is an issue and you will know it because you used   something like this IF @Title NOT IN('', ' ', NULL))
CREATE PROCEDURE Sp_JobTitlesInsert 
@Title NVARCHAR(100),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT  --0 -> NULL VALUE, 1 -> ADDED, 2 -> EXISTS, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
        --make sure the value not exist
        IF NOT EXISTS(SELECT * FROM TbJobTitles WHERE Title LIKE @Title)
            BEGIN
                --Make sure the value not empty or null
                IF @Title NOT IN('', ' ', NULL)
                    BEGIN
                        INSERT INTO TbJobTitles(Title, Flag) VALUES (@Title, @Flag)
                        SELECT @Message = 1
                    END
                ELSE
                    BEGIN
                        SElECT @Message = 0
                    END
            END
        ELSE
            BEGIN
                SELECT @Message = 2
            END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO
-----------------------------------------------------------------------------
--Update Stored Procedure
CREATE PROCEDURE Sp_JobTitlesUpdate 
@Id int, 
@Title NVARCHAR(100),
@Flag CHAR(1) = 'A',
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT ID FROM TbJobTitles WHERE ID = @Id)
            BEGIN
                IF (@Title NOT IN('', ' ', NULL))
                    BEGIN
                        UPDATE TbJobTitles SET Title = @Title, Flag = @Flag WHERE ID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH
GO
--------------------------------------------------------------------------------------
--Delete 

CREATE PROCEDURE Sp_JobTitlesDelete 
@Id INT,
@Message TINYINT OUT 
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT ID FROM TbJobTitles WHERE ID = @Id)
                BEGIN
                    UPDATE TbJobTitles SET Flag = 'D' WHERE ID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
    COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
end Catch
GO

/*=================================================================================
								TbAttendances proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_AttendancesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
SELECT * FROM TbAttendances
    SELECT * FROM TbAttendances WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO
-------------Read By Id Store Procedure-----------------------
CREATE PROCEDURE Sp_AttendancesReadByID 
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT AttendDayID FROM TbAttendances WHERE AttendDayID = @Id)
        BEGIN
            SELECT * FROM TbAttendances WHERE ID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO

-------Insert Store Procedure--------------
CREATE PROCEDURE Sp_AttendancesInsert
@Message TINYINT OUT,--> 0 ==> NULL VALUE, 1 ==> ADDED, 2 ==> EXISTS, 3 ==> ERROR
@AttendDayID INT,
@EmployeeID INt,
@From datetime,
@To Datetime,
@Latenees int,
@LeaveEarly int,
@OverTime int,
@Flag CHAR(1) = 'A'
AS
BEGIN TRY
	BEGIN TRANSACTION
		IF NOT EXISTS (SELECT AttendDayID FROM TbAttendances WHERE AttendDayID = @AttendDayID)
			BEGIN
				IF @AttendDayID >= 0 AND @EmployeeID NOT IN('', ' ', NULL) AND @From NOT IN('', ' ', NULL)
					 AND @To NOT IN('', ' ', NULL) AND @Latenees NOT IN('', ' ', NULL) AND @LeaveEarly NOT IN('', ' ', NULL) 
					 AND @OverTime NOT IN('', ' ', NULL)
					  AND @Flag NOT IN('', ' ', NULL)
					BEGIN
						INSERT INTO TbAttendances
								(AttendDayID,EmployeeID,[From],[TO],Lateness,LeaveEarly,OverTime,Flag)
						VALUES (@AttendDayID,@EmployeeID,@From,@To,@Latenees,@LeaveEarly,@OverTime,@Flag)
						SELECT @Message = 1
					END
				ELSE
					BEGIN
						SELECT @Message = 0
					END
			END
		ELSE
			BEGIN
				SELECT @Message = 2
			END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
	IF @@ERROR <> 0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT @Message = 3
			PRINT ERROR_MESSAGE()
		END
END CATCH
go

---------Update Store Procedure------------
CREATE PROCEDURE Sp_AttendancesUpdate @Id INT,
@Message TINYINT OUT,--> 0 ==> NULL VALUE, 1 ==> ADDED, 2 ==> EXISTS, 3 ==> ERROR
@AttendDayID INT,
@EmployeeID INt,
@From datetime,
@To Datetime,
@Latenees int,
@LeaveEarly int,
@OverTime int,
@Flag CHAR(1) = 'A'
AS
BEGIN TRY
    BEGIN TRANSACTION
        IF EXISTS (SELECT AttendDayID FROM TbAttendances WHERE AttendDayID = @Id)
            BEGIN
              IF @AttendDayID >= 0 AND @EmployeeID NOT IN('', ' ', NULL) AND @From NOT IN('', ' ', NULL)
					 AND @To NOT IN('', ' ', NULL) AND @Latenees NOT IN('', ' ', NULL) AND @LeaveEarly NOT IN('', ' ', NULL) 
					 AND @OverTime NOT IN('', ' ', NULL)
					  AND @Flag NOT IN('', ' ', NULL)
                    BEGIN
                        UPDATE TbAttendances SET
					AttendDayID=@AttendDayID,
					EmployeeID=@EmployeeID,
					[From]=@From,
					[TO]=@To,
					Lateness=@Latenees,
					LeaveEarly=@LeaveEarly,
					OverTime=@OverTime,
					Flag=@Flag
						  WHERE AttendDayID = @Id
                        SELECT @Message = 1
                    END
                ELSE
                BEGIN
                    SELECT @Message = 0
                END
            END
        ELSE
        BEGIN
            SELECT @Message = 2
        END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO
---------Delete Store Procedure------------
create procedure Sp_AttendancesDelete
@Id INT,
@Message TINYINT OUT -- 2 -> Existing ERROR, 1 -> DONE, 3 -> ERROR
AS
BEGIN TRY
    BEGIN TRANSACTION
            IF EXISTS (SELECT AttendDayID FROM TbAttendances WHERE AttendDayID = @Id)
                BEGIN
                    UPDATE TbAttendances SET Flag = 'D' WHERE AttendDayID = @Id   
                    SELECT @Message = 1
                END
            ELSE
                BEGIN
                    SELECT @Message = 2
                END
	COMMIT TRANSACTION
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            ROLLBACK TRANSACTION
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH


GO
/*=================================================================================
								TbAttendaceDays proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_AttendaceDaysReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbAttendaceDays WHERE Flag NOT LIKE 'D'
    SELECT @Message = 1
END TRY 
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()  
        END
END CATCH
GO
-------------Read By Id Store Procedure---------------------
create procedure Sp_AttendaceDaysReadByID
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT AttendaceDaysID FROM TbAttendaceDays WHERE AttendaceDaysID = @Id)
        BEGIN
            SELECT * FROM TbAttendaceDays WHERE AttendaceDaysID = @Id AND Flag NOT LIKE 'D'
            SELECT @Message = 1 
        END
    ELSE
        BEGIN
            SELECT @Message = 0
        END
END TRY
BEGIN CATCH
    IF @@ERROR <> 0
        BEGIN
            SELECT @Message = 3
            PRINT ERROR_MESSAGE()
        END
END CATCH

GO
-------Insert Store Procedure--------------
create procedure Sp_AttendaceDaysInsert
@message tinyint out,
@Date date ,
@Flag CHAR(1) = 'A'

as
begin try
	begin transaction
		if not exists(select [date] from TbAttendaceDays where [date]=@Date)
   			begin
	   				if @Date NOT IN('', ' ', NULL)
						begin
   							insert into TbAttendaceDays (Date, Flag) values (@Date, @Flag) select @message= 1 
						end
		  			else
						begin 
   							select @message =0
   						end

   			end
	   else
			begin
				select @message =2
			end
   	COMMIT TRANSACTION
end try
begin catch
   if @@ERROR <> 0
	begin 
		rollback transaction 
		select @message =3 
		PRINT ERROR_MESSAGE()
	end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_AttendaceDayUpdate
@Message tinyint out ,
@ID int ,
@Date Date ,
@Flag Char(1) ='A'
as 
Begin try 
	begin transaction 
		if exists (select  AttendaceDaysID from TbAttendaceDays where  [AttendaceDaysID] = @ID )	
			begin 
				if @ID <> 0 and @Date not in ('',' ',null)
					begin
						update TbAttendaceDays 	set	[Date]=@Date, Flag = @Flag	where AttendaceDaysID =@ID
						select @Message =1
					end
				else
					begin 
						select @Message =0 
					end
	 
	 		end
		 else 
	 		begin
			 	select @Message =2
	 		end
	COMMIT TRANSACTION
end try
begin catch
	if @@ERROR <>0
	begin 
		rollback transaction
		select @Message = 3
		Print ERROR_Message()
	end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_AttendaceDayDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select AttendaceDaysID from TbAttendaceDays where AttendaceDaysID =@ID)	
			begin
	 			update TbAttendaceDays set Flag = 'D' where AttendaceDaysID =@ID
	 			select @Message =1 
	 		end 
	 	else 
	 		begin
	 			select @Message =2
	 		end	  
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
	begin 
		rollback transaction
		select @Message = 3
		Print ERROR_Message()
	end
end catch
go
/*=================================================================================
								TbEmployeeVacations proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
create procedure Sp_EmployeeVacationsReadAll
@Message tinyint out
as 
begin try
	select * from TbEmployeeVacations where Flag not like 'D'
	select @Message =1
end try
begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			Print Error_message()
		end
end catch
go
-------------Read By Id Store Procedure---------------------
create procedure Sp_EmployeeVacationsReadByID
@Message tinyint out,
@ID int 
as
begin try
	if exists (select EmployeeVacationID from TbEmployeeVacations where  EmployeeVacationID =@ID)
		begin
			select * from TbEmployeeVacations where EmployeeVacationID=@ID and Flag not like 'D'
			select @Message =1 
		end
	Else
		begin
			select @Message = 0
		end
end try 
begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			print error_message()
		end  
end catch
go
-------Insert Store Procedure--------------
create procedure Sp_EmployeeVacationsInsert
@Message tinyint out,
@VType int,
@Days int,
@Flag CHAR(1) = 'A',
@EmployeeID int
as
begin try
	begin transaction
		if not exists (select  Vtype from TbEmployeeVacations where Vtype =@VType )
			begin
				If @VType not in ('',' ',null) and @Days not in ('',' ',Null)and @EmployeeID not in('',' ',null)
					begin 
						insert into TbEmployeeVacations (Vtype,Days,EmployeeID, Flag) values (@VType,@Days,@EmployeeID, @Flag)
						select @Message =1 
					end
				else
					begin 
						select @message =0
					end
   			end
	   else
		begin
			select @message =2
		end
	commit transaction
end try 
begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_EmployeeVacationsUpdate
@ID int ,
@Message tinyint out,
@VType int,
@Days int,
@EmployeeID int,
@Flag char(1) ='A'
as
begin try
	begin transaction
		if exists (select  EmployeeVacationID from TbEmployeeVacations  where EmployeeVacationID =@ID )
			begin
				if @ID <> 0 and @VType not in ('',' ',null)and @Flag not in ('',' ',null ) and @Days not in ('',' ',null)and @EmployeeID not in ('',' ',null)
					begin
						update TbEmployeeVacations set [Vtype] =@VType,	[Days]=@Days, [EmployeeID]=@EmployeeID,	Flag = @Flag where EmployeeVacationID =@ID
					end 
				else
					begin
						select @Message =0 
					end
	 		end
	 	else 
			begin
				select @Message =2
	 		end
	COMMIT TRANSACTION
end try
begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_EmployeeVacationsDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if exists (select EmployeeVacationID from TbEmployeeVacations where EmployeeVacationID =@ID)	
	 		begin
				update TbEmployeeVacations set Flag = 'D' where EmployeeVacationID =@ID
				select @Message =1 
	 		end
		 else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go
/*=================================================================================
								TbTakeVacations proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
create procedure Sp_TakeVacationsReadAll
@Message tinyint out
as 
begin try
	select * from TbTakeVacations where Flag not like 'D'
	select @Message =1
end try
begin catch
	if @@ERROR <>0
	begin
		select @Message =3 
		Print Error_message()
	end
end catch
go
-------------Read By Id Store Procedure---------------------
create procedure Sp_TakeVacationsReadByID
@Message tinyint out,
@ID int 
as
begin try
	if exists (select TakeVacationsID from TbTakeVacations where  TakeVacationsID =@ID)
		begin
			select * from TbTakeVacations where TakeVacationsID=@ID and Flag not like 'D'
			select @Message =1 
		end
	Else
		begin
			select @Message = 0
		end
end try 
begin catch
	if @@ERROR <>0
	begin
		select @Message =3 
		Print Error_message()
	end
end catch
go
-------Insert Store Procedure--------------
create procedure Sp_TakeVacationsInsert
@Message tinyint out,
@DataTacked date,
@VacationTypeID int,
@EmployeeID int,
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if not exists (select  DateTacked from TbTakeVacations where DateTacked =@DataTacked )
			begin
				If @DataTacked not in ('',' ',null) and @VacationTypeID not in ('',' ',Null)and @EmployeeID not in('',' ',null)

					begin 
						insert into TbTakeVacations (DateTacked,VacationTypeID,EmployeeID, Flag) values (@DataTacked,@VacationTypeID,@EmployeeID, @Flag)
						select @Message =1 
					end
	 			else
					begin 
						select @message =0
					end
   			end
	   else
		begin
			select @message =2
		end
   commit transaction
end try 

begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_TakeVacationsUpdate
@ID int ,
@Message tinyint out,
@DataTacked date,
@VacationTypeID int,
@EmployeeID int,
@Flag char(1) ='A'
as
begin try
	begin transaction
		if exists (select  TakeVacationsID from TbTakeVacations  where TakeVacationsID =@ID )
			begin
				if @ID <> 0 and @DataTacked not in ('',' ',null)and @Flag not in ('',' ',null ) and @VacationTypeID not in ('',' ',null)and @EmployeeID not in ('',' ',null)
					begin
						update TbTakeVacations set [DateTacked] =@DataTacked, VacationTypeID=@VacationTypeID, [EmployeeID]=@EmployeeID, Flag = @Flag where TakeVacationsID =@ID
					end 
				else
					begin
						select @Message =0 
					end
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end try
begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_TakeVacationsDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select TakeVacationsID from TbTakeVacations where TakeVacationsID =@ID)	
	 		begin
				update TbTakeVacations set Flag = 'D' where TakeVacationsID =@ID
				select @Message =1 
			 end
	 	else 
			begin
				select @Message =2
	 		end
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
/*=================================================================================
								TbVacationTypes proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
create procedure Sp_VacationTypesReadAll
@Message tinyint out
as 
begin try
	select * from TbVacationTypes where Flag not like 'D'
	select @Message =1
end try

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			Print Error_message()
		end
end catch
go
-------------Read By Id Store Procedure---------------------
create procedure Sp_VacationTypesReadByID
@Message tinyint out,
@ID int 
as
begin try
	if exists (select VacationTypesID from TbVacationTypes where  VacationTypesID =@ID)
		begin
			select * from TbVacationTypes where ID=@ID and Flag not like 'D'
			select @Message =1 
		end
	Else
		begin
			select @Message = 0
		end
end try 

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			print error_message()
		end  
end catch
go
-------Insert Store Procedure--------------
create procedure Sp_VacationTypesInsert
@Message tinyint out,
@Type nvarchar(50),
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if not exists (select  Type from TbVacationTypes where Type =@Type )
			begin
				If @Type not in ('',' ',null) 
					begin 
						insert into TbVacationTypes (Type, Flag) values (@Type, @Flag)
						select @Message =1 
					end
	  			else
					begin 
						select @message =0
					end
   			end
	   	else
			begin
				select @message =2
			end
	commit transaction
end try 

begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_VacationTypesUpdate
@ID int ,
@Message tinyint out,
@Type nvarchar(50) ,
@Flag char(1) ='A'
as
begin try
	begin transaction
		if exists (select  VacationTypesID from TbVacationTypes  where VacationTypesID =@ID )
			begin
				if @ID <> 0 and @Type not in ('',' ',null)and @Flag not in ('',' ',null )	
					begin
						update TbVacationTypes set [Type] =@Type, Flag = @Flag
						where  VacationTypesID =@ID
					end 
				else
					begin
						select @Message =0 
					end
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end try

begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_VacationTypesDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select VacationTypesID from TbVacationTypes where VacationTypesID =@ID)	
	 		begin
				update TbVacationTypes set Flag ='D' where VacationTypesID =@ID
				select @Message =1 
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go
/*=================================================================================
								TbWorkTimes proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
create procedure Sp_WorkTimesReadAll
@Message tinyint out
as 
begin try
	select * from TbWorkTimes where Flag not like 'D'
	select @Message =1
end try

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			Print Error_message()
		end
end catch
go
-------------Read By Id Store Procedure---------------------
create procedure Sp_WorkTimesReadByID
@Message tinyint out,
@ID int 
as
begin try
	if exists (select WorkTimeID from TbWorkTimes where  WorkTimeID =@ID)
		begin
			select * from TbWorkTimes where WorkTimeID=@ID and Flag not like 'D'
			select @Message =1 
		end
	Else
		begin
			select @Message = 0
		end
end try 

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			print error_message()
		end  
end catch
go
-------Insert Store Procedure--------------
create procedure Sp_WorkTimesInsert
@Message tinyint out,
@StartTime time,
@LeaveTime time,
@StaffName nvarchar(50),
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if not exists (select  [StartTime] from TbWorkTimes where [StartTime] =@StartTime )
			begin
				If @StaffName not in ('',' ',null) and @StartTime not in ('',' ', null)
					begin 
						insert into TbWorkTimes(StartTime,LeaveTime,StaffName, Flag)
						 values (@StartTime, @LeaveTime,@StaffName,@Flag)
						select @Message =1 
					end
	  			else
					begin 
						select @message =0
					end
   			end
	   	else
			begin
				select @message =2
			end
	commit transaction
end try 

begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_WorkTimesUpdate
@ID int ,
@Message tinyint out,
@StartTime time,
@LeaveTime time,
@StaffName nvarchar(50),
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if exists (select  WorkTimeID from TbWorkTimes  where WorkTimeID =@ID )
			begin
				if @ID <> 0 and @StaffName not in ('',' ',null)and @Flag not in ('',' ',null )	
					begin
						update TbWorkTimes set StartTime =@StartTime,
						LeaveTime=@LeaveTime,
						StaffName=@StaffName,
						 Flag = @Flag
						 where WorkTimeID =@ID
					end 
				else
					begin
						select @Message =0 
					end
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end try

begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_WorkTimesDelete 
@Message tinyint out,
@StartTime time,
@LeaveTime time,
@StaffName nvarchar(50),
@Flag CHAR(1) = 'A',
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select WorkTimeID from TbWorkTimes where WorkTimeID =@ID)	
	 		begin
				update TbWorkTimes
				 set Flag ='D' where WorkTimeID =@ID
				select @Message =1 
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go
/*=================================================================================
								TbFixedVacations proc
===================================================================================*/
-------------Read all Store Procedure-----------------------
create procedure Sp_FixedVacationsReadAll
@Message tinyint out
as 
begin try
	select * from TbFixedVacations where Flag not like 'D'
	select @Message =1
end try

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			Print Error_message()
		end
end catch
go
-------------Read By Id Store Procedure---------------------
create procedure Sp_FixedVacationsReadByID
@Message tinyint out,
@ID int 
as
begin try
	if exists (select FixedVacationID  from TbFixedVacations where  FixedVacationID =@ID)
		begin
			select * from TbFixedVacations where FixedVacationID=@ID and Flag not like 'D'
			select @Message =1 
		end
	Else
		begin
			select @Message = 0
		end
end try 

begin catch
	if @@ERROR <>0
		begin
			select @Message =3 
			print error_message()
		end  
end catch
go
-------Insert Store Procedure--------------
create procedure Sp_FixedVacationsInsert
@Message tinyint out,
@FixedVacationName nvarchar(50),
@From datetime,
@To datetime,
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if not exists (select  [FixedVacationName] from TbFixedVacations where [FixedVacationName] =@FixedVacationName )
			begin
				If @FixedVacationName not in ('',' ',null) and @From not in ('',' ', null)
					begin 
						insert into TbFixedVacations(FixedVacationName,[From],[To], Flag)
						 values (@FixedVacationName, @From,@To,@Flag)
						select @Message =1 
					end
	  			else
					begin 
						select @message =0
					end
   			end
	   	else
			begin
				select @message =2
			end
	commit transaction
end try 

begin catch
	if @@ERROR <>0
		begin
			rollback transaction 
			select @Message = 3
			print Error_message()
		end
end catch
go
-------Update Store procedure-------------- 
create procedure Sp_FixedVacationsUpdate
@ID int ,
@Message tinyint out,
@FixedVacationName nvarchar(50),
@From datetime,
@To datetime,
@Flag CHAR(1) = 'A'
as
begin try
	begin transaction
		if exists (select  FixedVacationID from TbFixedVacations  where FixedVacationID =@ID )
			begin
				if @ID <> 0 and @FixedVacationName not in ('',' ',null)and @Flag not in ('',' ',null )	
					begin
						update TbFixedVacations set FixedVacationName =@FixedVacationName,
						[From]=@From,
						[To]=@To,
						 Flag = @Flag
						 where FixedVacationID=@ID
					end 
				else
					begin
						select @Message =0 
					end
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end try

begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go

-------Delete Store procedure-------------- 
create procedure Sp_FixedVacationsDelete 
@ID int ,
@Message tinyint out,
@FixedVacationName nvarchar(50),
@From datetime,
@To datetime,
@Flag CHAR(1) = 'A'
as 
Begin Try
	begin transaction 
		if  exists (select FixedVacationID from TbFixedVacations where FixedVacationID =@ID)	
	 		begin
				update TbFixedVacations
				 set Flag ='D' where FixedVacationID =@ID
				select @Message =1 
	 		end
	 	else 
			begin
				select @Message =2
			end
	COMMIT TRANSACTION
end Try
begin catch
	if @@ERROR <>0
		begin 
			rollback transaction 
			select @Message =3 
			print Error_message()
		end
end catch
go
