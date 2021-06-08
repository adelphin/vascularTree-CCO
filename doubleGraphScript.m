aG = treeGeneration('arterialGraph.txt');
vG = treeGeneration('venousGraph.txt', aG);

plotDoubleGraph(aG, vG, 1600e-6, 1600e-6, 1600e-6)