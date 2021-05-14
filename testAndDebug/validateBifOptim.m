FOVx = 3000e-6;
FOVy = 3000e-6;
FOVz = 3000e-6;
Qterm = 4.16/1e5;
visc = 0.036;
deltaP = 5e3;
G = digraph;
Lmin = 300e-6;
rng(2)

%% initiate tree with perf branch
G = addVascNode(G, [FOVx/2, FOVy/2, FOVz], 1, 'n0');
G = addVascNode(G, createRandCoord([FOVx, FOVy, FOVz]), 1, 'n1');

G = addVascEdge(G, 'n0', 'n1', Qterm); %Qterm, so that after N terminal nodes we have Qperf
G = updateTree(G, 'n0-n1', visc, deltaP);

%% add new node and branch it
G = addVascNode(G, createRandCoord([FOVx, FOVy, FOVz]), 1, 'n2');
G_noOptim = branchNode(G, 'n0-n1', 'n2', Qterm, visc, deltaP, Lmin, 0);
G_optim = branchNode(G, 'n0-n1', 'n2', Qterm, visc, deltaP, Lmin, 1);

%% plot
figure;
subplot(1,2,1)
coords = cell2mat(G_noOptim.Nodes.Coord);
rfact = 1/min(G_noOptim.Edges.r);
plot(G_noOptim, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3) , 'LineWidth',G.Edges.r*rfact)
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,1,1])
titleStr = sprintf('Cost = %f', costFunction(G_noOptim));
title(titleStr)

subplot(1,2,2)
coords = cell2mat(G_optim.Nodes.Coord);
rfact = 1/min(G_optim.Edges.r);
plot(G_optim, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3) , 'LineWidth',G.Edges.r*rfact)
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,1,1])
titleStr = sprintf('Cost = %f', costFunction(G_optim));
title(titleStr)

% G, nameNewEdge, visc, deltaP, Lmin)