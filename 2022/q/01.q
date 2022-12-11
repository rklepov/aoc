// 2022/q/01.q
//
// https://adventofcode.com/2022/day/1

inp:((enlist"I";" ")0:`:input/01.txt)0;

// simple solution
-1"";

// part 1
show{max(sum')(0,where[null x])_x}inp;
// part 2
show{sum 3#desc(sum')(0,where[null x])_x}inp;

// "corporate style" solution
-1"";

t:{id:sums null x;select from([]id;cal:x)where not null cal}inp;

s:select sum cal by id from t;

sumTop:{[s;n]exec sum cal from s where n>rank neg cal};

// part 1
show sumTop[s]1; / 71502
// part 2
show sumTop[s]3; / 208191

exit 0;

// __EOF__
