Challenge 1 – Who Have Published What At Where?
SELECT
    a.au_id      AS "AUTHOR ID",
    a.au_lname   AS "LAST NAME",
    a.au_fname   AS "FIRST NAME",
    t.title      AS "TITLE",
    p.pub_name   AS "PUBLISHER"
FROM authors AS a
JOIN titleauthor AS ta ON a.au_id = ta.au_id
JOIN titles      AS t  ON ta.title_id = t.title_id
JOIN publishers  AS p  ON t.pub_id   = p.pub_id
ORDER BY a.au_id, t.title;


Each row corresponds to one record in titleauthor, so the row count should match that table.

Challenge 2 – Who Have Published How Many At Where?
SELECT
    a.au_id                     AS "AUTHOR ID",
    a.au_lname                  AS "LAST NAME",
    a.au_fname                  AS "FIRST NAME",
    p.pub_name                  AS "PUBLISHER",
    COUNT(*)                    AS "TITLE COUNT"
FROM authors AS a
JOIN titleauthor AS ta ON a.au_id   = ta.au_id
JOIN titles      AS t  ON ta.title_id = t.title_id
JOIN publishers  AS p  ON t.pub_id  = p.pub_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname,
    p.pub_name
ORDER BY a.au_id, p.pub_name;


If you sum "TITLE COUNT" from this result it should equal the number of rows in titleauthor.

Challenge 3 – Best Selling Authors (Top 3)

(Using total quantity sold from the sales table.)

SELECT
    a.au_id                   AS "AUTHOR ID",
    a.au_lname                AS "LAST NAME",
    a.au_fname                AS "FIRST NAME",
    SUM(s.qty)                AS "TOTAL"
FROM authors AS a
JOIN titleauthor AS ta ON a.au_id    = ta.au_id
JOIN titles      AS t  ON ta.title_id = t.title_id
JOIN sales       AS s  ON t.title_id = s.title_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname
ORDER BY "TOTAL" DESC
LIMIT 3;

Challenge 4 – Best Selling Authors Ranking (All Authors, including 0)
SELECT
    a.au_id                              AS "AUTHOR ID",
    a.au_lname                           AS "LAST NAME",
    a.au_fname                           AS "FIRST NAME",
    COALESCE(SUM(s.qty), 0)              AS "TOTAL"
FROM authors AS a
JOIN titleauthor AS ta ON a.au_id    = ta.au_id
JOIN titles      AS t  ON ta.title_id = t.title_id
LEFT JOIN sales  AS s  ON t.title_id = s.title_id
GROUP BY
    a.au_id,
    a.au_lname,
    a.au_fname
ORDER BY "TOTAL" DESC;


This includes all authors (even if none of their titles appear in sales) and shows 0 instead of NULL for those with no sales.