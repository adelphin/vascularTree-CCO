function cost = costFunction(G)

mu = 1;
lambda = 2;

% converting to µm to help optimization, in meters cost is too close to
% numerical precision
cost = sum((1e6*G.Edges.L).^mu .* (1e6*G.Edges.r).^lambda);