// 2022/q/10.q
//
// https://adventofcode.com/2022/day/10

prog:flip`opcode`val!("SJ";" ")0:`:./input/10.txt;
-1"";

cpu:(!/)flip(
  (`noop;(1;{y;x}));
  (`addx;(2;{x+y}))
 );

run:{[cpu;state;instr]
  op:cpu instr`opcode;
  @/[state;0 1;(op[0]+;op[1][;instr`val])]
 };

cycles:enlist[0 1],run[cpu]\[0 1;prog];
ncycles:last cycles[;0];
X:1^fills @[ncycles#0N;;:;]. flip -1_cycles;

// part 1
strength:{[shift;step;X](shift+step*til count X)*X:first each (0N;step)#shift _0,X};
strengths:strength[20;40;X];
show sum strengths; / 14220

// part 2
-1"";
crt:{[rl;X](0N;rl)#".#"(til[count X]mod rl)in'X +\:1 0 -1};
show crt[40;X];

/ "####.###...##..###..#....####.####.#..#."
/ "...#.#..#.#..#.#..#.#....#.......#.#..#."
/ "..#..#..#.#..#.#..#.#....###....#..#..#."
/ ".#...###..####.###..#....#.....#...#..#."
/ "#....#.#..#..#.#.#..#....#....#....#..#."
/ "####.#..#.#..#.#..#.####.#....####..##.."
/ ZRARLFZU

exit 0;

// __EOF__
