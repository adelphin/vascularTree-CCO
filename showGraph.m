path = 'parFiles/exampleGraph.txt';

plotFlag = 1;

%% 
tic
G = treeGeneration(path);
toc

%%
spaceDimensions = readTreeParameters(path);
X = 200; 
Y = 200; 
Z = 200;
if plotFlag
    plotGraph(G, spaceDimensions(1), spaceDimensions(2), spaceDimensions(3));
    tic
    [~] = plotCylinders(G, spaceDimensions(1), spaceDimensions(2), spaceDimensions(3), X, Y, Z);
    toc
end    