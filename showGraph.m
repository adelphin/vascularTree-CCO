N = 7;
X = 100; 
Y = 100;
Z = 300;

% G = genTemplateGraph(N, X, Y, Z); % creates G
% cyl = graph2cylinders(G);
% 
% [BinaryMat] = binarycyl3D(X, Y, Z, cyl.startPoints, cyl.endPoints, cyl.radii);


%% 
G = treeGeneration([X, Y, Z], [X/2,Y/2,Z], 1, 1, 1, 100, 1);

%%

G.Edges.r(:) = linspace(5,1,numedges(G));
%%
cyl = graph2cylinders(G);
[BinaryMat] = binarycyl3D(X, Y, Z, cyl.startPoints, cyl.endPoints, cyl.radii);