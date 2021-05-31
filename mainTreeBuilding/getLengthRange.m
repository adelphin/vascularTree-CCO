function [lengthRange] = getLengthRange(G, Lmin, Lmax, minLmin, minLmax)

% create decrease profile along with number of bif
nDecrease = 0:200;
expFact = 30;

Exp = exp(-nDecrease/expFact);
lin = log(linspace(1,exp(1), numel(nDecrease)));

Ones = ones(1,numedges(G) - numel(nDecrease));
LminRange = [Lmin*Exp + abs(Lmin*Exp(end)-minLmin)*lin, minLmin*Ones];
LmaxRange = [Lmax*Exp + abs(Lmax*Exp(end)-minLmax)*lin, minLmax*Ones];

% LminRange(:) = Lmin;
LminRange(LminRange < minLmin) = minLmin;
LmaxRange(LmaxRange < minLmax) = minLmax;
% get all bif nodes (parents of edges)
bifNodes = G.Nodes.Name(~logical(G.Nodes.isTermNode));

% compute the distance from bif to root
bifDistances = distances(G, 'n0', bifNodes);

% knowing that distance, attribute to each edge a Lmin and Lmax
% if bifPoints are n0, n3, n5, then edges are ordered by parent nodes as n0, n3, n3, n5, n5
% so we need twice more length entries than parent nodes (2 children per
% bif), except for the first node (root)
lengthRange = zeros(1 + 2*(numel(bifNodes)-1), 2);

lengthRange(1,1)       = LminRange(bifDistances(1)+1);
lengthRange(1,2)       = LmaxRange(bifDistances(1)+1);
lengthRange(2:2:end,1) = LminRange(bifDistances(2:end)+1);
lengthRange(3:2:end,1) = LminRange(bifDistances(2:end)+1);
lengthRange(2:2:end,2) = LmaxRange(bifDistances(2:end)+1);
lengthRange(3:2:end,2) = LmaxRange(bifDistances(2:end)+1);