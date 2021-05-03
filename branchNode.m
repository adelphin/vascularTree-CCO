function G = branchNode(G, edgeName, nodeName, Qterm, visc, deltaP)

%Connects nodeName to the middle of edgeName
%Deletes the old edge and creates the three new ones 

idxEdge = find(strcmp(G.Edges.Name, edgeName));   %returns the edge's row number in G.Edges
nameOldSource = G.Edges.EndNodes{idxEdge,1};%str format 'n[...]'
nameOldTarget = G.Edges.EndNodes{idxEdge,2};
idxOldSource = find(strcmp(G.Nodes.Name, nameOldSource));
idxOldTarget = find(strcmp(G.Nodes.Name, nameOldTarget));

[G, midName] = addVascNode(G, G.Edges.middle{idxEdge}, 0);

% n = numnodes(G);
% N = num2str(n);
% N = num2str(numnodes(G)+1);
% n = str2num(N);



% midName=['n' N];                              %assignment of a str as Name for the node to come

% G = addnode(G,midName);
% G.Nodes.Coord{n+1}= G.Edges.middle(idxEdge,:);

QOldEdge = G.Edges.Q(idxEdge);
R_star_Old = G.Edges.Q(idxEdge);
G = rmedge(G, idxEdge);                           %remove the old one
% need to remove child from parent node
idxFormerChild = find(strcmp(G.Nodes{idxOldSource, 'childrenNodes'}, G.Nodes.Name{idxOldTarget}));
G.Nodes{idxOldSource, 'childrenNodes'}{idxFormerChild} = '';

G = addVascEdge(G, nameOldSource, midName, QOldEdge, R_star_Old);
G = addVascEdge(G, midName, nameOldTarget, QOldEdge, R_star_Old);
G = addVascEdge(G, midName, nodeName, Qterm);

G = updateTree(G, [midName, '-', nodeName], visc, deltaP);

end









