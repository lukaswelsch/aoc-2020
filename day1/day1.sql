drop table if exists aoc1 ;

create table aoc1 (num int);

load data local infile '/tmp/aoc1.txt' into table aoc1 fields terminated by " " LINES TERMINATED BY '\n' (num);

/*part1*/
select distinct (a.num * b.num) from aoc1 a join aoc1 b where a.num + b.num = 2020;

/*part2*/
select distinct (a.num * b.num * c.num) from aoc1 a join aoc1 b join aoc1 c where a.num + b.num + c.num = 2020;

