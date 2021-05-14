function [f_left, f_right] = computeRatios(G, idxChildrenEdges)
% Computes ratios r_left/r_parent and r_right/r_parent from the indices of
% children_left and children_right
% Equations 11 and 12 in VascuSynth
gamma = 3;
% get needed parameters from children edges
QChildren = G.Edges.Q(idxChildrenEdges);
R_starChildren = G.Edges.R_star(idxChildrenEdges);

% compute radii ratio (eq 11 and 12 in VascuSynth)
l_over_r = ( QChildren(1)*R_starChildren(1) / (QChildren(2)*R_starChildren(2)) )^0.25;

f_left  = (1+(l_over_r ^ -gamma))  ^(-1/gamma);
f_right = (1+(l_over_r ^  gamma))  ^(-1/gamma);
