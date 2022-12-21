// 2022/q/08.q
//
// https://adventofcode.com/2022/day/8

inp:read0`:./input/08.txt;
-1"";

fr:flip reverse@;
rf:reverse flip@;

nwse:{x rf/y x fr/ z}@/:til 4; / North, West, South, East

grid:"I"$/:/:inp;

// part 1
deltas1:{[n;v](n+first v)-':v};
look:0<deltas1[-1]maxs@;

// TODO: there's probably no need to do full forth and back matrix rotation for
// each look operation.
r:sum raze(or/)(nwse@\:look)@\:grid;
show"j"$r; / 1681

// part 2
look:{({y-x}.-2#0,where@)each 0>=x-(,\)x}';

r:(max/)(*/)(nwse@\:look)@\:grid;
show r; / 201684

exit 0;

// __EOF__
