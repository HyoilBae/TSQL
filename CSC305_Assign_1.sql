
--CSC305 Assignment#1 Hyoil Bae

USE TSQL;
GO

SELECT firstname AS FirstName, lastname AS LastName, 
		CASE region
	WHEN 'WA' THEN 'Washington'
	ELSE 'England'
	END AS RegionSpelledOut,
		CASE
	WHEN country = 'USA' THEN 'United States of America'
	WHEN country = 'UK' THEN 'United Kingdom'
	ELSE 'Unknown'
	END AS CountrySpelledOut
FROM HR.Employees;