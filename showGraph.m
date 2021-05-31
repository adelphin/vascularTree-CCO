N = 5;
X = 200; 
Y = 200;
Z = 200;
FOVx = 1600e-6;
FOVy = 1600e-6;
FOVz = 1600e-6;

plotFlag = 1;

%% 
tic
G = treeGeneration([FOVx, FOVy, FOVz], [FOVx/2, FOVy/2, FOVz], 8.33/10000000, 133000000, 83000000 , N, 200e-6, 800e-6);
toc

%%
if plotFlag
    plotGraph(G, FOVx, FOVy, FOVz);
    tic
    [~] = plotCylinders(G, FOVx, FOVy, FOVz, X, Y, Z);
    toc
end    