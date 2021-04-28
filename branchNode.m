function G = branchNode(G, edgeName, nodeName)

%Connects nodeName to the middle of edgeName
%Deletes the old edge and creates the three new ones 

idx = find(strcmp(G.Edges.Name, edgeName));   %returns the edge's row number in G.Edges
old_target = G.Edges.EndNodes{idx,2};         %str format 'n[...]'
old_source = G.Edges.EndNodes{idx,1};
n = numnodes(G);
N = num2str(n);
% N = num2str(numnodes(G)+1);
% n = str2num(N);
midName=['n' N];                              %assignment of a str as Name for the node to come

G = addnode(G,midName);
G.Nodes.Coord{n+1}= G.Edges.middle(idx,:);

G = rmedge(G, idx);                           %remove the old one
G = addVascEdge(G, old_source, midName);
G = addVascEdge(G, midName, old_target);
G = addVascEdge(G, midName, nodeName);

end









