// globals

/ qtypes
Q::.tt.qtype T

/ count of Z
N::count Z

/ visible order
F::cols[T]except G

/ group by
G:()

/ groupable
H::.tt.groupable T

/ invisible
I::cols[T]except G,F

/ rollups
A:()!()

/ instruction state (current;prior)
P:.tt.P

/ rows -> gui
R:`start`end!0 100

/ sorts (`a`d`A`D)
S:()!()

/ table
T:`

/ treetable
Z:()