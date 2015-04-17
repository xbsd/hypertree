// treetable client

\e 1
\p 12345
\P 14
\c 25 150
\t 2000

/ connect to server
K:0Ni
K_:`::12346
.z.ts:{if[null K;`K set@[hopen;K_;K]]}
.z.pc:{K::0Ni}

/ websocket communications
J:0Ni
$[.z.K<3.3;
  [.z.pc:{[w]$[w=J;`J set 0Ni;w=K;`K set 0Ni]};
   .z.po:{`J set .z.w;neg[K](1#`fn)!1#`set}];
  [.z.pc:{[w]if[w=K;`K set 0Ni]};
   .z.wc:{[w]if[w=J;`J set 0Ni]};
   .z.wo:{`J set .z.w;neg[K](1#`fn)!1#`set}]];

.z.ws:{.js.rcv .js.sym .j.k x}

/ utilities
.js.sym:{$[(t:abs type x)in 0 99h;.z.s each x;10=t;`$x;x]}
.js.sub:{flip each(1#x;.js.row[1_x]. R`start`end)}
.js.row:{$[0 0W~y,z;x;y>=count x;0#x;((1+z-y)&count r)#r:y _ x]}
.js.obj:{`Z`G`H`F`I`Q`S`R`N`T`O!(.js.sub Z;G;H;F;I;Q;`cols`sorts!(key S;get S);R;N;T;.js.nnd O)}
.js.ret:{x,.js.obj[]}
.js.get:{`R set`start`end!"j"$x`start`end;.js.ret x}
.js.ini:{key[x]set'get x;.js.jsn .js.obj[]}
.js.exe:{r::R;key[x]set'get x;R::r;.js.jsn .js.ret x}
.js.rcv:{$[`get=x`fn;.js.jsn .js.get@;.js.ksn]x}
.js.nnd:{$[99=type x;.z.s each(key[x]except`)#x;x]}
.js.jsn:{if[not null J;neg[J].j.j x]}
.js.ksn:{if[not null K;neg[K]x]}