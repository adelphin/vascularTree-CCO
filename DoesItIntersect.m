function boolean = DoesItIntersect(G,coord,candEdge)

%Check if the min distance between a future branch and every other one in
%the graph excedes a threshold, defined by the sum of the two branche's
%radii
%candEdge should be in 'n81341-n5841' format

%let's extract coord. information
idxEdge = find(strcmp(G.Edges.Name, candEdge));  %returns candEdge's index in G.Edges
P2 = G.Edges.middle{idxEdge}; 
rayon = G.Edges.r(idxEdge);


%looping on all branches except candEdge
boolean = 0;
    for i = 1:numedges(G)
        if i == idxEdge
            boolean = 0;
            continue
        else
            nsource = G.Edges.EndNodes{i,1};
            P3 = G.Nodes.Coord{strcmp(G.Nodes.Name, nsource)};
            ntarget = G.Edges.EndNodes{i,2};
            P4 = G.Nodes.Coord{strcmp(G.Nodes.Name, ntarget)};
            R_future = 1e-6;

            dist = DistBetween2Segment(coord, P2, P3, P4);
            boolean = dist <= rayon + R_future;
            if boolean == 1
                break           %as soon as criteria is broken, we stop
            else
                continue
            end
        end
    end
end
