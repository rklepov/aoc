// 2022/q/04.q
//
// https://adventofcode.com/2022/day/4

inp:("**";",")0:`:./input/04.txt;
-1"";

range:{[s;e]s+til 1+e-s};
expand:.[range]"J"$"-"vs;

t:([]F:inp 0;S:inp 1;f:expand'[inp 0];s:expand'[inp 1]);

// part 1
r:exec sum{[f;s]any(f inter s)~/:(f;s)}'[f;s]from t;
show r; / 450

// part 2
r:exec sum{[f;s]any any each(f in s;s in f)}'[f;s]from t;
show r; / 837

exit 0;

// __EOF__
