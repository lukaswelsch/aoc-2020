drop table if exists aoc3 ;
create table aoc3 (inp varchar(100), id int);

load data local infile '/tmp/aoc3' into table aoc3 LINES TERMINATED BY '\n' (inp) ;



SET @row_number = -1; 
SELECT EXP(SUM(LN(sum_all))) AS result
FROM (
SELECT down,rght
,sum(
CASE
 WHEN (id-down)%down = 0 THEN  (SUBSTRING(REPLACE(REPLACE(inp,'#','1'),'.','0'), 1+(rght*((id)/down))%LENGTH(inp),1) ) 
 ELSE 0
END 
) AS sum_all
FROM
(
SELECT inp, (@row_number:=@row_number+1) AS id
FROM aoc3
) a
JOIN (
	SELECT 1 AS rght, 1 AS down
	UNION SELECT 3 AS rght, 1 AS down
	UNION SELECT 5 AS rght, 1 AS down 
	UNION SELECT 7 AS rght, 1 AS down 
	UNION SELECT 1 AS rght, 2 AS down
) AS t
GROUP BY down,rght
) t1;

