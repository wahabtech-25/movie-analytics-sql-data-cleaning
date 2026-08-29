                                           ---Investigation--- 

--count the total rows and NULL in the data set coloumn wise--
                                --Overall Picture--

USE MovieAnalytics;
GO
SELECT
    COUNT(*) AS total_rows,

    SUM(CASE WHEN title IS NULL OR lTRIM(RTRIM(title)) = '' THEN 1 ELSE 0 END) AS title_missing,

    SUM(CASE WHEN release_year IS NULL OR LTRIM(RTRIM(release_year)) = '' THEN 1 ELSE 0 END) AS year_missing,

    SUM(CASE WHEN release_month IS NULL OR LTRIM(RTRIM(release_month)) = '' THEN 1 ELSE 0 END) AS month_missing,

    SUM(CASE WHEN release_day IS NULL OR LTRIM(RTRIM(release_day)) = '' THEN 1 ELSE 0 END) AS day_missing,

    SUM(CASE WHEN genres IS NULL OR LTRIM(RTRIM(genres)) = '' THEN 1 ELSE 0 END) AS genres_missing,

    SUM(CASE WHEN rating_out_of_10 IS NULL OR LTRIM(RTRIM(rating_out_of_10)) = '' THEN 1 ELSE 0 END) AS rating_missing,

    SUM(CASE WHEN vote_count IS NULL OR LTRIM(RTRIM(vote_count)) = '' THEN 1 ELSE 0 END) AS votes_missing,

    SUM(CASE WHEN runtime_minutes IS NULL OR LTRIM(RTRIM(runtime_minutes)) = '' THEN 1 ELSE 0 END) AS runtime_missing,

    SUM(CASE WHEN box_office_usd IS NULL OR LTRIM(RTRIM(box_office_usd)) = '' THEN 1 ELSE 0 END) AS box_office_missing,

    SUM(CASE WHEN budget_usd IS NULL OR LTRIM(RTRIM(budget_usd)) = '' THEN 1 ELSE 0 END) AS budget_missing,

    SUM(CASE WHEN director IS NULL OR LTRIM(RTRIM(director)) = '' THEN 1 ELSE 0 END) AS director_missing,

    SUM(CASE WHEN screenwriter IS NULL OR LTRIM(RTRIM(screenwriter)) = '' THEN 1 ELSE 0 END) AS screenwriter_missing,

    SUM(CASE WHEN [cast] IS NULL OR LTRIM(RTRIM([cast])) = '' THEN 1 ELSE 0 END) AS cast_missing,

    SUM(CASE WHEN production_company IS NULL OR LTRIM(RTRIM(production_company)) = '' THEN 1 ELSE 0 END) AS production_missing,

    SUM(CASE WHEN content_rating IS NULL OR LTRIM(RTRIM(content_rating)) = '' THEN 1 ELSE 0 END) AS content_rating_missing,

    SUM(CASE WHEN language IS NULL OR LTRIM(RTRIM(language)) = '' THEN 1 ELSE 0 END) AS language_missing,

    SUM(CASE WHEN country IS NULL OR LTRIM(RTRIM(country)) = '' THEN 1 ELSE 0 END) AS country_missing,

    SUM(CASE WHEN synopsis IS NULL OR LTRIM(RTRIM(synopsis)) = '' THEN 1 ELSE 0 END) AS synopsis_missing,

    SUM(CASE WHEN wikipedia_url IS NULL OR LTRIM(RTRIM(wikipedia_url)) = '' THEN 1 ELSE 0 END) AS wikipedia_missing,

    SUM(CASE WHEN poster_url IS NULL OR LTRIM(RTRIM(poster_url)) = '' THEN 1 ELSE 0 END) AS poster_missing

                                 --Null values coloumn wise--
FROM raw_movies;
Select title from raw_movies;

Select release_day, count(*) as count from raw_movies
group by release_day;

Select * from raw_movies
where release_day iS NULL or 
TRIM(release_day) = '';

Select * from raw_movies
where director iS NULL or 
TRIM(director) = '';
Select director, count(*) from raw_movies
group by director;

                                                 --Duplicates--

Select title, count(*) As duplicate_title from raw_movies
group by title
having count(*)>1;

Select * from raw_movies
where title='The long game';
                                
                                ---Data Type conversion compatiity (column wise)---

SELECT *
FROM raw_movies
WHERE TRY_CAST(release_year AS INT) IS NULL
  AND release_year IS NOT NULL;

  SELECT *
FROM raw_movies
WHERE TRY_CAST(release_day AS INT) IS NULL
  AND release_day IS NOT NULL;
 
 SELECT * FROM 
 raw_movies
 Where TRY_CAST(rating_out_of_10 AS decimal) IS NULL AND 
 rating_out_of_10 is not NULL;

  SELECT * FROM 
 raw_movies
 Where TRY_CAST(vote_count AS bigint) IS NULL AND 
 vote_count is not NULL;

 SELECT * FROM 
 raw_movies
 Where TRY_CAST(runtime_minutes AS INT) IS NULL AND 
  runtime_minutes is not NULL;

   SELECT * FROM 
 raw_movies
 Where TRY_CAST(box_office_usd AS BIGINT) IS NULL AND 
  box_office_usd is not NULL;

    SELECT * FROM 
 raw_movies
 Where TRY_CAST(budget_usd AS BIGINT) IS NULL AND 
  budget_usd is not NULL;

                              ---Logically data investigation range validation---

Select release_day From raw_movies;

Select release_day from raw_movies 
where release_day>0 AND release_day<32;

Select release_day from raw_movies 
where release_day>32;

SELECT SUM(duplicate_count) AS duplicates
FROM (
    SELECT
        release_day,
        COUNT(*) AS duplicate_count
    FROM raw_movies
    WHERE release_day > 0
      AND release_day < 32
    GROUP BY release_day
    HAVING COUNT(*) > 1
) As duplicate_count;

Select rating_out_of_10 from raw_movies
Where rating_out_of_10 >'0' ;

Select vote_count from raw_movies
where vote_count<0;

Select runtime_minutes from raw_movies
where runtime_minutes<0;

Select release_year from raw_movies
where release_year>2026;

Select budget_usd from raw_movies
where budget_usd<0;

Select box_office_usd from raw_movies
where box_office_usd<0;

Select vote_count from raw_movies
where vote_count<0;

                              ----Text Investigation---(exra Spaces)---

Select title from raw_movies
where Trim(title) != title;

Select release_month from raw_movies
where Trim(release_month)!= release_month;


Select release_year from raw_movies
where Trim(release_year)!= release_year;


Select director from raw_movies
where Trim(genres)!= genres;


Select director from raw_movies
where Trim(director)!= director;

Select screenwriter from raw_movies
where Trim(screenwriter)!= screenwriter;

Select cast from raw_movies
where Trim([cast])!= [cast];

Select production_company from raw_movies
where Trim(production_company)!= production_company;

Select content_rating from raw_movies
where Trim(content_rating)!= content_rating;

Select language from raw_movies
where Trim(language)!= language;

Select country from raw_movies
where Trim (country) != country;

Select synopsis from raw_movies
where Trim (synopsis) != synopsis;

Select wikipedia_url from raw_movies
where Trim (wikipedia_url) != wikipedia_url;

Select poster_url from raw_movies
where Trim (poster_url) != poster_url;

                                     ---Data consistency---

SELECT language, count(*) As check_english
FROM raw_movies
GROUP BY language
having language !='English';

Select language from raw_movies;

SELECT content_rating, count(*) As check_content_rating
FROM raw_movies
where content_rating !='PG-13' OR content_rating !='R'
GROUP BY content_rating;

SELECT country, count(*) As check_english
FROM raw_movies
GROUP BY country
having country ='United States';
                                    --Comma(,) and (/) related issues----
SELECT genres, COUNT(*) AS gen
FROM raw_movies
where genres like '%,%'
GROUP BY genres;


SELECT director, COUNT(*) AS dier
FROM raw_movies
where director like '%,%'
GROUP BY director;

SELECT director
FROM raw_movies
WHERE director LIKE '%,[^ ]%';

SELECT COUNT(*) AS missing_space_count
FROM raw_movies
WHERE director LIKE '%,[^ ]%';

SELECT 
    director AS old_director,
    REPLACE(director, ',', ', ') AS new_director
FROM raw_movies
WHERE director NOT LIKE '%,[^ ]%' OR director LIKE '%,[^ ]%';

SELECT 
    director AS old_director,
    REPLACE(director, ',', ', ') AS new_director
FROM raw_movies
WHERE REPLACE(director, ',', ', ') LIKE '%,[^ ]%';

Select screenwriter from raw_movies
where screenwriter Like '%,%';

Select screenwriter, count(*) from raw_movies
group by screenwriter
having count(*)>1;

Select screenwriter, Replace(screenwriter,',',', ') As newScreen from raw_movies
where screenwriter Like '%,[^ ]%';

select * from raw_movies where screenwriter='Andy Mayson';

Select screenwriter, Replace(screenwriter,',',', ') As newScreen from raw_movies
where replace (screenwriter, ',', ', ') like '%,[^ ]%';

SELECT [cast]
FROM raw_movies
WHERE [cast] LIKE '%,[^ ]%';

Select [cast], Replace([cast],',',', ') As newcast from raw_movies
where [cast] Like '%,[^ ]%';

Select [cast], Replace([cast],',',', ') As newcast from raw_movies
where replace ([cast], ',', ', ') like '%,[^ ]%';

Select production_company from raw_movies
where production_company Like '%/[^ ]%';

Select production_company, Replace(production_company,'/',' / ') As newprod from raw_movies
where production_company Like '%/[^ ]%';

Select production_company, Replace(production_company,'/',' / ') As newcast from raw_movies
where replace (production_company, '/', ' / ') like '%/[^ ]%';

Select synopsis, count(*) from raw_movies
group by synopsis;

Select production_company, Replace(production_company,'/',' / ') As newcast from raw_movies
where replace (production_company, '/', ' / ') like '%/[^ ]%';

SELECT synopsis
FROM raw_movies
WHERE synopsis LIKE '%,[^ ]%';

SELECT synopsis
FROM raw_movies
WHERE synopsis LIKE '%/[^ ]%';

Select synopsis, Replace(synopsis,',',', ') As newsyn from raw_movies
where replace (synopsis, ',', ', ') like '%,[^ ]%';

Select synopsis, Replace(synopsis,'/',' / ') As newsyn from raw_movies
where replace (synopsis, '/', ' / ') like '%/[^ ]%';
                                    
                                    ---(url) logic check----
SELECT wikipedia_url
FROM raw_movies
WHERE wikipedia_url NOT LIKE 'https://%'
  AND wikipedia_url NOT LIKE 'http://%';

  SELECT wikipedia_url
FROM raw_movies
WHERE wikipedia_url  LIKE 'https://%'
  AND wikipedia_url NOT LIKE 'http://%';

  SELECT poster_url
FROM raw_movies
WHERE poster_url NOT LIKE 'https://%'
  AND poster_url NOT LIKE 'http://%';

  SELECT poster_url
FROM raw_movies
WHERE poster_url  LIKE 'https://%'
  AND poster_url NOT LIKE 'http://%';
                                      
                                      ---(Date logic check)---

Select Sum(month_count) as Sumcount 
from
  (SELECT release_month, COUNT(*) AS month_count
FROM raw_movies
GROUP BY release_month
) as counted;

SELECT *
FROM raw_movies
WHERE release_month IN ('April', 'June', 'September', 'November')
  AND release_day > 30;

  SELECT *
FROM raw_movies
WHERE release_month = 'February'
  AND release_day > 28;

  SELECT *
FROM raw_movies
WHERE release_year < 2024
   OR release_year > 2026;

   Select * from raw_movies;