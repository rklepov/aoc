// 2022/q/08.q
//
// https://adventofcode.com/2022/day/8

inp:read0`:./input/08.txt;
-1"";

deltas1:{(-1+first x)-':x};

left:(0<deltas1 maxs@)';
right:(reverse')left(reverse')@;
top:flip left flip@;
bottom:flip right flip@;

grid:"I"$/:/:inp;

// part 1
r:sum raze(or/)(left;right;top;bottom)@\:grid;
show r; / 1681

// part 2



exit 0;

// __EOF__
