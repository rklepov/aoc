// 2022/q/06.q
//
// https://adventofcode.com/2022/day/6

inp:read0`:./input/06.txt;

// straightforward solution
-1"";

f:{[s;n]n+first where(n=count distinct n#)each(1_)\[s]};

// part 1
r:f[inp 0;4];
show r; / 1356

// part 2
r:f[inp 0;14];
show r; / 2564

// alternative solution (arguably more efficient)
-1"";

g:{[s;n]n+first where(n=count distinct@)each s til[n]+/:til count[s]-n-1}

// part 1
r:g[inp 0;4];
show r; / 1356

// part 2
r:g[inp 0;14];
show r; / 2564

exit 0;

// __EOF__
