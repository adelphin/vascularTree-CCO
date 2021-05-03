function cost = costFunction(G)

mu = 1;
lambda = 2;

cost = sum(G.Edges.L.^mu .* G.Edges.r.^lambda);
% cost=1;