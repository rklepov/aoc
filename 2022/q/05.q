// 2022/q/05.q
//
// https://adventofcode.com/2022/day/5

inp:read0`:./input/05.txt;
-1"";

lineSep:first where 0=count each inp;
lineNum:lineSep-1;

split:{r:x group s:sums differ w:x>" ";r distinct s where w};
n:count"J"$split inp lineNum;

stacks:trim flip(inp til lineNum)@\:where@[((n-1)+n*3)#0b;1+4*til n;:;1b];

range:{[s;e]s+til 1+e-s};

moves:@[;1 2;-;1](" J J J";" ")0:inp range[lineSep+1;count[inp]-1];

crane:{[rev;s;c;f;t]
  s[t]:rev[c#s f],s t;
  s[f]:c _s f;
  s
 };

// part 1
r:crane[reverse]/[stacks]. moves;
show first each r; / TWSGQHNHL

// part 2
r:crane[::]/[stacks]. moves;
show first each r; / JNRSCDWPP

exit 0;

// __EOF__
