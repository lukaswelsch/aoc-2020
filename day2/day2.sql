
drop table if exists aoc2 ;

create table aoc2 (bereich varchar(5), wert varchar(1), eingabe varchar(40));

load data local infile '/tmp/aoc2' into table aoc2 fields terminated by " " LINES TERMINATED BY '\n' (bereich,wert,eingabe);

/*part1*/
SELECT COUNT(*)
FROM 
(
SELECT SUBSTRING_INDEX(bereich,'-',1) AS part1, SUBSTRING_INDEX(bereich,'-',-1) AS part2, wert, eingabe, LENGTH(eingabe) - LENGTH(REPLACE(eingabe, wert, '')) AS anzahl
from aoc2
) as t
WHERE t.anzahl >= part1  AND  t.anzahl <= part2


/*part2*/
SELECT COUNT(*)
FROM 
(
SELECT wert, eingabe, SUBSTRING(eingabe,SUBSTRING_INDEX(bereich,'-',1),1) AS part3, SUBSTRING(eingabe,SUBSTRING_INDEX(bereich,'-',-1),1) AS part4
from aoc2
) as t
WHERE t.part3 = t.wert XOR t.part4 = t.wert

