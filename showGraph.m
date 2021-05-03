N = 10;
X = 100; 
Y = 100;
Z = 300;
FOVx = 100e-6;
FOVy = 100e-6;
FOVz = 300e-6;

%% 
G = treeGeneration([FOVx, FOVy, FOVz], [FOVx/2, FOVy/2, FOVz], 8.33/10000, 133000, 83000 , N, 1);
%%

% G.Edges.r = 2e-6*ones(size(G.Edges.r));
%%
figure;
coords = cell2mat(G.Nodes.Coord);
rfact = 1/min(G.Edges.r);
plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact)
pbaspect([1,1,3])
%%
cyl = graph2cylinders(G);
[BinaryMat] = binarycyl3D(X, Y, Z, FOVx, FOVy, FOVz, cyl.startPoints, cyl.endPoints, cyl.radii);