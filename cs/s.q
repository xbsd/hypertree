// treetable server

\t 1000

\l ../t.q
\l ../x.q
\l ../d.q

/ connect to client
K:0Ni
.z.po:{[w]`K set w;neg[K](`.js.ini;.js.obj[]);}
.z.pc:{[w]`K set 0Ni}
.z.ps:{neg[K](`.js.exe;.js.exe x)}

/ entry points
.js.row:{[d]$[.js.bot d`row;d;0=count n:.js.cnv d`row;d;count[Z]=r:Z[`n_]?n;d;[`P set .ht.row[not Z[`o_]r;P;G]n;.js.set d]]}
.js.col:{[d]0N!d`col;.js.ret d}
.js.cell:{[d]0N!d`row`col;.js.ret d}
.js.sorts:{[d]`S set d[`cols]!d`sorts;`Z set .ht.sort[Z;G]S;.js.ret d}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.vpaths[P]G;`Z set();.js.set d}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}

/ utilities
.js.bot:{$[L;0b;count[G]=count x]}
.js.exe:{.js[x`fn]x}
.js.sym:{$[(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.js.cnv:{[n]raze@[flip enlist n;i;{y$string x};upper q i:where"s"<>q:Q count[n]#G]}
.js.set:{`Z set .ht.cons[Z;T;P;A;S;G]F;.js.ret x}
.js.obj:{{x!get each x}`Z`G`H`F`I`Q`S`R`N`T`O}
.js.ret:{x,.js.obj[]}
.js.upd:{if[not null K;`Z set();P[1]:.ht.P 1;neg[K](`.js.exe;.js.set()!())]}

/ define Z
.js.set()!();

/ get a port
if[0=system"p";system"p 12346"]
