function G = branchNode(G, edgeName, nodeName, Qterm, visc, deltaP, Lmin, flagOptim)

%Connects nodeName to the middle of edgeName
%Deletes the old edge and creates the three new ones 

if nargin<8
    flagOptim = 1;
end

idxEdge = find(strcmp(G.Edges.Name, edgeName));   %returns the edge's row number in G.Edges
nameOldSource = G.Edges.EndNodes{idxEdge,1};%str format 'n[...]'
nameOldTarget = G.Edges.EndNodes{idxEdge,2};
idxOldSource = find(strcmp(G.Nodes.Name, nameOldSource));
idxOldTarget = find(strcmp(G.Nodes.Name, nameOldTarget));

[G, midName] = addVascNode(G, G.Edges.middle{idxEdge}, 0);

QOldEdge = G.Edges.Q(idxEdge);
R_star_Old = G.Edges.Q(idxEdge);
G = rmedge(G, idxEdge);                           %remove the old one

% need to remove child from parent node
idxFormerChild = find(strcmp(G.Nodes{idxOldSource, 'childrenNodes'}, G.Nodes.Name{idxOldTarget}));
G.Nodes{idxOldSource, 'childrenNodes'}{idxFormerChild} = '';

G = addVascEdge(G, nameOldSource, midName, QOldEdge, R_star_Old);
G = addVascEdge(G, midName, nameOldTarget, QOldEdge, R_star_Old);
G = addVascEdge(G, midName, nodeName, Qterm);

%%
% G = updateTree(G, [midName, '-', nodeName], visc, deltaP);
if flagOptim
    coordBestBif = optimizeBifurcation(G, [midName,'-',nodeName], visc, deltaP, Lmin);
    idxBif = strcmp(G.Nodes.Name, midName);
    G.Nodes.Coord{idxBif} = coordBestBif;
end

G = updateTree(G, [midName, '-', nodeName], visc, deltaP);

end









