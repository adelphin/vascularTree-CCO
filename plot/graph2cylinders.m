function cyl = graph2cylinders(G)
% -----------------------------------------------
% Reads a graph file to create a structure matching our plotting needs
% cyl struct contains list of end and start points ([N,3], with N = number of edges)
% + radius list ([N,1], µm)
% -----------------------------------------------

% Initialize volumes (not directly in the struct, might be useful if we
% need to parallelize)
startPoints = nan(size(G.Edges,1), 3);
endPoints = nan(size(G.Edges,1), 3);
radii = nan(size(G.Edges,1),1);

% factor for visualisation purpose during dev, should be 1 in the end
fact = 1; 

% Go through the edges to get start and end coordinates + radius
% rfact = 1/min(G.Edges.r);
for i = 1 : size(G.Edges, 1)
    idx1 = find(strcmp(G.Nodes.Name, G.Edges.EndNodes{i,1}));  
    idx2 = find(strcmp(G.Nodes.Name, G.Edges.EndNodes{i,2}));  
    startPoints(i,:) = fact * [G.Nodes.Coord{idx1}(1), G.Nodes.Coord{idx1}(2), G.Nodes.Coord{idx1}(3)];
    endPoints(i,:) = fact * [G.Nodes.Coord{idx2}(1), G.Nodes.Coord{idx2}(2), G.Nodes.Coord{idx2}(3)];
    radii(i) = G.Edges.r(i);
end

% Put them in cyl struct
cyl.startPoints = startPoints;
cyl.endPoints = endPoints;
cyl.radii = radii;

