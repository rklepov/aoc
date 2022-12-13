// 2022/q/08.q
//
// https://adventofcode.com/2022/day/8

inp:read0`:./input/08.txt;
-1"";

frame:{[v;g]
  f:type[g 0]$v;
  g:f,/:g,\:f;
  F:enlist count[g 0]#f;
  F,g,F
 };

left:(0<deltas maxs@)';
right:(reverse')left(reverse')@;
top:flip left flip@;
bottom:flip right flip@;

grid:frame[-1]"I"$/:/:inp;

// part 1
r:sum raze(or/)(left;right;top;bottom)@\:grid;
show r; / 1681

// part 2



exit 0;

// __EOF__
