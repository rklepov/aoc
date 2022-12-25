// 2022/q/18.q
//
// https://adventofcode.com/2022/day/18

inp:("jjj";",")0:`:./input/18.txt;

// part 1
-1"";

grid:(2+1+max flip inp)#0N; / one extra layer on each side of the 3D grid
cube:flip inp+1;

neighbor:{x+/:\:raze(rotate[1]\)each -1 1,\:0 0};

cool:{[g;c;n]
  n@:where not null g ./:n;
  g:.[g;c;:;6-count n];
  ./[g;n;-;1]
 };

obsidian:cool/[grid;cube;neighbor cube];

show 3 sum/0^obsidian; / 4282

exit 0;

// __EOF__
