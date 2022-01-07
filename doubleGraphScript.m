aG = treeGeneration('arterialGraph.txt');
vG = treeGeneration('venousGraph.txt', aG);

plotDoubleGraph(aG, vG, 1600e-6, 1600e-6, 1600e-6)

%%
cGraph = microClosure(aG, vG, 1, 1, 1);

%%
cGraph.Edges.r(cGraph.Edges.r == 1) = min(cGraph.Edges.r);
plotGraph(cGraph, 1600e-6, 1600e-6, 1600e-6);