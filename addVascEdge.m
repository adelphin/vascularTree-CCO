function G = addVascEdge(G, source, target)
% Add an edge to graph G between nodes with name source and target
% Initializes all the edge properties at 1

%% find node indices based on their name
idxSource = find(strcmp(G.Nodes.Name, source));  
idxTarget = find(strcmp(G.Nodes.Name, target));

%% Add the edge to the graph and create its parameters
EndNodes = {source, target};
Name = {[source, '-' target]};
r = 2;
Q = 0;
R = 0;
R_star = 0;
P = 0;
L = pdist2(G.Nodes.Coord{idxSource}, G.Nodes.Coord{idxTarget});
middle{1} = (G.Nodes.Coord{idxSource} + G.Nodes.Coord{idxTarget})/2;
edgeProp = table(EndNodes, Name, r, Q, R, R_star, P, L, middle);
G = addedge(G, edgeProp);

%% Update nodes properties
G.Nodes.parentNode{idxTarget} = source;
switch isempty(G.Nodes.childrenNodes{idxSource ,1})
    case 1
        G.Nodes.childrenNodes{idxSource, 1} = target;
    case 0
        G.Nodes.childrenNodes{idxSource, 2} = target;
    otherwise
        error('Houston, we have a situation here')
end


