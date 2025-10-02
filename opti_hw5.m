files = dir('prob*datafile.mat');

for i = 1:length(files)
    filename = files(i).name;
    prob{i} = load(filename);
    A{i} = prob{i}.A;
    b{i} = prob{i}.b;
    c{i} = prob{i}.c;
end

% initialize the size of matrix and chosen basis
[m, n] = size(A{5});
basis = ([4 5 6 7]);              
nonbasis = setdiff(1:n, basis);

iter = 0;

while true
    B = A{5}(:, basis);
    N = A{5}(:, nonbasis);

    % Tableau block
    updated = [eye(m) B\N B\b{5}];

    % Reduced costs
    cB = c{5}(basis);
    cN = c{5}(nonbasis);
    red_cost = cN' - cB'*(B\N);

    iter = iter + 1;
    fprintf("Prob5 Iteration %d\n", iter)
    disp("Reduced cost vector:")
    disp(red_cost)
    disp("Tableau:")
    disp(updated)

    % stop the iterations when reduced cost is nonnegative
    if all(red_cost >= 0)
        break
    end

    % find the pivot column, i.e. most negative reduced cost entry
    [~, idxN] = min(red_cost);  
    entering = nonbasis(idxN);

    % ratio test and decide which var to leave
    rhs = B\b{5};
    piv_col = B\A{5}(:, entering);
    mask = piv_col > 0;
    if ~any(mask)
        error('Problem is unbounded.');
    end
    ratios = rhs(mask) ./ piv_col(mask);
    [~, rel_idx] = min(ratios);
    pivot_row = find(mask);
    min_idx = pivot_row(rel_idx);

    leaving = basis(min_idx);

    fprintf('Entering var = %d, leaving var = %d\n', entering, leaving);

    % re-define the basis
    basis(min_idx) = entering;
    nonbasis = setdiff(1:n, basis);
end

% optimal ofv
x = zeros(n,1);
x(basis) = A{5}(:,basis)\b{5};
opt_val = c{5}'*x;

disp("Optimal solution:")
disp(x)
disp("Optimal value:")
disp(opt_val)
