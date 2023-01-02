// 2015/q/25.q
//
// https://adventofcode.com/2015/day/25

inp:read0`:./input/25.txt;

split:{[pred;v]
  g:v group s:sums differ w:pred v;
  g distinct s where not w
 };

word:split[in[;", ."];inp 0];

// part 1
-1"";

// The sum of natural numbers up to n.
triang:{[n](n*(n+1))div 2};

codeAt:{[s;p;m;i;j]
  n:(i+j)-1; / n x n matrix
  k:triang n; / ordinal number of the value at position [1;n]
  (k-i){[p;m;v](v*p)mod m}[p;m]/s / the code is the last value of the series
 };

code:codeAt[20151125;252533;33554393]."J"$word 15 17;
show code; / 9132360

exit 0;

// __EOF__
