function G = addVascEdge(G, source, target)
% Add an edge to graph G between nodes with name source and target
% Initializes all the edge properties at 1

%% find node indices based on their name
idx1 = find(strcmp(G.Nodes.Name, source));  
idx2 = find(strcmp(G.Nodes.Name, target));

%% Add the edge to the graph and create its parameters
EndNodes = {source, target};
Name = {[source, '-' target]};
r = 2;
Q = 0;
R = 0;
R_star = 0;
P = 0;
L = pdist2(G.Nodes.Coord{idx1}, G.Nodes.Coord{idx2});
middle = (G.Nodes.Coord{idx1} + G.Nodes.Coord{idx2})/2;
edgeProp = table(EndNodes, Name, r, Q, R, R_star, P, L, middle);
G = addedge(G, edgeProp);

end