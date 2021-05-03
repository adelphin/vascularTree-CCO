function G = updateTree(G, nameLastAddedEdge, visc, deltaP)
% Updates the tree from a newly added edge up to the top, then goes back down to each terminal node

idxLastAddedEdge = strcmp(G.Edges.Name, nameLastAddedEdge);

%% First step: go up the tree, adding Qterm to all edges above and updating R_star
% need to loop up to the perfusion node, e.g. the only one without parent

idxCurrEdge = idxLastAddedEdge;
nameSourcePoint = G.Edges{idxCurrEdge, 'EndNodes'}{1};
idxSourcePoint = strcmp(G.Edges{idxCurrEdge, 'EndNodes'}{1}, G.Nodes.Name);
nameSourcePointParent = G.Nodes.parentNode{idxSourcePoint};

while ~isempty(nameSourcePointParent) 
    % find ancestor edge
    nameCurrEdge = [nameSourcePointParent, '-', nameSourcePoint];
    idxCurrEdge = strcmp(G.Edges.Name, nameCurrEdge);
    
    % update Q
    G.Edges.Q(idxCurrEdge) = G.Edges.Q(idxCurrEdge) + G.Edges.Q(idxLastAddedEdge);
    
    % update R_star
    G = computeR_star(G, nameCurrEdge, visc);
    
    % go on along the tree
    nameSourcePoint = G.Edges{idxCurrEdge, 'EndNodes'}{1};
    idxSourcePoint = strcmp(nameSourcePoint, G.Nodes.Name);
    nameSourcePointParent = G.Nodes.parentNode{idxSourcePoint};
end

%% Second step: go down the tree to update R
% start by computing rperf
G = computePerfRadius(G, deltaP);
% recursively compute r in lower branches
G = computeRadius(G, G.Edges.Name{1});
