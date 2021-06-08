function boolIntersect = wholeTreeIntersection(G, existingGraph)

if nargin < 2
    existingGraph = [];
end

boolIntersect = 0;

% get involved branches
% newly added midPoint is the last node added
idxMidNode = numnodes(tmpG);
% get parent branch's source and edge
idxParentStart = strcmp(G.Nodes.Name, G.Nodes.parentNode{idxMidNode});
idxParentBranch = strcmp(G.Edges.Name, [G.Nodes.Name{idxParentStart} '-' G.Nodes.Name{idxMidNode}]);
% get children ends and edges
idxLeftEnd  = strcmp(G.Nodes.Name, G.Nodes.childrenNodes{idxMidNode,1});
idxLeftBranch = strcmp(G.Edges.Name, [G.Nodes.Name{idxMidNode} '-' G.Nodes.Name{idxLeftEnd}]);
idxRightEnd = strcmp(G.Nodes.Name, G.Nodes.childrenNodes{idxMidNode,2});
idxRightBranch = strcmp(G.Edges.Name, [G.Nodes.Name{idxMidNode} '-' G.Nodes.Name{idxRightEnd}]);

if isempty(existingGraph)
    toTestG = existingG;
else
    toTestG = G;
end

% test intersections
% parent
if DoesItIntersect(toTestG, idxParentBranch, G.Nodes.Coord{idxParentStart}, G.Nodes.Coord{idxMidNode}, G.Edges.r(idxParentBranch))
    % if intersection here, skip to next best solution
    return
end
% child 1
if DoesItIntersect(toTestG, idxLeftBranch, G.Nodes.Coord{idxMidNode}, G.Nodes.Coord{idxLeftEnd}, G.Edges.r(idxLeftBranch))
    % if intersection here, skip to next best solution
    return
end
% child 2
if DoesItIntersect(toTestG, idxRightBranch, G.Nodes.Coord{idxMidNode}, G.Nodes.Coord{idxRightEnd}, G.Edges.r(idxRightBranch))
    % if intersection here, skip to next best solution
    return
end
% if this point is reached, then the current solution
% considered does not intersect
boolIntersect = 0;
end