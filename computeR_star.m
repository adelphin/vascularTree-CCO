function G = computeR_star(G, nameEdge,visc)
% Computes R_star for the current edge, based on the children edges

% we can get the children from the edge's end point

idxEdge = strcmp(G.Edges.Name, nameEdge);
nameEndPoint = G.Edges{idxEdge, 'EndNodes'}{2};
idxChildrenEdges = strcmp(G.Edges{:,'EndNodes'}(:,1), nameEndPoint); % finds idx of edges starting on nameSourcePoint
    
    R_starChildren = G.Edges.R_star(idxChildrenEdges);
    LEdge = G.Edges.L(idxEdge);
    
    % get the radii ratios
    [f_left, f_right] = computeRatios(G, idxChildrenEdges);
    
    G.Edges.R_star(idxEdge) = (8*visc*LEdge/pi) + ...
        (    (f_left ^4)/R_starChildren(1)...
          +  (f_right^4)/R_starChildren(2)    )^-1; % Equation 6 in VascuSynth
      
end