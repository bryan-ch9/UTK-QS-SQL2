SELECT Lower(h.name) as 'Name'
FROM healthcare_data h

SET SQL_SAFE_UPDATES = 0;

-- Updated Name column to all lowercase to clean data since original casing was inconsistent--
Update healthcare_data
SET name = lower(healthcare_data.name)

SET SQL_SAFE_UPDATES = 1;

Select *
From healthcare_data
ORDER BY healthcare_data.Hospital

-- Cleaned the names: removed prefixes like 'Mr.', 'Mrs.', 'Dr.', etc. --
Update healthcare_data 
Set Name = REPLACE(
        REPLACE(
            REPLACE(
                REPLACE(
                    REPLACE(Name, 'mr. ', ''),
                    'mrs. ', ''
                ),
                'ms. ', ''
            ),
            'dr. ', ''
        ),
        'miss ', ''
    );

-- Verifying that there are no empty cells --
select Name
From healthcare_dataset
where Name = " " or Null;

Select Age
From healthcare_dataset
where Age = " " or Null;

Select Gender
From healthcare_dataset
Where Gender = " " or Null;

Select 'Blood Type'
From healthcare_dataset
Where 'Blood Type' = " " or Null;

Select 'Medical Condition'
From healthcare_dataset
Where 'Medical Condition' = " " or Null;

Select 'Date of Admission' 
From healthcare_dataset
Where 'Date of Admission' = " " or Null;


Select `Name`, Doctor
From healthcare_dataset
Where Doctor = " " or Null; 

Select `Name`, Hospital
From healthcare_dataset
Where Hospital = " " or Null;

Select `Name`, "Insurance Provider"
From healthcare_dataset
Where "Insurance Provider" = " " or Null;


Select `Name`, "Billing Amount" 
From healthcare_dataset
Where "Billing Amount" = " " or Null;


Select `Name`, "Admission Type" 
From healthcare_dataset
Where "Admission Type" = " " or Null; 

Select `Name`, "Discharge Date" 
From healthcare_dataset
Where "Discharge Date" = " " or Null;


Select `Name`, Medication
From healthcare_dataset
Where Medication = " " or Null; 

Select `Name`, "Test Results" 
From healthcare_dataset
Where "Test Results" = " " or Null;


Select `Name`, Gender
From healthcare_dataset
Where Gender not in ("Male" or "Female");

Select `Name`, "Admission Type"
From healthcare_dataset
Where "Admission Type" not in ("Urgent", "Emergency" or "Elective");


Select `Name`, "Test Results"
From healthcare_dataset
Where "Test Results" not in ("Normal", "Inconclusive" or "Abnormal");

----------------------------------------------------------------------------------------

-- Q1: Counts the number of patients per medical condition, ordered by frequency --
SELECT 
    Medical_Condition,
    COUNT(*) AS Patient_Count
FROM 
    healthcare_data
GROUP BY 
    Medical_Condition
ORDER BY 
    Patient_Count DESC;
    
-- Q2: Calculates the average billing amount per admission type --
SELECT 
    Admission_Type,
    ROUND(AVG(Billing_Amount), 2) AS Average_Billing
FROM 
    healthcare_data
GROUP BY 
    Admission_Type
ORDER BY 
    Average_Billing DESC;
    
-- Q3: Counts how many patients each doctor has treated. Only top 10 doctors. --
SELECT 
    Doctor,
    COUNT(*) AS Patient_Count
FROM 
    healthcare_data
GROUP BY 
    Doctor
ORDER BY 
    Patient_Count DESC
LIMIT 10;

-- Q4: For each condition, how many had abnormal test results? --
SELECT 
    Medical_Condition,
    COUNT(*) AS Abnormal_Cases
FROM 
    healthcare_data
WHERE 
    Test_Results = 'Abnormal'
GROUP BY 
    Medical_Condition
ORDER BY 
    Abnormal_Cases DESC;
    
-- Q5: Sums up total billing by insurance provider --
SELECT 
    Insurance_Provider,
    ROUND(SUM(Billing_Amount), 2) AS Total_Billing
FROM 
    healthcare_data
GROUP BY 
    Insurance_Provider
ORDER BY 
    Total_Billing DESC;
    
-- Created new table that shows only doctors and their respective hospitals --
Create Table Doctors AS
SELECT DISTINCT
    Doctor,
    Hospital
FROM 
    healthcare_data;
    
-- Created Table that displays all distinct insurance providers --
Create Table Insurance AS
SELECT Distinct 
	Insurance_Provider
FROM
	healthcare_data

/* Created table that shows all distinc medical conditions, along with their 
medication and test results. */
Create Table Medical_Conditions AS
SELECT DISTINCT
    Medical_Condition,
    Medication,
    Test_Results
FROM 
    healthcare_data;

-- Created a simplified date dimension for admissions that can be used for visualization purposes. --
CREATE TABLE Dates AS
SELECT DISTINCT
    Date_of_Admission AS Date,
    YEAR(Date_of_Admission) AS Year,
    MONTH(Date_of_Admission) AS Month,
    DAY(Date_of_Admission) AS Day,
    WEEK(Date_of_Admission) AS Week,
    QUARTER(Date_of_Admission) AS Quarter
FROM 
    healthcare_data;


