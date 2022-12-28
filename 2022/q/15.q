// 2022/q/15.q
//
// https://adventofcode.com/2022/day/15

inp:read0`:./input/15.txt;

range:{[s;e]s+til 0^e-s};

chord:{[oX;oY;r;Y]
  d:r-abs Y-oY;
  if[d<0;d:0N];
  (oX-d;oX+d)
 };

join:{[c;r;m]r union range . m[c]+0 1};

scanRow:{[map;Y]
  map:update cX:chord'[sX;sY;mR;Y]from map;
  join[`cX]/[();map]
 };

makeMap:{[inp]
  map:flip`sX`sY`bX`bY!flip((3#(f(-1_)::)),(f:"J"$last"="vs))@'/:(" "vs'inp)[;2 3 8 9];
  map:update mR:abs[bX-sX]+abs bY-sY from map / Manhattan "radius"
 };

map:makeMap inp;

// part 1
-1"";

r:{[map;Y]count scanRow[map;Y]except exec bX from map where bY=Y}[map;2000000];
show r; // 5394423

exit 0;

// __EOF__
