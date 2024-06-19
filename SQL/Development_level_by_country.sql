#### country ####
## For our analysis we dont need male and female suicide count to be different, so below code will merege them without merging entire data
## GNIPerCapita calculation is wrong in the original data, so we'll recalculate it

Create table country_suiciderate as 
with ranking_table as (select *, rank() over(partition by countryname, year order by sex) as ranking -- year, countryname,
				 from agestd_suiciderates), 
                
	sucidecount as (select countryname, Year, sum(SuicideCount) as 'SuicideCount'
					from agestd_suiciderates
					group by countryname, Year)
                    
select RegionCode, RegionName, CountryCode, c.CountryName, c.Year, c.SuicideCount, Population,(c.SuicideCount/Population)*100000 as DeathRate_Per100K,
GDP, GNI, GDPPerCapita, (GNI/Population) as GNIPerCapita, InflationRate, EmploymentPopulationRatio
from ranking_table r
join sucidecount c
on r.countryname = c.countryname and r.Year = c.Year 
where ranking = 1;                      


select * from agestd_suiciderates
where GNIPerCapita < 1100;

select Countryname, Year, GNI, population, GDPPerCapita,GNIPerCapita
from country_suiciderate
where GNIPerCapita < 1100;

## adding new column
SELECT *,
CASE
	WHEN GNIPerCapita >= 13845 THEN 'Developed'
	WHEN GNIPerCapita < 13845 AND GNIPerCapita >= 4256 THEN 'Developing(upper middle income)'
	WHEN GNIPerCapita <= 4255 AND GNIPerCapita > 1100 THEN 'Developing(lower middle income)'
    WHEN GNIPerCapita <= 1100 THEN 'Undeveloped'
	ELSE NULL
END AS DevelopmentCategory
FROM country_suiciderate;


-- alter table country_suiciderate drop column DevelopmentCategory;
SET SQL_SAFE_UPDATES = 0; -- 0 means disabbling the safe updates and 1 means turning it on 

alter table country_suiciderate add column DevelopmentCategory varchar(50);

UPDATE country_suiciderate
SET DevelopmentCategory = 
    CASE
		WHEN GNIPerCapita >= 13845 THEN 'Developed'
		WHEN GNIPerCapita < 13845 AND GNIPerCapita >= 4256 THEN 'Developing(upper middle income)'
		WHEN GNIPerCapita <= 4255 AND GNIPerCapita > 1100 THEN 'Developing(lower middle income)'
		WHEN GNIPerCapita <= 1100 THEN 'Undeveloped'
		ELSE NULL
    END;


Create table Countrywise_developmentlevel_suiciderate as 
select DevelopmentCategory, year, sum(GDP)/sum(population) as 'GDP PerCapita', sum(GNI)/sum(population) as 'GNI PerCapita', 
(sum(suicidecount)/sum(population))*100000 as 'SuicideRate', sum(InflationRate * GDP)/ SUM(GDP) AS 'WeightedAverageInflationRate',
sum(EmploymentPopulationRatio * Population)/sum(Population) as 'WeightedAverageEmploymentRate'
from country_suiciderate
group by DevelopmentCategory, year; 



select *
from Countrywise_developmentlevel_suiciderate;



