// 2022/q/13.q
//
// https://adventofcode.com/2022/day/13

inp:read0`:./input/13.txt;
-1"";

split:{[pred;v]
  g:v group s:sums differ w:pred v;
  g distinct s where not w
 };

conv:value ssr/[;("[[]]";"[[]";",");("()";"enlist[";";")]::;

pad:{[w;f;v]v,(max 0,w-count[v])#f};

// item
cmpi:{[b;l;r]
  if[not null b;:b]; / short cut (aka loop "break"): already have a decision
  t:0>(type')lr:(l;r);
  if[any n:null lr where t;:10b first where[t]where n]; / check list out of items marker
  lr:@[lr;where t;(::;enlist)sum[t]mod 2]; / if one is a list then enlist the other if it's not
  if[0<=type lr 0;:cmpl . lr];
  $[(<>/)lr;(</)lr;b]
 };

// list
cmpl:{[l;r]
  m:max(count')(l;r);
  cmpi/[0N;pad[m;0N;l];pad[m;0N;r]]
 };

// pair
cmpp:{[l;r]
  $[null b:cmpl[l;r];0b;b] / null -> the lists are identical, return false (equivalent of <)
 };

pairs:(conv'')split[""~/:;inp];

// part 1
r:sum 1+where cmpp .'pairs;
show r; / 6086

// part 2
divider:2(enlist/)'2 6;
packets:raze[pairs],divider;

// compare each packet with all others to determine sort order

// TODO: The used technique is rather straightforward: actually no need to
// compare a pair of objects twice. Probably need to look at strcmp() style
// return value for the comparison function. Also no need to compare an object
// to itself.
order:packets iasc(sum(cmpp\:)::)[packets]'[packets];
r:prd 1+where any order~\:/:divider;
show r; / 27930

exit 0;

// __EOF__
