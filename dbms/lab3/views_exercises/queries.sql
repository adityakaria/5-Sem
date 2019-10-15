-- Question 1 --
-- Create View tns --
CREATE
OR REPLACE VIEW tns AS
SELECT
  m.title,
  rv.name,
  r.stars
FROM
  (
    (
      Rating r
      INNER JOIN Movie m ON r.mID = m.mID
    )
    INNER JOIN Reviewer rv ON rv.rID = r.rID
  );
-- Query 1 --
SELECT
  t.title,
  m.year
FROM
  tns t
  INNER JOIN Movie m ON m.title = t.title
WHERE
  t.name = "Chris Jackson"
ORDER BY
  m.year DESC
LIMIT
  1;
-- Creating RatingStats view --
  CREATE
  OR REPLACE VIEW RatingStats AS
SELECT
  t.title,
  COUNT(*) no_of_reviews,
  AVG(t.stars) avg_rating
FROM
  tns t
GROUP BY
  t.title
HAVING
  COUNT(t.title) >= 1;
-- Query 2 --
SELECT
  title
FROM
  RatingStats
WHERE
  no_of_reviews >= 3
GROUP BY
  title
ORDER BY
  avg_rating DESC
LIMIT
  1;
-- Creating Favourites View --
  CREATE
  OR REPLACE VIEW Favourites AS
SELECT
  r.mID,
  r.rID,
  r.stars
FROM
  (
    (
      Rating r
      INNER JOIN Movie m ON r.mID = m.mID
    )
    INNER JOIN Reviewer rv ON rv.rID = r.rID
  )
WHERE
  r.stars = (
    SELECT
      MAX(Stars)
    FROM
      Rating
    WHERE
      rID = rv.rID
  )
GROUP BY
  r.mID,
  r.rID,
  r.stars;
-- Query 3 --
SELECT
  *
from
  (
    (
      (
        Favourites f
        INNER JOIN Movie m on m.mID = f.mID
      )
      INNER JOIN Reviewer rv1 on rv1.rID = f.rID
    )
    INNER JOIN Reviewer rv2 on rv2.rID = f.rID
  );
-- Query 3 test --
SELECT
  DISTINCT CASE
    WHEN re1.name > re2.name THEN re2.name
    ELSE re1.name
  END AS "Reviewer 1",
  CASE
    WHEN re1.name < re2.name THEN re2.name
    ELSE re1.name
  END AS "Reviewer 2",
  mo.title AS "Movie"
FROM
  Reviewer re1,
  Reviewer re2,
  Movie mo
WHERE
  re1.rID IN (
    SELECT
      rID
    FROM
      Favourites
    WHERE
      mID = mo.mID
  )
  AND re2.rID IN (
    SELECT
      rID
    FROM
      Favourites
    WHERE
      mID = mo.mID
  )
  AND re1.rID != re2.rID;