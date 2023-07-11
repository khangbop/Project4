#Remove index column
ALTER TABLE cwurdata DROP COLUMN Column1

ALTER TABLE shanghaidata DROP COLUMN Column1

ALTER TABLE timesdata DROP COLUMN Column1

ALTER TABLE country_profile_variables DROP COLUMN Column1

ALTER TABLE education_expenditure_supplement_data DROP COLUMN Column1

ALTER TABLE educational_attainment_supplement_data DROP COLUMN Column1

-------------------------------------------------------------------------------------------------------------------------

#CENTER FOR WORLD UNIVERSITY RANKINGS (cwurData)

UPDATE cwurdata 
SET country = REPLACE(country,'USA','United States')

UPDATE cwurdata 
SET country = REPLACE(country,'Russia','Russian Federation')

UPDATE cwurdata 
SET country = REPLACE(country,'South Korea','Korea, Republic of')

#Top 10 University by year (2012-2015)
SELECT world_rank, institution 
FROM cwurdata c 
WHERE `year` = 2012
LIMIT 10

SELECT world_rank, institution 
FROM cwurdata c 
WHERE `year` = 2013
LIMIT 10

SELECT world_rank, institution 
FROM cwurdata c 
WHERE `year` = 2014
LIMIT 10

SELECT world_rank, institution 
FROM cwurdata c 
WHERE `year` = 2015
LIMIT 10

#Rankings for publication, citations, patens, quality of education, 
#alumni employment, quality of faculty for each country

#Number of rankins by publications 
	(Ranking ALL)

SELECT country, count(publications)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(publications) DESC 

	(Ranking OF top 50)

SELECT country, count(publications) 
FROM cwurdata c 
WHERE publications <=50
GROUP BY country 
ORDER BY count(publications) DESC  

#Number of rankings by citations
	(Ranking ALL)

SELECT country, count(citations)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(citations) DESC

	(Ranking OF top 50)

SELECT country, count(citations) 
FROM cwurdata c 
WHERE citations <=50
GROUP BY country 
ORDER BY count(citations) DESC  

#Number of rankings by patens
	(Ranking ALL)

SELECT country, count(patents)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(patents) DESC

	(Ranking OF top 50)

SELECT country, count(patents) 
FROM cwurdata c 
WHERE patents  <=50
GROUP BY country 
ORDER BY count(patents) DESC

#Number of rankings by quality of education
	(Ranking ALL)

SELECT country, count(quality_of_education)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(quality_of_education) DESC

	(Ranking OF top 50)

SELECT country, count(quality_of_education) 
FROM cwurdata c 
WHERE quality_of_education  <=50
GROUP BY country 
ORDER BY count(quality_of_education) DESC

#Number of rankings by alumni employment
	(Ranking ALL)

SELECT country, count(alumni_employment)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(alumni_employment) DESC

	(Ranking OF top 50)

SELECT country, count(alumni_employment) 
FROM cwurdata c 
WHERE alumni_employment  <=50
GROUP BY country 
ORDER BY count(alumni_employment) DESC

#Number of rankings by quality of faculty
	(Ranking ALL)

SELECT country, count(quality_of_faculty)
FROM cwurdata c 
GROUP BY country 
ORDER BY count(quality_of_faculty) DESC

	(Ranking OF top 50)

SELECT country, count(quality_of_faculty) 
FROM cwurdata c 
WHERE quality_of_faculty  <=50
GROUP BY country 
ORDER BY count(quality_of_faculty) DESC

-------------------------------------------------------------------------------------------------------------------------

#Shanghai Academic Rankings for World Universities (ARWU)

#Calculating missing values for Total Score
#(Because the world rank number is either single number or an interval like 100-400 
#which is not suitable for ranking so we will calculate total score for rankings instead)

ALTER TABLE shanghaidata 
ADD COLUMN total_score_new double AFTER total_score;

UPDATE shanghaidata SET total_score_new = 0.1 * alumni + 0.2 * award + 0.2 * hici + 0.2 * ns + 0.2 * pub + 0.1 * pcp;

DELETE FROM shanghaidata WHERE total_score_new IS NULL;

#Best university base on total score by year
SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2005
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2006
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2007
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2008
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2009
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2010
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2011
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2012
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2013
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2014
ORDER BY total_score DESC 
LIMIT 10

SELECT university_name, total_score 
FROM shanghaidata s 
WHERE YEAR = 2015
ORDER BY total_score DESC 
LIMIT 10

#Rankings of alumni, award, hici, ns, pub, pcp by country 

#Alumni
SELECT sact.country, sum(s.alumni) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.alumni) DESC 

#Award
SELECT sact.country, sum(s.award) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.award) DESC 

#Highly cited (Hici)
SELECT sact.country, sum(s.hici) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.hici) DESC 

#Publications (pub)
SELECT sact.country, sum(s.pub) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.pub) DESC 

#Per capita perfomance (pcp)
SELECT sact.country, sum(s.pcp) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.pcp) DESC 

#Nature and Science publications (ns)
SELECT sact.country, sum(s.ns) 
FROM shanghaidata s 
JOIN school_and_country_table sact 
ON s.university_name = sact.school_name 
GROUP BY sact.country 
ORDER BY sum(s.ns) DESC 

-------------------------------------------------------------------------------------------------------------------------

#Times Higher Education (THE) University Rankings

#Replace all null value with 0 to calculate total score
UPDATE timesdata
SET teaching=0 WHERE teaching is NULL

UPDATE timesdata
SET international =0 WHERE international  is NULL

UPDATE timesdata
SET income  =0 WHERE income  is NULL

UPDATE timesdata
SET citations =0 WHERE citations is NULL

UPDATE timesdata
SET research =0 WHERE research is NULL

#Update new total score
ALTER TABLE timesdata 
ADD COLUMN total_score_new double AFTER total_score;

UPDATE timesdata SET total_score_new = 0.3 * teaching + 0.075 * international + 0.3 * research + 0.3 * citations + 0.025 * income;

#Top 10 University each year
SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2011
ORDER BY total_score_new DESC 
LIMIT 10

SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2012
ORDER BY total_score_new DESC 
LIMIT 10

SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2013
ORDER BY total_score_new DESC 
LIMIT 10

SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2014
ORDER BY total_score_new DESC 
LIMIT 10

SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2015
ORDER BY total_score_new DESC 
LIMIT 10

SELECT university_name, total_score
FROM timesdata t 
WHERE `year` = 2016
ORDER BY total_score_new DESC 
LIMIT 10

#Ranking by country for each category over the year

	Teaching
	
SELECT country, sum(teaching) 
FROM timesdata t 
GROUP BY country 
ORDER BY sum(teaching) DESC  
LIMIT 10

	International outlook
	
SELECT country, sum(international) 
FROM timesdata t 
GROUP BY country 
ORDER BY sum(international) DESC  
LIMIT 10

	Research
	
SELECT country, sum(research) 
FROM timesdata t 
GROUP BY country 
ORDER BY sum(research) DESC  
LIMIT 10

	Citations

SELECT country, sum(citations) 
FROM timesdata t 
GROUP BY country 
ORDER BY sum(citations) DESC  
LIMIT 10

	Industry (income)

SELECT country, sum(income) 
FROM timesdata t 
GROUP BY country 
ORDER BY sum(income) DESC  
LIMIT 10

#Clean additional metric data
ALTER TABLE timesdata 
DROP COLUMN international_students_new;

ALTER TABLE timesdata 
ADD COLUMN international_students_new varchar(50) AFTER international_students

UPDATE timesdata 
SET international_students_new = international_students

UPDATE timesdata  
SET international_students_new = REPLACE(international_students_new , '%', '');

-

ALTER TABLE timesdata 
DROP COLUMN female_ratio_new;

ALTER TABLE timesdata 
ADD COLUMN female_ratio_new varchar(50) AFTER female_male_ratio

UPDATE timesdata 
SET female_ratio_new = LEFT(female_male_ratio,2)

#Ranking additional metric

	Full-time equivalent student (num_students)

SELECT university_name, sum(num_students)
FROM timesdata t 
GROUP BY university_name 

SELECT university_name, avg(international_students_new)
FROM timesdata t 
GROUP BY university_name 

SELECT university_name, avg(female_ratio_new)
FROM timesdata t 
GROUP BY university_name 

SELECT university_name, avg(student_staff_ratio)
FROM timesdata t 
GROUP BY university_name 

-------------------------------------------------------------------------------------------------------------------------

#Education Expenditure

#Fixed some data

UPDATE education_expenditure_supplement_data 
SET country = replace(country , '  Brazil', 'Brazil')

UPDATE education_expenditure_supplement_data 
SET country = replace(country , '  Russian Federation', 'Russian Federation')

#%expenditure change over the years for 3 types of expenditure with each direct expenditure type

	#ALL institutions
	
		Public expenditure

SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'All Institutions ' AND `2011` IS NOT NULL 

		Private expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'All Institutions ' AND `2011` IS NOT NULL 		
		
		Total expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'All Institutions ' AND `2011` IS NOT NULL 

	#Elementary and Secondary Institutions

		Public expenditure

SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Elementary and Secondary Institutions ' AND `2011` IS NOT NULL 

		Private expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Elementary and Secondary Institutions ' AND `2011` IS NOT NULL 		
		
		Total expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Elementary and Secondary Institutions ' AND `2011` IS NOT NULL 

	#Higher Education Institutions

		Public expenditure

SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Public' AND institute_type = 'Higher Education Institutions ' AND `2011` IS NOT NULL 

		Private expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Private' AND institute_type = 'Higher Education Institutions ' AND `2011` IS NOT NULL 		
		
		Total expenditure
		
SELECT country, `1995`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `1995` IS NOT NULL 

SELECT country, `2000`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `2000` IS NOT NULL 

SELECT country, `2005`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `2005` IS NOT NULL

SELECT country, `2009`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `2009` IS NOT NULL 

SELECT country, `2010`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `2010` IS NOT NULL 

SELECT country, `2011`
FROM education_expenditure_supplement_data eesd 
WHERE direct_expenditure_type = 'Total' AND institute_type = 'Higher Education Institutions ' AND `2011` IS NOT NULL 

-------------------------------------------------------------------------------------------------------------------------

#Is expenditure alone explaining performance?

#Number of universities in top
SELECT country, count(institution)
FROM cwurdata c 
WHERE YEAR = 2012
GROUP BY country 
ORDER BY count(institution) desc
LIMIT 10

#Total education expenditure
SELECT country, avg(`2011`) AS ratio
FROM education_expenditure_supplement_data eesd 
WHERE institute_type = 'Higher Education Institutions ' AND direct_expenditure_type = 'Total'
GROUP BY country 
ORDER BY avg(`2011`) DESC 

#Using UN Dataset
#Fixed some country names
UPDATE country_profile_variables 
SET country = REPLACE(country,'United States of America','United States')

UPDATE country_profile_variables 
SET country = REPLACE(country,'Czechia','Czech Republic')

UPDATE country_profile_variables 
SET country = REPLACE(country,'Republic of Korea','Korea, Republic of')

UPDATE country_profile_variables 
SET country = REPLACE(country,'Slovakia','Slovak Republic')

#Total education expenditure
WITH A AS 
(
	SELECT country, avg(`2011`) AS ratio
	FROM education_expenditure_supplement_data eesd 
	WHERE institute_type = 'Higher Education Institutions ' AND direct_expenditure_type = 'Total'
	GROUP BY country
)
SELECT A.country, A.ratio, cpv.GPD 
FROM A 
LEFT JOIN country_profile_variables cpv 
ON A.country = cpv.country 

ALTER TABLE table_name ADD new_column_name column_definition [ FIRST | AFTER column_name ];

ALTER TABLE a 
ADD total_education_expenditure double AFTER GPD

UPDATE a 
SET total_education_expenditure = GPD * ratio /100/1000

SELECT a.country, a.total_education_expenditure, count(c.institution)
FROM a 
LEFT JOIN cwurdata c 
ON a.country = c.country 
WHERE c.YEAR = 2012
GROUP BY a.country, a.total_education_expenditure
ORDER BY a.total_education_expenditure DESC, count(c.institution) DESC 