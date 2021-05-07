function score = moveBif(x)

[G, globNameNewEdge, globVisc, globDeltaP, rotParam] = getGlobalParameters();
% replace bif point in the right plane
[inBifPlaneX, ~, ~] = AxelRot([x; 0], rotParam.angle, rotParam.vect, rotParam.point);
idxBif = strcmp(G.Nodes.Name, G.Edges{strcmp(G.Edges.Name, globNameNewEdge), 'EndNodes'}{1}); 
G.Nodes.Coord{idxBif} = inBifPlaneX';
G = updateTree(G, globNameNewEdge, globVisc, globDeltaP);
score = costFunction(G);

% fprintf('%s, %g\n', sprintf('%f ',x), score)
end