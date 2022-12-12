// 2022/q/07.q
//
// https://adventofcode.com/2022/day/7

inp:read0`:./input/07.txt;
-1"";

makeTree:{[lines]
  emptyDir:enlist[`]!enlist[::];
  r:{[emptyDir;r;line]
    cwd:r 0;
    tree:r 1;
    s:`$line;
    cmd:s[0]~`$"$";
    if[cmd and`cd~s 1;
      up:`..~s 2;
      if[up;cwd:-1_cwd];
      if[not up;cwd,:s 2];
    ];
    if[not cmd;
      dir:`dir~s 0;
      if[dir;tree:.[tree;cwd,s 1;:;emptyDir]];
      if[not dir;tree:.[tree;cwd,s 1;:;"J"$line 0]];
    ];
    (cwd;tree)
  }[emptyDir]/[(();(`;`$"/")!(::;emptyDir));" "vs/:lines];
  r 1
 };

du:{[root]
  subdir:99h=type each root;
  ownSize:sum 0,1_root where not subdir;
  ownSize+sum 0,.z.s each root where subdir
 };

filter:{[r;tree;pred;path]
  if[pred tree . path;r:enlist path];
  r,raze .z.s[r;tree;pred]each path,/:where 99h=type each tree . path
 };

// filesystem directory tree
tree: makeTree inp;

// part 1
paths:filter[();tree;{100000>=du x};(),`$"/"];
r:sum du each tree ./:paths;
show r; / 919137

// part 2
paths:filter[();tree;{[total;dir]30000000<=du[dir]+70000000-total}du tree`$"/";(),`$"/"];
r:min du each tree ./:paths;
show r; / 2877389

exit 0;

// __EOF__
