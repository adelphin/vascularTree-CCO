function G = addVascEdge(G, source, target, Q_in, R_star_edge)
% Add an edge to graph G between nodes with name source and target

if nargin < 5
    R_star_edge = 100000;
end

visc = 0.036;

%% find node indices based on their name
idxSource = find(strcmp(G.Nodes.Name, source));  
idxTarget = find(strcmp(G.Nodes.Name, target));

%% Add the edge to the graph and create its parameters
EndNodes = {source, target};
Name = {[source, '-' target]};
r = 1;
Q = Q_in;
R = 0;
P = 0;
L = pdist2(G.Nodes.Coord{idxSource}, G.Nodes.Coord{idxTarget});

if G.Nodes.isTermNode(idxTarget)
    R_star = 8*visc*L/pi;
else
    R_star = R_star_edge;
end    

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

    

