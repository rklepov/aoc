// 2022/q/11.q
//
// https://adventofcode.com/2022/day/11

inp:read0`:./input/11.txt;
-1"";

split:{[pred;v]
  g:v group s:sums differ w:pred v;
  g distinct s where not w
 };

// Quite simplistic way to read input data: no assumptions on the order or lines,
// indentation or any extra checks.
buildProfile:{[profile;card]
  ws:" "; / white space
  fs:":"; / field sep

  h1:split[ws>=;card 0];
  if[not"Monkey"~h1 0;:profile];
  monkey:`id`items`op`arg1`arg2`test`true`false!("J"$first fs vs h1 1;"j"$();::;::;::;0N;0N;0N);

  monkey:{[monkey;ws;fs;line]
    field:trim fs vs line;
    if["Starting items"~field 0;
      monkey[`items]:enlist"J"$","vs field 1;
    ];
    if["Operation"~field 0;
      op:parse last split["="=;field 1];
      monkey,:`op`arg1`arg2!op[0],({y;x};{x;y})[`old~'a]@'a:-2#op;
    ];
    if["Test"~field 0;
      monkey[`test]:"J"$last ws vs field 1;
    ];
    if["If"~first v:ws vs field 0;
      monkey[`$last v]:"J"$last ws vs field 1;
    ];
    monkey
  }/[monkey;ws;fs;1_card];
  profile,flip monkey
 };

profile:buildProfile/[();split[""~/:;inp]];

monkey:`monkey xcol 1!delete items from profile;
init:select r:0,t:0,monkey:id,level:items from ungroup`id`items#profile;

observe:{[monkey;reduce;round]
  round:select from round where r=max r;
  round:raze{[monkey;reduce;turn]
    turn:turn lj monkey;
    turn:update level:{[op;a1;a2;lvl]op[a1 lvl;a2 lvl]}'[op;arg1;arg2;level]from turn where monkey=t;
    turn:update reduce level from turn where monkey=t;
    turn:(select from turn where monkey<>t),select from turn where monkey=t;
    turn:update monkey:?["b"$0=level mod test;true;false]from turn where monkey=t;
    select r,t+1,monkey,level from turn
  }[monkey;reduce]\[count monkey;round];
  round:select from round where t>0;
  round:update r+1,t:0 from round where r=max r,t=max t;
  round
 };

run:{[monkey;reduce;rounds;init]
  raze observe[monkey;reduce]\[rounds;init]
 };

monkeyBusiness:{[hist]
  stats:select inspect:count i by monkey from hist where r<>max r,monkey=t;
  exec prd inspect from stats where 1>=rank neg inspect
 };

// part 1
history:run[monkey;div[;3];20;init];
level:monkeyBusiness history;
show level; / 57838

// part 2
history:run[monkey;mod[;prd exec test from monkey];10000;init];
level:monkeyBusiness history;
show level; / 15050382231

exit 0;

// __EOF__
