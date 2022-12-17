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
// "reversing" the heightmap because we're going to calculate all paths from the
// final position backwards
heightmap:{max/[x]-x}heightmap;

// part 1

// If we consider the map a DAG then the edge is a pair of positions in the map
// with the second one reachable from the first according to the rules of the
// task. The position is designated by the pair of indices of the matrix.
makeEdges:{[map]
  pos:(cross/)til each dim map;
  move:{x,neg x}(rotate[1]\)0 1;
  e:{[m;d;u]
    v:u+/:d;
    v where 1>=./:[m;v]-.[m;u]
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

\t distance:bellmanFord[heightmap;E;makeEdges heightmap];
show distance . S; // 504

// part 2

// We've already calculated the shortest path from each map position to the final
// one. Now just selecting the smallest number among them.
best:min raze distance@'where each max/[heightmap]=heightmap;
show best; // 500

exit 0;

// __EOF__
