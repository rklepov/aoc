// 2022/q/08.q
//
// https://adventofcode.com/2022/day/8

inp:read0`:./input/08.txt;
-1"";

left:(');
right:{(reverse x reverse@)'};
top:{flip left[x]flip@};
bottom:{flip right[x]flip@};

grid:"I"$/:/:inp;

// part 1
deltas1:{[n;v](n+first v)-':v};
look:0<deltas1[-1]maxs@;

r:sum raze(or/)@\:[(left;right;top;bottom);look]@\:grid;
show"j"$r; / 1681

// part 2
look:{({y-x}.-2#0,where@)each 0>=x-(,\)x};

r:(max/)(*/)@\:[(left;right;top;bottom);look]@\:grid;
show r; / 201684

exit 0;

// __EOF__
