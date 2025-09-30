% Problem 1 (HW 3 Problem 2)
A = [0.27 0.12 0.045 1 0 0 0;
    1 0.75 0.2 0 1 0 0;
    2 -1 0 0 0 1 0;
    0 0 1 0 0 0 1];
b = [100; 480; 0; 300]
c = [-200.2; -50.2; -25.2; 0; 0; 0; 0];

bfvs = []
columns = [1 2 3 4 5 6 7]

for i=1:7
    for j=(i+1):7
        for k=(j+1):7
            for u=(k+1):7
                B = A(:,[i j k u]);
                if rank(B) < 4
                    continue;
                end
                xB = B \ b;
                if xB >= 0
                    x = zeros(7,1);
                    basic_cols = [i j k u];
                    x(basic_cols) = xB;
                    nonbasic_cols = setdiff(columns, basic_cols);
                    c_N = c(nonbasic_cols);
                    c_B = c(basic_cols);
                    N = A(:,nonbasic_cols);
                    red_cost = c_N' - (c_B'*((B^-1)*N));
                    ofv = c_B'*((B^-1)*b);
                    bfvs = [bfvs; x' red_cost ofv];
                end
            end
        end
    end
end

% Problem 4
[x1, x2] = meshgrid(0:400, 0:600);  % ranges chosen large enough

ineq1 = (0.27*x1 + 0.12*x2) <= 93.25;   
ineq2 = (x1 + 0.75*x2) <= 450;          
ineq3 = (2*x1 - x2) <= 0;                

feasible = ineq1 & ineq2 & ineq3;

figure; hold on;
contourf(x1, x2, feasible, [0.5 0.5], 'g');
xlabel('x_1'); ylabel('x_2');
title('Feasible polytope');

z = -200.2*x1 - 50.2*x2;  
contour(x1, x2, z, 50, 'k'); 


