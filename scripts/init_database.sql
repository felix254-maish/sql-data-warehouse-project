/*
-------------------------------
Create Database and Schemas 
-------------------------------
script purpose:
    This script create anew databse named 'Datawarehouse' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    Within the databse: 'bronze', 'silver', 'gold'.

WARNING : 
    Running this script will drop the entire 'datawarehose' databse if it exists.
    All data in the databse will be permanently deleted. Proceed with the caution 
    and ensure you have proper backups before running the script.
*/
--Create Database 'Datawarehouse'


use master;
GO

--Drop and recreate the 'Datawarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name  =  'Datawarehouse')
BEGIN 
	ALTER DATABSE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABSE Datawarehouse;
END;
GO

--Create the 'Datawarehouse' database
CREATE DATABASE DataWarehouse;

use DataWarehouse ;


CREATE SCHEMA bronze ;
GO
CREATE SCHEMA silver ;
GO
CREATE SCHEMA gold;
GO
