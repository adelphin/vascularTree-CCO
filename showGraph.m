rng(2)
N = 2;
X = 200; 
Y = 200;
Z = 200;
FOVx = 3000e-6;
FOVy = 3000e-6;
FOVz = 3000e-6;

%% 
tic
G = treeGeneration([FOVx, FOVy, FOVz], [FOVx/2, FOVy/2, FOVz], 8.33/100000000, 133000000, 83000000 , N, FOVx/10, FOVx);
toc
% G.Edges.r = 2e-6*ones(size(G.Edges.r));
%%
figure;
coords = cell2mat(G.Nodes.Coord);
rfact = 10/max(G.Edges.r);
plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact)
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,1,1])
%%
tic
cyl = graph2cylinders(G);
f = 1;
[BinaryMat] = binarycyl3D(X, Y, Z, f*FOVx, f*FOVy, f*FOVz, cyl.startPoints, cyl.endPoints, cyl.radii);
toc