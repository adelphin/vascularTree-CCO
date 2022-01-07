function mergedGraph = mergeGraphs(aG, vG)

% Merges two graphs aG and vG into a single one.
% All nodes in aG (vG) will be names as 'a0' ('v0') 
% A node property "isArterial" is added, 1 for aG, 0 for vG

aG = renameGraph(aG, 'a');
% aG.Nodes.isArterial = ones(numnodes(aG), 1);

vG = renameGraph(vG, 'v');
% vG.Nodes.isArterial = zeros(numnodes(vG), 1);

mergedGraph = digraph;
mergedGraph = addnode(mergedGraph, aG.Nodes);
mergedGraph = addedge(mergedGraph, aG.Edges);
mergedGraph = addnode(mergedGraph, vG.Nodes);
mergedGraph = addedge(mergedGraph, vG.Edges);