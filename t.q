// treetable

\d .ht

/ construct treetable
cons:{[z;t;p;a;s;g;f]cons_[z;t;p;rollups[t;g]a;s;g]req[a]f,g}
cons_:{[z;t;p;a;s;g;f]sort[ctl[p 0;g]dat[unctl z;t;f#a;g;f]. visible each p;g]s}

/ required
req:{[a;f]distinct[f,q where -11=type each q:raze over a f]except`}

/ control table
ctl:{[p;g;z]
 n_:z`n_;e_:isleaf[n_]g;l_:levelof n_;o_:isopen[n_]p;p_:parents n_;g_:@[`,na last each 1_n_;where e_;:;`];
 0!update n_:n_,e_:e_,l_:l_,p_:p_,o_:o_,g_:g_ from z}

/ uncontrol table
unctl:{[z]$[count z;1!delete e_,l_,p_,o_,g_ from z;()]}

/ na
NA:`$"N/A"
na:{@[x;where null x;:;NA]}

/ predicates
isopen:{[n;p](0!p)[`v](get each key[p]`n)?n}
isleaf:{[n;g]levelof[n]>count g}

/ level of each record
levelof:{[n]count each n}

/ path-list -> parent-vector
parents:{[n]m?-1_'m:`$string n}

/ path-list -> children vectors
children:{[n]@[where each p=/:til count p:parents n;0;1_]}

/ open or close
dat:{[z;t;a;g;f;p;p_]$[count[p]>count p_;open[z;t;a;g;f;p]p_;close[z]p_ except p]}

/ close node
close:{[z;p](0!z)where get[first p]{not$[count[y]<=count x;0b;all x=count[x]#y]}/:exec n_ from z}

/ open node: split, compute, join
open:{[z;t;a;g;f;p;p_]
 o:f except m:where(m_r first@)each f#a;
 r:$[count o;tree[t;(o,g)#a;g;o;p]p_;()];
 s:$[count m;map[t;(m_ each n:m#a),g#a;g;m;p]p_;()];
 u:$[not count r;s;not count s;r;lj[r]s];
 a:1!order[f]0!red[u]where[0<count each k]#k:r_ each n;
 delete N_ from `N_ xasc update N_:`$string n_ from 0!z,a}

/ predicates: (map-reduce, map, reduce)
m_r:{[a](0=type a)|first[a]in A}
m_:{[a]$[0=type m:first a;m;a]}
r_:{[a]$[0=type first a;first 1_a;()]}

/ compute top-down (map-reduce)
map:{[t;a;g;f;p;p_]key[z]!flip f!get[z:1!(0<count p_)_mapr[t;g;a;p]. recur[p]p_]f}
recur:{[p;p_]q:constraints p;c:c_ first p except p_;j:find[q`w]c;i:1+count c;(q;i;j)}
find:{[w;c]v?max v:(sum any@)each c~/:\:/:w}

/ reduce
red:{[t;a]![t;();0b;a]}

/ map
mapr:{[t;g;a;p;q;i;j]b:g~key c:p j;z:$[b;mapl[t;g;a]c;mapn[t;g;a;p;q;i;j]q j];mapt[b;z;g;a]c}
mapl:{[t;g;a;p]order[g]leaf[t;g;a]p}
mapn:{[t;g;a;p;q;i;j;v]0!order[g;node_[g;g i-1]0!?[t;v`w;k!k:i#g;a]],raze mapr[t;g;a;p;q;i+1]each v`c}
mapo:{[t;a]$[101=type 2 first/a;(t;a);(update N_:0 from t;((1#`N_)!enlist(first;`N_)),a)]}
mapt:{[b;t;g;a;c]order[g;node_[g;last key c]mapa[b;g;c]. mapo[t]a],t}
mapa:{[b;g;c;t;a]delete N_ from?[$[b;t;select from t where count[g]>=count each n_];t_[c]g;0b;a]}

/ recursive constraints
constraints:{[p]constraints_[([]w:();c:());p;c;0]first c:children p}
constraints_:{[w;p;c;i;j]r:`w`c!(p_c[p i]p j;j);w,r,$[count j;raze .z.s[w;p;c]'[j;c j];()]}

/ predicates: parent and not child, child
p_c:{[p;c]a:$[n:count c;p_ c;c];b:$[m:count p;c_ p;p];$[n&m;b,a;n;a;m;b;()]}
c_:{[c]key[c](=;;)'ensym each get c}
n_:{[c]enlist(~:;c_ c)}
p_:{[c]enlist(~:;((=;in)k;a;(0+k:1<count d)enlist/d:c a:last cols c))}
t_:{[c;g]c_[c],(null;)each(1+count c)_g}

/ compute bottom-up
tree:{[t;a;g;f;p;p_]key[z]!flip f!get[z:1!root[t;g;a;p_]block[t;g;a]/p except p_]f}

/ construct root block
root:{[t;g;a;p_]$[0<count p_;();order[g]node_[g;`]flip enlist each?[t;();();a]]}

/ construct a block = node or leaf
block:{[t;g;a;r;p]r,order[g]$[g~key p;leaf;node g(`,g)?last key p][t;g;a]p}

/ construct node block
node:{[b;t;g;a;p]node_[g;b]get?[t;constraint p;enlist[b]!enlist b;a]}
node_:{[g;b;t]![t;();0b;enlist[`n_]!2 enlist/$[null[b]|not count g;enlist();(1+g?b)#/:flip unsym each t g]]}

/ construct leaf block
leaf:{[t;g;a;p]leaf_[g;`$string til count u]u:0!?[t;constraint p;0b;@[last each a;g;:;g]]}
leaf_:{[g;i;t]![t;();0b;enlist[`n_]!2 enlist/$[count g;flip[flip[t]g],'i;flip enlist i]]}

/ order cols
order:{[g;t](`n_,g)xcols t}

/ instruction state
P:(([n:enlist(0#`)!()]v:enlist 1b);([n:()]v:til 0))

/ visible paths
visible:{[p]n where all each(exec v from p)(reverse q scan)each til count q:parents n:exec n from p}

/ keep valid paths
vpaths:{[p;g]q:vpaths_[g]p 0;(q;P 1)}
vpaths_:{[g;p]1!(0!p)where til[count g]{(count[y]#x)~y}/:g?/:key each exec n from p}

/ instruction -> constraint
constraint:{[p]flip(=;key p;ensym each get p)}

/ symbol -> enlist symbol
ensym:{[e]$[-11h=type e;enlist e;e]}

/ type 20 -> 11
unsym:{[v]$[20h>type v;v;`$string v]}

/ open/close to group (h=` -> open to leaves)
opento:{[t;g;h]
 k:(1+til count k)#\:k:(g?h)#g;
 n:enlist(0#`)!();
 f:{y,z!/:distinct flip flip[x]z};
 m:distinct n,raze f[t;n]each k;
 ([n:m]v:count[m]#1b)}

/ open/close at a node
row:{[b;p;g;n]`n xasc'(p[0],([n:enlist(count[n]#g)!n,()]v:enlist b);p 0)}

/ rollup: first if 1=count else null
nul:{first$[1=count distinct x,();x;0#x]}

/ rollup: first if 1=count else
seq:{$[1=count distinct x;first x;`$string[first x],"+"]}

/ type -> rollup
A:" bgxhijefcspmdznuvt"!(nul;any;nul;nul;sum;sum;sum;sum;sum;nul;seq;max;max;max;max;sum;max;max;max)

/ rollups
rollups:{[t;g;a]@[rollups_[t]a;g;:;nul,'g]}
rollups_:{[t;a]@[a;k;:;A[lower qtype[t]k],'k:cols[t]except key a]}

/ cast <- type
qtype:{exec c!t from meta x}

/ groupable columns in x
groupable:{exec c from meta 0!get x where t in"bhijspmdznuvt",not c in keys x}

/ intuitive treetable sort
sort:{[t;g;s]$[count s;t tsort[t;g;key s]get s;t]}

/ treetable sort
tsort:{[t;g;c;o]
 if[`g_ in c;t:update g_:` from t where e_];
 if[`g_~first -1_c;c:`G_,1_c;t:update G_:?[l_>1;`;g_]from t];
 n:reverse exec i by L_ from s:dsort[t;g;c;o]where L_>0;
 0,raze$[1=count n;s[`I_]n;merge[s;g]/[();key n;get n]]}

/ column sort
csort:{[c;o]@[flip(@;abs;c;c);i;:;c i:where o in`a`d]}

/ row sort
rsort:{[t;c;o]{x y z x}/[til count t;reverse o;?[t;();();enlist,reverse get c]]}

/ expression sort
esort:{[c]$[1=count c;first c;(flip;(!;enlist key c;enlist,get c))]}

/ data sort
dsort:{[t;g;c;o]
 a:!/[g,/:(`I_`L_;`i`l_)];c:c!csort[c]o;s:1=count distinct o:(<:;>:)o in`d`D;
 $[s;?[t;();0b;a;0W;(first o;esort c)];?[t;();0b;a]rsort[t;c]o]}

/ sort-level
level:{[s;g;n;i]c:((m:n&count g)#g),`I_;(delete I_ from t)!flip enlist(t:(c#s)i)`I_}

/ merge sort-levels
merge:{[s;g;x;n;i]v:level[s;g;n;i];$[count x;@[v;(keys v)#key x;,;get x];v]}

