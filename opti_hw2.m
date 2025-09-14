% Problem 1(b)
A = [-590 -170 -140 -310 -150
    -46 -10 -18 -30 -39
    -25 -9 -2 -17 0 
    34 10 8 13 0 
    85 25 0 250 0 
    1050 340 310 770 40
    ];
b = [-2000 -275 -50 78 300 2300];
c = [6.72 3.19 2.69 7.29 1.19];
x = linprog(c,A,b,[],[],zeros(5,1),[]);
val = dot(c,x);

% Problem 1(c) 
c2 = [6.72 3.19 2.69 7.29 500];
x2 = linprog(c2,A,b,[],[],zeros(5,1),[]);
val2 = dot(c2,x2);

% Problem 1(d)
b_afford = [-2000 -25 -50 780 3000 23000];
x_afford = linprog(c2,A,b_afford,[],[],zeros(5,1),[]);
val_afford = dot(c2,x_afford);

