// 2022/q/15.q
//
// https://adventofcode.com/2022/day/15

inp:read0`:./input/15.txt;

.range.range:{[s;e]s+til e-s};

.range.union:{[u;v];
  if[0<(-/)v;:enlist u]; / the reversed ranges are empty
  a:u;
  b:v;
  if[b[0]<a[0];
    b:u;
    a:v;
  ];
  if[not b[0]within a;:(a;b)];
  enlist(min(a;b)[;0];max(a;b)[;1])
 };

.range.join:{[U;v]
  U:asc distinct raze U .range.union\:v;
  distinct raze first[U].range.union':U
 };

.range.collapse:{[r]
  .range.join/[1#r;1_r]
 };

.range.len:1+neg(-/)::;

/ a horizontal "chord" in Manhattan "circle" (rhombus) at row Y
chord:{[oX;oY;r;Y]
  d:r-abs Y-oY;
  (oX-d;oX+d)
 };

scanRow:{[map;Y]
  m:update cX:chord'[sX;sY;mR;Y]from map;
  .range.collapse/[m`cX]
 };

makeMap:{[inp]
  map:flip`sX`sY`bX`bY!flip((3#(f(-1_)::)),(f:"J"$last"="vs))@'/:(" "vs'inp)[;2 3 8 9];
  map:update mR:abs[bX-sX]+abs bY-sY from map / Manhattan "radius"
 };

map:makeMap inp;

// part 1
-1"";

// no beacon count at row Y
nbc:{[map;Y]
  total:sum .range.len each scanRow[map;Y];
  total-count exec distinct bX from map where bY=Y
 };

show nbc[map;2000000]; / 5394423

// part 2
-1"";

showProgress:{[h;n;c;i]
  if[0=i mod n;h c];
 };

scanMap:{[progress;map;iY]
  i:1+iY 0;
  progress i;
  (i;.range.collapse/[scanRow[map;i]])
 };

// find distress beacon
// returns (X;Y;tuning frequency)
fdb:{[fX;tX;startY;map]
  / Here we just assume that the first gap in the sensors coverage will appear
  / within the (fX;tX) range i.e. not outside or exactly on the edges and it
  / will be our target position.
  r:{1=count x 1}scanMap[showProgress[1;10000;"."];map]/(-1+startY;enlist());
  showProgress[-1;1;"";0];
  bY:r 0;
  bX:first .range.range[fX;tX+1]{x except .range.range . y+0 1}/r 1;
  tf:bY+bX*tX;
  (bX;bY;tf)
 };

// As I already know the answer for my input I start the scan closer to the
// target position to save time. Starting from Y=0 can take a while (~25 min on
// my laptop).
// \t db:fdb[0;4000000;0;map]; / 1514799
db:fdb[0;4000000;3210000;map];

show db; / 2960219 3211051 11840879211051

exit 0;

// __EOF__
