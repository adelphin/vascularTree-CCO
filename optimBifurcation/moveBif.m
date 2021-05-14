function score = moveBif(x, G, nameNewEdge, visc, deltaP, rotParam)

% [G, nameNewEdge, visc, deltaP, rotParam] = getGlobalParameters();
% replace bif point in the right plane
[inBifPlaneX, ~, ~] = AxelRot([x; 0], rotParam.angle, rotParam.vect, rotParam.point);
idxBif = strcmp(G.Nodes.Name, G.Edges{strcmp(G.Edges.Name, nameNewEdge), 'EndNodes'}{1}); 
G.Nodes.Coord{idxBif} = inBifPlaneX';
G = updateTree(G, nameNewEdge, visc, deltaP);
score = costFunction(G);

% fprintf('%s, %g\n', sprintf('%f ',x), score)
end