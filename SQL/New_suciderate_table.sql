select * from agestd_suiciderates;


SELECT count(distinct(country))
FROM agestd_suiciderates t1
JOIN only_suiciderate_unpivot t2
ON t1.CountryName = t2.Country; -- and t1.year = t2.year ;


select count(distinct(countryname))
from agestd_suiciderates
where countryname in (select country from only_suiciderate_unpivot);
    

with SuicideCount_table as (select RegionName,countryname,Year,sum(SuicideCount) as 'SuicideCount'
							from agestd_suiciderates
							group by RegionName, countryname,Year),
					
combined_table as (select RegionCode, s.RegionName,s.countryname,s.Year,s.SuicideCount,Population,GDP, 
				   GDPPerCapita, GNI, GNIPerCapita, InflationRate, EmploymentPopulationRatio
				   from agestd_suiciderates a
				   join SuicideCount_table s 
				   on a.RegionName = s.RegionName and a.countryname = s.countryname and a.Year=s.Year)

SELECT t1.*, t2.rate
FROM combined_table t1
JOIN only_suiciderate_unpivot t2
ON t1.CountryName = t2.Country AND t1.Year = t2.Year;




with SuicideCount_table as (select RegionName,countryname,Year,sum(SuicideCount) as 'SuicideCount'
							from agestd_suiciderates
							group by RegionName, countryname,Year),
					
combined_table as (select RegionCode, s.RegionName,s.countryname,s.Year,s.SuicideCount,Population,GDP, 
				   GDPPerCapita, GNI, GNIPerCapita, InflationRate, EmploymentPopulationRatio
				   from agestd_suiciderates a
				   join SuicideCount_table s 
				   on a.RegionName = s.RegionName and a.countryname = s.countryname and a.Year=s.Year)
                   
                   
select * from combined_table;
