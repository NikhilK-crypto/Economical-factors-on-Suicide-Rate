### Contient ###
with ranking_table as (select Regionname, year, countryname, population, sex, GDP, rank() over(partition by countryname, year order by sex) as ranking 
				 from agestd_suiciderates), 
                
	sucidecount as (select RegionName, Year, sum(SuicideCount) as 'SuicideCount'
					from agestd_suiciderates
					group by RegionName, Year),
              
	populationcount as (select Regionname, year,sum(population) as 'Population', sum(GDP) as GDP
			            from ranking_table 
						where ranking = 1
						group by Regionname, year),
                
	malefemale_sucidecount as (select regionname, year, 
							   ssuicideratesum(case when sex = 'Male' then total_M_F_suicidecount else 0 end) as Male_Suicidecount,
							   sum(case when sex = 'Female' then total_M_F_suicidecount else 0 end) as Female_Suicidecount
							   from (
									 select regionname, year, sex, sum(suicidecount) as 'total_M_F_suicidecount'
								     from agestd_suiciderates
								     group by regionname, year, sex
                                     ) as malefemale_sucidecount_unpivot
							   group by regionname, year)
               
select t2.RegionName, t2.year, Male_Suicidecount, Female_Suicidecount,(SuicideCount/Population)*100000 as 'SuicideRate', Population, GDP, (GDP/Population) as 'GDP per Capita'
from sucidecount t2
join populationcount t3
on t2.RegionName = t3.RegionName and t2.year = t3.year
join malefemale_sucidecount t4 
on t4.year = t3.year
order by Regionname, year;
    
 
		
