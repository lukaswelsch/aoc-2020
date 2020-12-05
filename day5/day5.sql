drop table if exists aoc5 ;
create table aoc5(inp varchar(100));

load data local infile '/tmp/aoc5' into table aoc5 LINES TERMINATED BY '\n' (inp) ;


drop table if exists aoc5t ;
create table aoc5t (_row varchar(8), _column  varchar(3))

INSERT INTO aoc5t 
(
_row, _column
)
SELECT 
SUBSTRING(inp, 1, 7) as _row,
SUBSTRING(inp, 8, 3) as _column
FROM aoc5

/*part1*/
SELECT MAX((CAST(_row AS INT) * 8 + CAST(_column AS INT))) AS test
FROM 
(
SELECT (CONV(REPLACE(REPLACE(_row, 'B', 1), 'F',0),2,10)) AS _row, CONV(REPLACE(REPLACE(_column, 'R', 1), 'L',0),2,10) AS _column
FROM aoc5t
)t


/*part2*/
SELECT CAST(_row AS INT) AS _row, COUNT(_row) as missing_seat
FROM 
(
SELECT (CONV(REPLACE(REPLACE(_row, 'B', 1), 'F',0),2,10)) AS _row, CONV(REPLACE(REPLACE(_column, 'R', 1), 'L',0),2,10) AS _column
FROM aoc5t
)t
WHERE _row != 11 AND _row != 104
GROUP BY _row
HAVING COUNT(_row) = 7

SELECT CAST((CONV(REPLACE(REPLACE(_row, 'B', 1), 'F',0),2,10))AS INT) AS _row, CONV(REPLACE(REPLACE(_column, 'R', 1), 'L',0),2,10) AS _column
FROM aoc5t
ORDER BY _row, _column
