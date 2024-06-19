
CREATE TABLE only_suiciderate_unpivot AS
SELECT Country, 2000 AS Year, `2000` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2001 AS Year, `2001` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2002 AS Year, `2002` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2003 AS Year, `2003` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2004 AS Year, `2004` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2005 AS Year, `2005` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2006 AS Year, `2006` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2007 AS Year, `2007` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2008 AS Year, `2008` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2009 AS Year, `2009` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2010 AS Year, `2010` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2011 AS Year, `2011` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2012 AS Year, `2012` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2013 AS Year, `2013` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2014 AS Year, `2014` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2015 AS Year, `2015` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2016 AS Year, `2016` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2017 AS Year, `2017` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2018 AS Year, `2018` AS Rate FROM only_suiciderate
UNION ALL
SELECT Country, 2019 AS Year, `2019` AS Rate FROM only_suiciderate;


# In the table there are rows with Country name as 'country' to tackle this issue we will do below steps. 

ALTER TABLE only_suiciderate_unpivot ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;
 
DELETE osu
FROM only_suiciderate_unpivot osu
JOIN (
    SELECT id
    FROM only_suiciderate_unpivot
    WHERE country = 'Country'
) t ON osu.id = t.id;

ALTER TABLE only_suiciderate_unpivot DROP COLUMN id;


# checking if it got resolved. 
select 
* from only_suiciderate_unpivot
where country = 'Country';

select * from only_suiciderate_unpivot