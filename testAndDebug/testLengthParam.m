nBif = 0:50;
expFact = 4;

Lmax = 800e-6;
minLmax = 100e-6;
Lmin = 200e-6;
minLmin = 25e-6;

Exp = exp(-nBif/expFact);
lin = log(linspace(1,exp(1), numel(nBif)));

figure
plot(Lmin*Exp + abs(Lmin*Exp(end)-minLmin)*lin)
hold on
plot(Lmax*Exp + abs(Lmax*Exp(end)-minLmax)*lin)
legend('Lmin', 'Lmax')
xlabel('Number of bifurcations to root')
ylabel('New branch length (m)')