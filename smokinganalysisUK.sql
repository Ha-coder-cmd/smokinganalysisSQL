create database road_accident;

use road_accident;

select * from smoking
;


-- SUMMARY OF COLUMNS
-- gender	Gender with levels Female and Male.
-- age	Age.
-- marital_status	Marital status with levels Divorced, Married, Separated, Single and Widowed.
-- highest_qualification	Highest education level with levels A Levels, Degree, GCSE/CSE, GCSE/O Level, Higher/Sub Degree, No Qualification, ONC/BTEC and Other/Sub Degree
-- nationality	Nationality with levels British, English, Irish, Scottish, Welsh, Other, Refused and Unknown.
-- ethnicity	Ethnicity with levels Asian, Black, Chinese, Mixed, White and Refused Unknown.
-- gross_income	Gross income with levels Under 2,600, 2,600 to 5,200, 5,200 to 10,400, 10,400 to 15,600, 15,600 to 20,800, 20,800 to 28,600, 28,600 to 36,400, Above 36,400, Refused and Unknown.
-- region	Region with levels London, Midlands And East Anglia, Scotland, South East, South West, The North and Wales
-- smoke	Smoking status with levels No and Yes
-- amt_weekends	Number of cigarettes smoked per day on weekends.
-- amt_weekdays	Number of cigarettes smoked per day on weekdays.
-- type	Type of cigarettes smoked with levels Packets, Hand-Rolled, Both/Mainly  Packets and Both/Mainly Hand-Rolled


-- 1) lets check which nationality people smoke the most
select nationality,count(smoke)as smoke_quantity
from smoking
where smoke='Yes'
group by nationality
order by smoke_quantity desc;
-- englishmen and britishers smokers smoke the most in this dataset

-- 2) lets check the maritial_status and highest_qualification
-- single and married people are smoking more as compared to others
select count(marital_status),marital_status
from smoking
where smoke='Yes'
group by marital_status;
-- find the highest qualification
select count(highest_qualification),highest_qualification
from smoking
where smoke='Yes'
group by highest_qualification;
-- not qualified people are smoking more as compared to others qualified people
-- suggestion awareness should be spread among the non-qualified that smoking is not cause of solution by govarnment

-- find the country with highest non smoker
with my_cte as (
select nationality,count(nationality)as smoke_count
from smoking
where smoke='No'
group by nationality)
select a.rnk,a.nationality from (select nationality,smoke_count,dense_rank() over(order by smoke_count desc) as rnk from my_cte ) a where a.rnk=1;
-- englishmen emerge as the biggest non smokers

-- lets check whether people smoke more on the weekends or weekdays
create view smoke_daywise_analysis as(
select MyUnknownColumn, amt_weekends,amt_weekdays
from smoking
where smoke='Yes');
select * from smoke_daywise_analysis ;
-- lets check for the same case
select MyUnknownColumn
from smoke_daywise_analysis
where amt_weekends=amt_weekdays
group by MyUnknownColumn;
-- insight out of 421 smokers 230 are in the same performance,same weekday,same weekend 55 percent smoke 
-- lets check for the weekends greater case 
select MyUnknownColumn
from smoke_daywise_analysis
where amt_weekends>amt_weekdays
group by MyUnknownColumn;
-- insight out of 421 smokers 128 are  smoking more in  weekend which is 30 percent smoke 

-- remaining 63 accoujnt to rest 10 15 percent
select MyUnknownColumn
from smoke_daywise_analysis
where amt_weekends<amt_weekdays
group by MyUnknownColumn;


-- suggestion people smoking in weekends should keep any eye if they party then they should not smoke and if free then in weekends should keep themselves busy to avoid smoking
-- for weekdays people should keep stress level low if assuming they are smoking due to office pressure
-- for similar trends should try to smoke less in either weekday or weekend and eventually quit


-- lets categorize the gender of the  smokers ,how many men and how many women
select gender,count(gender)
from smoking
where smoke='Yes'
group by gender;
-- women smoke more as compared to men[234 f,187f]
-- lets create view seperating the two gender and finding the reason behind
create view v_smoke_f as 
select * from
smoking where
smoke='Yes' and gender='Female';
select * from v_smoke_f;

select count(gross_income),
gross_income from v_smoke_f
group by gross_income
order by count(gross_income)
desc;
-- insight women having gross_income from 2600 to 15600 smoke more in comparison to people having more gross_income

-- lets check maritial status and education of female smokers
select count(marital_status),
 marital_status from v_smoke_f
group by marital_status
order by count(marital_status)
desc;
-- education
select count(highest_qualification),
highest_qualification from v_smoke_f
group by highest_qualification
order by count(highest_qualification)
desc;
-- insights (women with no qualification and gcse/o level smoke more as compared to other qualification)
-- ethicityy
select count(ethnicity),
ethnicity from v_smoke_f
group by ethnicity
order by count(ethnicity)
desc;
-- white women smoke more as compared to others
-- it comes as english and british nationality smoke more after knowing the  nationality
-- check nationality 
select count(nationality),
nationality from v_smoke_f
group by  nationality
order by count(nationality)
desc;

-- region
select count(region),
region from v_smoke_f
group by  region
order by count(region)
desc;
-- north and midlands east angila women smoke more
-- find which type women smoke
select type,count(type) from v_smoke_f
group by type;
-- women smoke more in packets

-- lets check at what level women smoke in weekdays or weekends

with my_Cte as(select MyUnknownCOlumn,amt_weekends,amt_weekdays
from v_smoke_f
group by amt_weekends,amt_weekdays,MyUnknownCOlumn)

-- check for more cases
-- women 125  smoke equally
-- 76 more on weekends
-- 33 smoke on weekdays
select * from my_cte where amt_weekends>amt_weekdays


;
-- Create view and find cases in men
create view v_smoke_m as 
select * from
smoking where
smoke='Yes' and gender='male';
select * from v_smoke_m;

-- check all one by one
select count(marital_status),
 marital_status from v_smoke_m
group by marital_status
order by count(marital_status)
desc;  

select count(highest_qualification),highest_qualification  from v_smoke_m
group by highest_qualification
order by count(highest_qualification)
desc;

select count(nationality),nationality from v_smoke_m
group by nationality
order by count(nationality)
desc;

select count(ethnicity),ethnicity from v_smoke_m
group by ethnicity
order by count(ethnicity)
desc;

select count(gross_income),gross_income from v_smoke_m
group by gross_income
order by count(gross_income)
desc;



select count(gross_income),gross_income from v_smoke_f
group by gross_income
order by count(gross_income)
desc;

-- Key insight women who have gigher gross income smoke less but men of almost  all income group smoke 


-- 


select count(region),region from v_smoke_m
group by region
order by count(region)
desc;


with my_cte1 as(select MyUnknownCOlumn,amt_weekends,amt_weekdays
from v_smoke_m
group by amt_weekends,amt_weekdays,MyUnknownCOlumn)


-- check for more cases
-- women 125  smoke equally
-- 76 more on weekends
-- 33 smoke on weekdays

select * from my_cte1 where amt_weekends<amt_weekdays
;
select type,count(type)
from v_smoke_m
group by type;



-- Now lets analyze the people with non smoking abilities and why they do not smoke

select * from smoking;


create view non_smokers as
select * from smoking 
where smoke='No'
;
select * from non_smokers;
-- find which nationality people are non smokeers the most

select nationality,count(nationality)
from non_smokers
group by nationality;

-- find which gender people more non smokers [female are more non smokers as compared to men]
select gender,count(gender)
from non_smokers       
group by gender;

-- find what marital status people smoke more  [married people are biggest non smokers]
select marital_status,count(marital_status)   
from non_smokers
group by marital_status;


select highest_qualification,count(highest_qualification) -- non qualification from 
from non_smokers   
group by   highest_qualification    ;       

select nationality,count(nationality) -- non qualification from 
from non_smokers   
group by  nationality   ;     


select ethnicity,count(ethnicity)
from non_smokers
group by ethnicity;





select gross_income,count(gross_income)
from non_smokers
group by gross_income
                              
                              
select region,count(region)
from non_smokers
group by region;
                              