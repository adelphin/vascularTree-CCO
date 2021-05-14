function G = computeRadius(G, nameCurrEdge)

idxCurrEdge = strcmp(G.Edges.Name, nameCurrEdge);

idxEndNode = strcmp(G.Nodes.Name, G.Edges{idxCurrEdge, 'EndNodes'}(2));

if ~G.Nodes.isTermNode(idxEndNode)
    % find children edges
    idxChildrenEdges = strcmp(G.Edges{:,'EndNodes'}(:,1), G.Edges{idxCurrEdge, 'EndNodes'}(2));
    
    % compute radii ratios
    [f_left, f_right] = computeRatios(G, idxChildrenEdges);
   
    % obtain radii
    r_left = G.Edges.r(idxCurrEdge) * f_left;
    r_right = G.Edges.r(idxCurrEdge) * f_right;
    
    % assign them
    G.Edges.r(idxChildrenEdges) = [r_left; r_right];
    
    % pass to the children edges
    namesChildrenEdges = G.Edges.Name(idxChildrenEdges);
    G = computeRadius(G, namesChildrenEdges{1});
    G = computeRadius(G, namesChildrenEdges{2});
end
