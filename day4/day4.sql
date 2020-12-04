load data local infile '/tmp/aoc4' into table aoc4 LINES TERMINATED BY '\n' (inp) ;


drop table if exists aoc4 ;
create table aoc4(inp varchar(100));

load data local infile '/tmp/aoc4' into table aoc4 LINES TERMINATED BY '\n\n' (inp) ;

/*part1*/
SELECT  *
from aoc4
where inp like '%byr%'
AND inp like '%iyr%'
AND inp like '%eyr%'
AND inp like '%hgt%'
AND inp like '%hcl%'
AND inp like '%ecl%'
AND inp like '%pid%';



drop table if exists aoc4t ;
create table aoc4t (byr varchar(5), iyr  varchar(5), eyr  varchar(5), hgtcm varchar(10), hgtin varchar(10), hcl varchar(20), ecl varchar(20), pid varchar(20), cid varchar(10));


INSERT INTO aoc4t(byr,iyr,eyr,hgt,hcl,ecl,pid)
SELECT 
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'byr:'),8), 5, 4) as byr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'iyr:'),8), 5, 4) as iyr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'eyr:'),8), 5, 4) as eyr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'hgt:'),9), 5, 6) as hgt,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'hcl:'),8), 5, 7) as hcl,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'ecl:'),8), 5, 3) as ecl,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'pid:'),8), 5, 9) as pid
from aoc4;




SELECT SUBSTRING(SUBSTRING(inp,INSTR(inp, 'byr:'),8), 5, 4)
from aoc4
where inp like '%byr%' AND SUBSTRING(SUBSTRING(inp,INSTR(inp, 'byr:'),8), 5, 4) > 1920 
AND inp like '%iyr%'
AND inp like '%eyr%'
AND inp like '%hgt%'
AND inp like '%hcl%'
AND inp like '%ecl%'
AND inp like '%pid%';



drop table if exists aoc4t ;
create table aoc4t (byr varchar(6), iyr  varchar(5), eyr  varchar(5), hgtcm varchar(10), hgtin varchar(10), hcl varchar(20), ecl varchar(20), pid varchar(20), cid varchar(10));


INSERT INTO aoc4t(hgtcm, hgtin, byr,iyr,eyr,hcl,ecl,pid)
SELECT 
CASE 
	WHEN INSTR(hgt, 'cm') > 0 THEN REPLACE(hgt, 'cm', '')
	ELSE NULL
END AS hgtcm,
CASE
	WHEN INSTR(hgt, 'in') > 0 THEN REPLACE(hgt, 'in', '') 
	ELSE NULL
END AS hgtin,
byr,iyr,eyr,hcl,ecl,pid
FROM 
(
SELECT
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'byr:'),12), 5, 4) as byr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'iyr:'),9), 5, 4) as iyr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'eyr:'),9), 5, 4) as eyr,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'hgt:'),9), 5, 6) as hgt,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'hcl:'),12), 5, 7) as hcl,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'ecl:'),9), 5, 3) as ecl,
SUBSTRING(SUBSTRING(inp,INSTR(inp, 'pid:'),17), 5, 10) as pid
FROM
aoc4
) r;


/*part2*/
SELECT COUNT(*) 
FROM aoc4t
WHERE byr BETWEEN 1920 AND 2002
AND iyr BETWEEN 2010 AND 2020
AND eyr BETWEEN 2020 AND 2030
AND (hgtcm BETWEEN 150 AND 193 OR hgtin BETWEEN 59 AND 76)
AND hcl REGEXP '^#([0-9a-f]{6})'
AND ecl IN ('amb','blu','brn','gry','grn','hzl','oth')
AND pid REGEXP '^[0-9]{9}'
AND LENGTH(TRIM(REPLACE(pid,'\n',''))) = 9

