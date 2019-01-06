use SmartClinicDB
GO

--==============================================
---------------Reservation Types----------------
--==============================================

Create table TbReservationTypes
(
	ReservationTypeID int primary key identity(1,1),
	ReservationTypeName nvarchar(50),
	Flag CHAR(1)
)
go 

--==============================================
---------------Reservation----------------------
--==============================================

Create table TbReservations
(
	ReservationID int primary key identity(1,1),
	StaffID int , -- from table Staff
	DoctorID int, --from table doctor
	PatientID int , -- from table Patient
	ReservationTypeID int,
	ReservationDate datetime ,
	ReservationCheck datetime ,
	Flag char(1)
)
go

--==============================================
---------------Reservation Prices---------------
--==============================================

Create table TbReservationPrices
(
	DoctorID int ,
	ReservationTypeID int,
	Price decimal(9,2),
	primary key(DoctorID,ReservationTypeID),
	Flag char(1)
)
go 


----------------------------------------------
----------------------------------------------
--add constraint
-- table TbReservations
Alter table TbReservations
add constraint fk_TbReservations_withhisType foreign key (ReservationTypeID) references 
TbReservationTypes(ReservationTypeID)
GO
-- Alter table TbReservations
-- add constraint fk_TbReservations_TbStaff FOREIGN KEY (StaffID) REFERENCES  TbStaffs(StaffID)
-- GO
ALTER table TbReservations
add constraint fk_TbReservations_TbDoctor FOREIGN KEY (DoctorID) REFERENCES TbReservationPrices(DoctorID)
go
--patinent ID
ALTER table TbReservations
add constraint fk_TbReservations_TbPatients FOREIGN KEY (PatientID) REFERENCES TbPatients(PatientID)
go
-- table TbReservationPrices
----------------------------------------------
----------------------------------------------
ALTER table TbReservationPrices
add constraint fk_TbReservationPrices_TbDoctor FOREIGN KEY (DoctorID) REFERENCES TbDoctors(DoctorID)
GO
ALTER table TbReservationPrices
add constraint fk_TbReservationPrices_TbReservationTypes FOREIGN KEY (ReservationTypeID) REFERENCES TbReservationTypes(ReservationTypeID)

GO
/*=============================================
---------------Reservation Proc--------------
=============================================*/ 
-----------Read All store procedure----------
CREATE PROCEDURE Sp_ReservationsReadAll
@Message TINYINT OUT,
@Flag CHAR(1) = 'A'
AS
BEGIN TRY   
    SELECT * from TbReservations WHERE Flag like @Flag and Flag NOT like 'D'
END TRY

BEGIN CATCH
    IF @@ERROR <> 0
    BEGIN
        SELECT @Message = 3
        PRINT ERROR_MESSAGE()  

    END

END CATCH
GO
---------------------------------------------
-----------Read By ID store procedure----------

Create PROCEDURE Sp_ReservationsReadByID
@message TINYINT out,
@ID int,
@Flag CHAR(1) = 'A'
AS

BEGIN TRY
    IF EXISTS (SELECT ReservationTypeID FROM TbReservations WHERE ReservationID = @Id)
        BEGIN
            SELECT * FROM TbReservations WHERE ReservationID = @Id AND Flag NOT LIKE 'D' and Flag like @Flag 
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
---------------------------------------------
-----------Insert store procedure----------
SET ANSI_NULLS OFF
GO

Create PROCEDURE Sp_ReservationsInsert
@Message TINYINT out,
@DoctorID INT,
@StaffID INT,
@PatientID int,
@ReservationDate DATETIME,
@ReservationCheck DATETIME,
@TbReservationTypesID INT,
@Flag CHAR(1) ='A'
AS
BEGIN TRY
	BEGIN TRANSACTION
			BEGIN
				IF @DoctorID > 0 and @StaffID > 0 and @ReservationDate not in ('',' ',null)
				BEGIN

				INSERT into TbReservations (StaffID,PatientID,ReservationDate,ReservationCheck,ReservationTypeID,Flag)
				VALUES(@StaffID,@PatientID,@ReservationDate,@ReservationCheck,@TbReservationTypesID,@Flag) 
				END
				ELSE
				BEGIN 
					SELECT @Message =0

				END

				
			END
	COMMIT TRANSACTION
END TRY 
BEGIN CATCH
    IF @@ERROR <>0
    BEGIN
    ROLLBACK TRANSACTION
    select @Message =3
    PRINT ERROR_MESSAGE()
    END
END CATCH
GO
---------------------------------------------
-----------Update  store procedure----------
SET ANSI_NULLS OFF
GO

CREATE PROCEDURE  Sp_ReservationsUpdate
@Message TINYINT OUT,
@ReservationID int,
@StaffID int,
@PatientID int,
@ReservationDate DATETIME,
@ReservationCheck DATETIME,
@ReservationTypes int,
@Flag CHAR(1)

AS
BEGIN TRY 
BEGIN TRANSACTION
if exists ( select ReservationID from TbReservations WHERE ReservationID =@ReservationID)
BEGIN 
if @ReservationID >0 and @StaffID >0 and @PatientID >0 and @ReservationTypes <>0
	begin
						update TbReservations
                        set	[StaffID]=@StaffID,
                        PatientID=@PatientID,
                        ReservationDate=@ReservationDate,
                        ReservationCheck =@ReservationCheck
                        , Flag = @Flag	where ReservationID = @ReservationID
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
END TRY
BEGIN CATCH

END CATCH 

GO
-------Delete Store procedure-------------- 

create procedure Sp_ReservationsDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select ReservationID from TbReservations where ReservationID =@ID)	
			begin
	 			update TbReservations set Flag = 'D' where ReservationID =@ID
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





/*
======================================
        TbReservationTypes Proc
======================================
*/ 
CREATE PROCEDURE Sp_ReservationTypesReadAll 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbReservationTypes WHERE Flag NOT LIKE 'D'
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
create procedure Sp_ReservationTypesReadByID
@Id INT,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT ReservationTypeID FROM TbReservationTypes WHERE ReservationTypeID = @Id)
        BEGIN
            SELECT * FROM TbReservationTypes WHERE ReservationTypeID = @Id AND Flag NOT LIKE 'D'
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
SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationTypesInsert
@message tinyint out,
@Type NVARCHAR(50) ,
@Flag CHAR(1) = 'A'

as
begin try
	begin transaction
		if not exists(select [ReservationTypeName] from TbReservationTypes where [ReservationTypeName]=@Type)
   			begin
	   				if @Type NOT IN('', ' ', NULL)
						begin
   							insert into TbReservationTypes (ReservationTypeName, Flag) values (@Type, @Flag) select @message= 1 
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
SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationTypesUpdate
@Message tinyint out ,
@ID int ,
@Type NVARCHAR(50) ,
@Flag Char(1)
as 
Begin try 
	begin transaction 
		if exists (select  ReservationTypeID from TbReservationTypes where  [ReservationTypeID] = @ID )	
			begin 
				if @ID <> 0 and @Type not in ('',' ',null)
					begin
						update TbReservationTypes 	set	[ReservationTypeName]=@Type, Flag = @Flag	where AttendaceDayID = @ID
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
SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationTypesDelete 
@Message tinyint out,
@ID int
as 
Begin Try
	begin transaction 
		if  exists (select ReservationTypeID from TbReservationTypes where ReservationTypeID =@ID)	
			begin
	 			update TbReservationTypes set Flag = 'D' where ReservationTypeID =@ID
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


/*
======================================
    TbReservationPricess Proc
======================================
*/ 
-------------Read all Store Procedure-----------------------
CREATE PROCEDURE Sp_RevservationPricesReadALL 
@Message TINYINT OUT -- 1 -> Done, 3 -> ERROR
AS
BEGIN TRY
    SELECT * FROM TbReservationPrices WHERE Flag NOT LIKE 'D'
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
create procedure Sp_ReservationPricesReadByID
@DoctorID INT,
@ReservationTypeID int,
@Message TINYINT OUT--> 0 ==> NULL VALUE, 1 ==> DONE, 3 ==> ERROR
AS
BEGIN TRY
    IF EXISTS (SELECT DoctorID FROM TbReservationPrices WHERE DoctorID = @DoctorID)
        BEGIN
            SELECT * FROM TbReservationPrices WHERE DoctorID = @DoctorID AND Flag NOT LIKE 'D'
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

SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationPricesInsert
@message tinyint out,
@DoctorID int,
@Price DECIMAL(9,2),
@ReservationTypeID int,
@Flag CHAR(1) = 'A'

as
begin try
	begin transaction
   			begin
				if @DoctorID NOT IN('', ' ', NULL) and @ReservationTypeID not in ('',' ', null)
					begin
						insert into TbReservationPrices (DoctorID,ReservationTypeID, Flag, Price)
							values (@DoctorID,@ReservationTypeID, @Flag, @Price) 
							select @message= 1 
					end
				else
					begin 
						select @message =0
					end

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

SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationPricesUpdate
@Message tinyint out ,
@DoctorID int,
@Price DECIMAL(9,2),
@ReservationTypeID int,

@Flag Char(1)
as 
Begin try 
	begin transaction 
			begin 
				if @DoctorID <> 0 and @DoctorID not in ('',' ',null) and @ReservationTypeID <>0

					-----here when have proglam when i update ,update by DocotrID OR REservatioTYpeID
					
					begin
						update TbReservationPrices 	set	[ReservationTypeID]=@ReservationTypeID, 
                        Flag = @Flag	where DoctorID = @DoctorID
						select @Message =1
					end
				else
					begin 
						select @Message =0 
					end
	 
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
SET ANSI_NULLS OFF
GO

create procedure Sp_ReservationPricesDelete
@Message tinyint out,
@DoctorID int,
@ReservationTypeID int
as 
Begin Try
	begin transaction 
		if  exists (select DoctorID, ReservationTypeID from TbReservationPrices where DoctorID =@DoctorID and ReservationTypeID = @ReservationTypeID)	
			begin
	 			update TbReservationPrices set Flag = 'D' where DoctorID =@DoctorID
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

