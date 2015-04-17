// globals

/ qtypes
Q::.ht.qtype T

/ count of Z
N::count Z

/ visible order
F::cols[T]except G

/ group by
G::1#H

/ groupable
H::.ht.groupable T

/ invisible
I::cols[T]except G,F

/ rollups
A:()!()

/ instruction state (current;prior)
P:.ht.P

/ rows -> gui
R:`start`end!0 100

/ sorts (`a`d`A`D)
S:()!()

/ table
T:`

/ treetable
Z:()