# Economical factors on Suicide Rate Tableau Dashboard
 

<p align="justify">
This Tableau dashboard provides a comprehensive analysis of the impact of various economic factors on suicide rates, both globally and at the individual country level. It uses interactive visualizations to present insights on how economic conditions correlate with suicide rates.<br/>

**Global Analysis:**  Compares suicide rates across different development categories worldwide.<br/>
**Country-Specific Analysis:**  Focuses on the economic factors affecting suicide rates within individual countries.<br/>
**Interactive Navigation:**  Use the button to switch between global and country-specific dashboards.<br/>
**Economic Indicators:**  Displays GDP, unemployment rates, and other economic factors.<br/>

link - https://nikhilk-crypto.github.io/Economical-factors-on-Suicide-Rate/
<br/><br/>
### Data Source
The data is sourced from the Kaggle dataset on [**Suicide Rates & Socioeconomic Factors (1990 - 22)**](https://www.kaggle.com/datasets/ronaldonyango/global-suicide-rates-1990-to-2022/data?select=age_std_suicide_rates_1990-2022.csv). This dataset includes:

**Suicide Rates:** Annual age-standardized suicide rates per 100,000 population for multiple countries.<br/>
**Economic Indicators:** Data on GDP, unemployment rates, and other economic factors.<br/>
**Demographic Information:** Data segmented by age, gender, and country.<br/>
The dataset is comprehensive, covering multiple decades and allowing for in-depth analysis of trends and patterns.

### SQL 
In this project, I connect MySQL to Tableau. Various SQL queries were used to manipulate and analyze the data. The dataset consisted of rows for male and female suicide rates and counts for each country and year, while the other economic indicators remained the same for both rows. To properly analyze the data, I merged these rows by keeping the economic factors constant, summing the suicide count columns, removing the default suicide rate, and calculating a new one. Additionally, countries were categorized into undeveloped, developing (lower middle income), developing (upper middle income), and developed to examine suicide rates by development levels, also we recalculated economic factors for each devlopment level. 

```sql
SELECT DevelopmentCategory, year, 
  SUM(GDP)/SUM(population) AS 'GDP PerCapita', 
  SUM(GNI)/SUM(population) AS 'GNI PerCapita', 
  (SUM(suicidecount)/SUM(population))*100000 AS 'SuicideRate', 
  SUM(InflationRate * GDP)/ SUM(GDP) AS 'WeightedAverageInflationRate',
  SUM(EmploymentPopulationRatio * Population)/SUM(Population) AS 'WeightedAverageEmploymentRate'
FROM country_suiciderate 
GROUP BY DevelopmentCategory, year;
```


<p>
