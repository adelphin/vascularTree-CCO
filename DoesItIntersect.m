function [table] = DoesItIntersect(G,candNode,candEdge)

%Check if the min distance between a future branch and every other one in
%the graph recedes a threshold, defined by the sum of the two branche's
%radii

%candNode should be in 'n5831454514' format, and candEdge in 'n81341-n5841'

% table is as [edge_to_connect_to  distance  boolean] (1 if it does intersect) 


%let's extract coord. information
P1 = G.Nodes.Coord{find(strcmp(G.Nodes.Name, candNode))};

idxEdge = find(strcmp(G.Edges.Name, candEdge));
P2 = G.Edges.middle{idxEdge};
R = G.Edges.R{idxEdge};

nsource = G.Edges.EndNodes{idxEdge,1};
P3 = G.Nodes.Coord{find(strcmp(G.Nodes.Name, nsource))};
ntarget = G.Edges.EndNodes{idxEdge,2};
P4 = G.Nodes.Coord{find(strcmp(G.Nodes.Name, ntarget))};
R_future = 1;

dist = DistBetween2Segment(P1, P2, P3, P4);
boolean = dist <= R + R_future;
table = [candEdge dist boolean];
