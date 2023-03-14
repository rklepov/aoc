// 2022/q/16.q
//
// https://adventofcode.com/2022/day/16

/ inp:read0`:./input/16.txt;
inp:read0`:./test/16.txt;

split:{[pred;v]
  g:v group s:sums differ w:pred v;
  g distinct s where not w
 };

words:split[in[;"= ,;"]]each inp;

conv:{[r;b;s]
  n:("i"$'s)-"i"$b;
  {[r;v;d]v+d*r}[r]/[reverse n]
 };

vonc:{[r;b;n]
  "c"$("i"$b)+(reverse{[r;v]0<v div r}[r]div[;r]\n)mod r
 };

radix:1+(-/)"i"$"ZA";

conv26:conv[radix;"A"];

vonc26:"A"^-2$vonc[radix;"A"]::;

// The model of a cave:
// [v]alve id (a number converted from the 2 character code)
// [f]low [r]ate of a valve
// [adj]acent valves list
cave:1!`v xasc flip`v`fr`adj!(conv26';"J"$;(asc(conv26')::)')@'(words[;1];words[;5];10_'words);

// part 1
-1"";

// total pressure
tp:{[cave;open]
  sum cave[([]v:open);`fr]
 };

/ The rather straightforward "dynamic programming" algorithm with the recursive
/ graph traversal. While the logic tries to avoid the exhaustive search and cut
/ some branches i.e. skip the paths which won't improve the total score, but
/ overall it's still very slow for a high dimensional input. For example
/ although on the test input with 10 rooms it takes several seconds to find the
/ maximum released pressure but on the main task input with 60 rooms it took
/ about 33hr to complete on my laptop.
traverse:{[cave;T;left;vmop;open;vid]
  / if[0= count[.Q.v vmop]mod 10000;
  /   -1(string[`second$.z.T]," ",string count .Q.v vmop);
  / ];

  m:left-1;
  if[0=m;
    :@[vmop;(vid;left;open);:;tp[cave;open]];
  ];

  vmop:vmop upsert([]v:vid;m:left;o:enlist open;p:0N);

  adj:cave[vid;`adj];
  v:adj except exec v from vmop where v in adj,left<=m,(all')open in/:o;
  o:count[v]#enlist open;

  if[not[vid in open]and 0<cave[vid;`fr];
    v,:vid;
    o,:enlist asc open union vid;
  ];

  if[0=count v;
    :@[vmop;(vid;left;open);:;m*tp[cave;open]];
  ];

  p:vmop[([]v;m;o)]`p;
  w:where null p;
  vmop:.z.s[cave;T;m]/[vmop;o w;v w];
  vmop:@[vmop;(vid;left;open);:;max[vmop[([]v;m;o)]`p]+tp[cave;open]];
  vmop
 };

T:30;

/// considering the valves with zero flow rate "open"
/// open:asc exec v from cave where 0=fr;
/// vmop:3!select v,m:T,o:count[cave]#enlist open,p:0 from cave;

open:`s#"j"$();
// [v]alve, [m]inute, [o]pen valves, [p]ressure released
vmop:3!flip`v`m`o`p!"jj*j"$\:();

vmop:.Q.v traverse[cave;T;T;`vmop;open;conv26"AA"];

show count vmop; // 693711
show first vmop; // 1850

exit 0

// __EOF__
