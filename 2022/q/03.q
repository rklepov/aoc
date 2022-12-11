// 2022/q/03.q
//
// https://adventofcode.com/2022/day/3

inp:read0`:./input/03.txt;
-1"";

// part 1
r:sum 1+.Q.an?(first(inter).)'[2 0N#/:inp];
show r; / 8401

// part 2
r:sum 1+.Q.an?(first(inter/)@)'[0N 3#inp];
show r; / 2641

exit 0;

// __EOF__
