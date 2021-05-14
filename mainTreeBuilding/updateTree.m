function G = updateTree(G, nameLastAddedEdge, visc, deltaP)
% Updates the tree from a newly added edge (from bifurcation to new end point) up to the top, then goes back down to each terminal node

idxLastAddedEdge = strcmp(G.Edges.Name, nameLastAddedEdge);
% find bifurcation point
nameBifPoint = G.Edges{idxLastAddedEdge, 'EndNodes'}{1};
idxBifPoint = strcmp(nameBifPoint, G.Nodes.Name);

if numedges(G) > 1
% find parent edge
idxParentEdge = strcmp(G.Edges.Name, [G.Nodes.parentNode{idxBifPoint}, '-', nameBifPoint]);
idxParentNode = strcmp(G.Nodes.Name, G.Nodes.parentNode{idxBifPoint}); 
% find other children edge
idxChildrenEdges = strcmp(G.Edges.EndNodes(:,1), nameBifPoint);
idxOtherChildEdge = idxChildrenEdges ~= idxLastAddedEdge;

idxChildEdgeEndNode = strcmp(G.Nodes.Name, G.Edges.EndNodes{idxOtherChildEdge,2});
% update lengths
G.Edges.L(idxParentEdge) = pdist2(G.Nodes.Coord{idxParentNode}, G.Nodes.Coord{idxBifPoint});
G.Edges.L(idxOtherChildEdge) = pdist2(G.Nodes.Coord{idxBifPoint}, G.Nodes.Coord{idxChildEdgeEndNode});
G.Edges.L(idxLastAddedEdge) = pdist2( G.Nodes.Coord{idxBifPoint}, ...
    G.Nodes.Coord{ strcmp(G.Nodes.Name, G.Edges.EndNodes(idxLastAddedEdge, 2)) });

% update middle coordinates
G.Edges.middle{idxParentEdge} = (G.Nodes.Coord{idxParentNode} + G.Nodes.Coord{idxBifPoint})/2;
G.Edges.middle{idxOtherChildEdge} = (G.Nodes.Coord{idxBifPoint} + G.Nodes.Coord{idxChildEdgeEndNode})/2;
G.Edges.middle{idxLastAddedEdge} = (G.Nodes.Coord{idxBifPoint} + G.Nodes.Coord{ strcmp(G.Nodes.Name, G.Edges.EndNodes(idxLastAddedEdge, 2))})/2;

end

%% First step: go up the tree, adding Qterm to all edges above and updating R_star
% need to loop up to the perfusion node, e.g. the only one without parent
idxSourcePoint = idxBifPoint;
nameSourcePoint = nameBifPoint;
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
