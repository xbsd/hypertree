/ simple treetable sort
sort:{[t;g;s]
 n:exec n_ from t;
 i:clist[parents n]except enlist();
 f:{x$[not t:type y;::;t in 10 11h;lower;abs]y};
 j:msort[0!t;key s;(`a`d`A`D!(iasc;idesc;f iasc;f idesc))get s]each i;
 t q?pmesh over(q:`$string n)j}

/ parent-vector -> child-list
clist:{[p]@[(2+max p)#enlist();first[p],1+1_p;,;til count p]}

/ multi-sort
msort:{[t;c;o;i]i{x y z x}/[til count i;o;flip[t i]c]}

/ mesh nest of paths
pmesh:{i:1+x?-1_first y;(i#x),y,i _ x}

