% Problem 2
A = [0.27 0.12 0.045 1 0 0 0;
    1 0.75 0.2 0 1 0 0;
    -2 1 0 0 0 1 0;
    0 0 1 0 0 0 1];
b = [100; 480; 0; 300]
c = [-200.2; -50.2; -25.2; 0; 0; 0; 0];

bfvs = []

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
                    x([i j k u]) = xB;
                    bfvs = [bfvs; x']
                end
            end
        end
    end
end





