o:read0`:meta.txt
a:read0`:itunes.txt

A:"abcdefghijklmnopqrstuvwxyz_ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ,.;:-'"

extract:{[o;a]
 ko:{`$5_first[ss[x;"</key>"]]#x};
 k:ko each o;
 r:{0N!y;getkey[y]each x}[a]each k;
 dt:{ssr[-1_x;"-";"."],".000"};
 r[15]:dt each r 15;
 r[16]:dt each r 16;
 vd:{@[x;where not x in A;:;" "]};
 r:vd each'r;
 l:`$ssr[;" ";"_"]each string k;
 r:flip l!r}

getkey:{[k;d]
 s:"<key>",string[k],"</key>";
 if[not count i:d ss s;:""];
 v:">"vs(count[s]+i 0)_d;
 {(x?"<")#x}v 1}

convert:{[a]
 ct:{d:" 0123456789";r:raze 10#x;$[all r in d;"J";all r in"T.:",d;"Z";"S"]};
 b:flip a;c:ct each get b;r:flip c$'b;r[`Total_Time]:"t"$1.*r`Total_Time;r}

unknown:{
 r:delete from x where null Album,null Artist;
 update Album:Artist from r where null Album}
 
`:itunes set unknown convert extract[o;a]






