function G = computePerfRadius(G, deltaP)
% Computes r_perf from equation 10 in VascuSynth

% Perfusion edge is always the first one
Qperf = G.Edges.Q(1);
R_starPerf = G.Edges.R_star(1);

G.Edges.r(1) = ( Qperf*R_starPerf / deltaP )^0.25;