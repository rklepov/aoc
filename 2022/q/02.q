// 2022/q/02.q
//
// https://adventofcode.com/2022/day/2

inp:("SS";" ")0:`:./input/02.txt;

-1"";

// part 1

/ https://www.tablesgenerator.com/text_tables
/ ╔═══╦═══╦═══╦═══╗
/ ║   ║ X ║ Y ║ Z ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ A ║ 3 ║ 6 ║ 0 ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ B ║ 0 ║ 3 ║ 6 ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ C ║ 6 ║ 0 ║ 3 ║
/ ╚═══╩═══╩═══╩═══╝

round:(`A`B`C!rotate[-1]\[3 6 0])inp 0;

score:sum round@'`X`Y`Z?inp 1;
score+:sum(`X`Y`Z!1 2 3)inp 1;

show score; / 13526

// part 2

/ ╔═══╦═══╦═══╦═══╗
/ ║   ║ 0 ║ 3 ║ 6 ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ A ║ C ║ A ║ B ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ B ║ A ║ B ║ C ║
/ ╠═══╬═══╬═══╬═══╣
/ ║ C ║ B ║ C ║ A ║
/ ╚═══╩═══╩═══╩═══╝

round:(`A`B`C!rotate[1]\[`C`A`B])inp 0;

score:sum(`A`B`C!1 2 3)round@'(`X`Y`Z!til 3)inp 1;
score+:sum(`X`Y`Z!0 3 6)inp 1;

show score; / 14204

exit 0;

// __EOF__
