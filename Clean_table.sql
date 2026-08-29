CREATE TABLE clean_movies
(
    title NVARCHAR(255),
    release_year INT,
    release_month NVARCHAR(20),
    release_day INT,
    genres NVARCHAR(255),
    rating_out_of_10 DECIMAL(3,1),
    vote_count BIGINT,
    runtime_minutes INT,
    box_office_usd BIGINT,
    budget_usd BIGINT,
    director NVARCHAR(500),
    screenwriter NVARCHAR(500),
    [cast] NVARCHAR(1000),
    production_company NVARCHAR(500),
    content_rating NVARCHAR(20),
    language NVARCHAR(50),
    country NVARCHAR(100),
    synopsis NVARCHAR(MAX),
    wikipedia_url NVARCHAR(1000),
    poster_url NVARCHAR(1000)
);

INSERT INTO clean_movies
(
    title,
    release_year,
    release_month,
    release_day,
    genres,
    rating_out_of_10,
    vote_count,
    runtime_minutes,
    box_office_usd,
    budget_usd,
    director,
    screenwriter,
    [cast],
    production_company,
    content_rating,
    language,
    country,
    synopsis,
    wikipedia_url,
    poster_url
)
SELECT
    TRIM(title),
    TRY_CAST(release_year AS INT),
    TRIM(release_month),
    TRY_CAST(release_day AS INT),
    TRIM(genres),
    TRY_CAST(rating_out_of_10 AS DECIMAL(3,1)),
    TRY_CAST(vote_count AS BIGINT),
    TRY_CAST(runtime_minutes AS INT),
    TRY_CAST(box_office_usd AS BIGINT),
    TRY_CAST(budget_usd AS BIGINT),

    REPLACE(director, ',', ', '),

    TRIM(screenwriter),
    TRIM([cast]),
    TRIM(production_company),
    TRIM(content_rating),
    TRIM(language),
    TRIM(country),
    TRIM(synopsis),
    TRIM(wikipedia_url),
    TRIM(poster_url)

FROM raw_movies;

Select * from clean_movies;

SELECT director
FROM clean_movies
WHERE director LIKE '%,[^ ]%';

SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN release_day IS NULL THEN 1 ELSE 0 END) AS release_day_null,
    SUM(CASE WHEN director IS NULL THEN 1 ELSE 0 END) AS director_null,
    SUM(CASE WHEN screenwriter IS NULL THEN 1 ELSE 0 END) AS screenwriter_null
FROM clean_movies;

SELECT *
FROM clean_movies
WHERE release_day < 1
   OR release_day > 31
   OR rating_out_of_10 < 0
   OR rating_out_of_10 > 10
   OR vote_count < 0
   OR runtime_minutes < 0
   OR box_office_usd < 0
   OR budget_usd < 0;

   SELECT
    title,
    release_year,
    COUNT(*) AS duplicate_count
FROM clean_movies
GROUP BY title, release_year
HAVING COUNT(*) > 1;

SELECT *
FROM clean_movies
WHERE release_month IN ('April', 'June', 'September', 'November')
  AND release_day > 30;

  SELECT *
FROM clean_movies
WHERE release_month = 'February'
  AND release_day > 28;

  SELECT *
FROM clean_movies
WHERE release_year < 2024
   OR release_year > 2026;