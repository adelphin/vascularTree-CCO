nEdges = 20;
% nEdges = numedges(G);

nBif = 0:200;
expFact = 30;

Lmax = 700e-6;
minLmax = 210e-6;
Lmin = 300e-6;
minLmin = 80e-6;

Exp = exp(-nBif/expFact);
lin = log(linspace(1,exp(1), numel(nBif)));

Ones = ones(1, nEdges - 16);
LminRange = [Lmin*Exp + abs(Lmin*Exp(end)-minLmin)*lin, minLmin*Ones];
LmaxRange = [Lmax*Exp + abs(Lmax*Exp(end)-minLmax)*lin, minLmax*Ones];

% LminRange(:) = minLmin;
LminRange(LminRange < minLmin) = minLmin;
LmaxRange(LmaxRange < minLmax) = minLmax;

figure
plot(LminRange)
hold on
plot(LmaxRange)
xlim([1, 100])
legend('Lmin', 'Lmax')
xlabel('Number of bifurcations to root')
ylabel('New branch length (m)')