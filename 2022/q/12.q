// 2022/q/12.q
//
// https://adventofcode.com/2022/day/12

inp:read0`:./input/12.txt;
-1"";

dim:count each -1_first scan;

size:prd dim@;

lookup:{[inp;a]
  ax,'where each w ax:where any each w:a=inp
 };

S:first lookup[inp;"S"];
E:first lookup[inp;"E"];

// frame[1;1;2 2#0]
//
//          1 1 1 1
// 0 0  ->  1 0 0 1
// 0 0      1 0 0 1
//          1 1 1 1
//
frame:{[w;v;m]
  c,/:(r,m,r:w#enlist dim[m][1]#v),\:c:w#v
 };

unframe:{[w;m]
  drop:w _neg[w]_;
  (drop')drop m
 };

heightmap:neg["j"$"a"]+"j"${@/[x;where each x=/:"SE";:;"az"]}each inp;

// part 1

// The recursive solution works in principle and gives correct result on the test
// data. However on the higher dimensional problem it results in 'stack due to
// deep recursion so not applicable to the real input data.
recursiveTopDown:{[map;end;start]
  paths:frame[1;0N]dim[map]#();
  paths:{[m;start;cycle;paths;pos]
    paths:.[paths;pos;:;enlist pos];
    if[start~pos;
      :paths;
    ];
    pre:pos+/:{x,neg x}(rotate[1]\)0 1;
    pre@:where 1>=.[m;pos]-m ./:pre;
    pre@:where not pre in cycle;
    visited:where 0<(count')paths ./:pre;
    paths:.z.s[m;start;cycle,enlist pos]/[paths;pre except pre visited];
    shortest:first{x where 0=rank(count')x}paths ./:pre;
    paths:.[paths;pos;{y,x};shortest];
    paths
  }[frame[1;-2]map;start+1;();frame[1;0N]dim[map]#();end+1];
  unframe[1]paths
 };

/ paths:recursiveTopDown[heightmap;E;S];
/ show count[paths . E]-1;

// If we consider the map a DAG then the edge is a pair of positions in the map
// with the second one reachable from the first according to the rules of the
// task. The position is designated by the pair of indices of the matrix.
makeEdges:{[map]
  pos:(cross/)til each dim map;
  move:{x,neg x}(rotate[1]\)0 1;
  e:{[m;v;p]
    r:p+/:v;
    r where -1<=.[m;p]-m ./:r
  }[frame[1;2+(max/)map;map];move]each 1+pos;
  raze enlist'[pos](,/:)'enlist''[e-1]
 };

// https://en.wikipedia.org/wiki/Bellman%E2%80%93Ford_algorithm
bellmanFord:{[map;start;edges]
  distance:.[;start;:;0]dim[map]#(#). 2#size map;
  de:{[m;de]
    d:de 0;
    e:de 1;
    d:{[m;d;e]
      u:e 0;
      v:e 1;
      du:d . u;
      dv:d . v;
      if[dv>du+1;d:.[d;v;:;du+1]];
      d
    }[m]/[d;e];
    (d;e)
  }[map]/[size[map]-1;(distance;edges)];
  de 0
 };

\t distance:bellmanFord[heightmap;S;makeEdges heightmap];
show distance . E; // 504

exit 0;

// __EOF__
