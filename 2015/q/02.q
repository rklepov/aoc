// 2015/q/02.q
//
// https://adventofcode.com/2015/day/2

inp:("iii";"x")0:`:./input/02.txt;

lwh:flip`l`w`h!inp;

// part 1
-1"";

lwh:update lw:l*w,wh:w*h,hl:h*l from lwh;
p:exec sqf:sum({min[x]+2*sum x},'/)[(lw;wh;hl)]from lwh;
show p;  / 1588178


// prat 2
-1"";

lwh:update lwp:2*l+w,whp:2*w+h,hlp:2*h+l,v:l*w*h from lwh;

r:exec rib:sum v+(min,'/)[(lwp;whp;hlp)]from lwh;
show r;  / 3783758

exit 0;

// __EOF__
