// single-process treetable

\p 12345
\t 0

\l ../t.q
\l ../x.q
\l ../d.q

/ websocket communications
J:0Ni
$[.z.K<3.3;
  [.z.pc:{[w]if[w=J;J::0Ni]};
   .z.po:{`J set .z.w;.js.set()!()}];
  [.z.wc:{[w]if[w=J;J::0Ni]};
   .z.wo:{`J set .z.w;.js.set()!()}]];

.z.ws:{t:.z.z;.js.snd .js.exe .js.sym a:.j.k x;.js.log[t]a}

/ entry points
.js.node:{[d]$[.js.bot d`node;d;0=count n:.js.cnv d`node;d;count[Z]=r:Z[`n_]?n;d;[`P set .ht.at[not Z[`o_]r;P;G]n;.js.set d]]}
.js.sorts:{[d]`S set d[`cols]!d`sorts;`Z set .ht.sort[Z;G]S;.js.ret d}
.js.groups:{[d]`F`G set'.js.sym d`visible`groups;`P set .ht.vpaths[P]G;`Z set();.js.set d}
.js.get:{[d]`R set`start`end!"j"$d`start`end;.js.ret d}

/ logging
.js.log:{0N!(.js.elt x;y);}
.js.snd:{neg[J].j.j x}
.js.elt:{`time$"z"$.z.z-x}

/ utilities
.js.bot:{$[L;0b;count[G]=count x]}
.js.sym:{$[(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.js.cnv:{[n]raze@[flip enlist n;i;{y$string x};upper q i:where"s"<>q:Q count[n]#G]}
.js.exe:{.js[x`fn]x}
.js.set:{`Z set .ht.cons[Z;T;P;A;S;G]F;.js.ret x}
.js.nnd:{$[99=type x;.z.s each(key[x]except`)#x;x]}
.js.sub:{flip each(1#x;.js.row[1_x]. R`start`end)}
.js.row:{$[0 0W~y,z;x;y>=count x;0#x;((1+z-y)&count r)#r:y _ x]}
.js.obj:{`Z`G`H`F`I`Q`S`R`N`T`O!(.js.sub Z;G;H;F;I;Q;`cols`sorts!(key S;get S);R;N;T;.js.nnd O)}
.js.ret:{x,.js.obj[]}
.js.upd:{if[not null J;t:.z.z;`Z set();P[1]:.ht.P 1;.js.snd .js.set()!();.js.log[t]`upd]}

/ define Z
.js.set()!();

