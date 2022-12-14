// 2022/q/09.q
//
// https://adventofcode.com/2022/day/9

motions:flip`dir`len!("SI";" ")0:`:./input/09.txt;
-1"";

controls:`R`L`U`D!0 1 cross 1 -1;

start:0 0;

move:{[co;xy;dir;len]
  @[xy;co[dir;0];+;len*co[dir;1]]
 };

moves:move[controls]\[start]. motions`dir`len;

dm:deltas moves;
expand:({s:signum y;(s+x-y)+s*til abs y};{y#x})(0=dm);

// head path
hpath:enlist[start],raze flip each expand(.)''moves(,\:)'(dm@'0<>dm)[;1];

tail:{[t;h]
  if[all 1>=abs h-t;:t];
  t+signum h-t
 };

// part 1
tpath:tail\[hpath];
show count distinct tpath; / 6332

// part 2
tpath:9(tail\)/hpath;
show count distinct tpath; / 2511

exit 0;

// __EOF__
