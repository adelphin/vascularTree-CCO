function closedGraph = microClosure(aG, vG, Qterm, visc, deltaP)

% change prefix in node names
aG = renameGraph(aG, 'a');
vG = renameGraph(vG, 'v');

offsetNodes = numnodes(aG);
offsetEdges = numedges(aG);
% get indices of terminal nodes in both trees
idxTermArt = find(aG.Nodes.isTermNode);
idxTermVen = find(vG.Nodes.isTermNode);

closedGraph = mergeGraphs(aG, vG);

% close arterial tree
for i = 1:numel(idxTermArt)
    % find closest venous branches
%     [closestIdx] = WhosClose(vG, aG.Nodes.Coord{idxTermArt(i)}, 2, 0, inf); % G,coord,nClosest,Lmin, Lmax
     distances = pdist2(aG.Nodes.Coord{idxTermArt(i)}, cell2mat(vG.Edges.middle));
     [~, sortIdx] = sort(distances);
    for j = 1:2
        % make connections
        %G, edgeName, nodeName, Qterm, visc, deltaP, Lmin, flagOptim, flagUpdate
        closedGraph = branchNode(closedGraph, closedGraph.Edges.Name{sortIdx(j) + offsetEdges}, closedGraph.Nodes.Name{idxTermArt(i)}, Qterm, visc, deltaP, 0, 0, 0);         
    end
end

% close venous tree
for i = 1:numel(idxTermVen)
    % find closest venous branches
%     [closestIdx] = WhosClose(aG, vG.Nodes.Coord{idxTermVen(i)}, 2, 0, inf); % G,coord,nClosest,Lmin, Lmax
    distances = pdist2(vG.Nodes.Coord{idxTermVen(i)}, cell2mat(aG.Edges.middle));
    [~, sortIdx] = sort(distances);
    for j = 1:2
        % make connections
        %G, edgeName, nodeName, Qterm, visc, deltaP, Lmin, flagOptim, flagUpdate
        closedGraph = branchNode(closedGraph, closedGraph.Edges.Name{sortIdx(j)}, closedGraph.Nodes.Name{idxTermVen(i) + offsetNodes}, Qterm, visc, deltaP, 0, 0, 0);         
    end
end

