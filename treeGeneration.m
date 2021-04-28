function G = treeGeneration(spaceDimensions, perfPosition, Qperf, Pperf, Pterm, Nterm, Lmin)
% ----------------------------------
% Generates a graph object representing a vascular tree
% Inputs:
% - spaceDimensions = 1x3 vector, size of the target space (m), e.g. [250, 250, 750]*1e-6
% - perfPosition = 1x3 vector, position of the perfusion point in the target space (m), e.g. [125,125,750]*1e-6
% - Qperf = scalar, initial perfusion flux (UNIT)
% - Pperf = scalar, initial perfusion pressure (UNIT)
% - Pterm = scalar, terminal perfusion pressure (UNIT)
% - Nterm = scalar, desired number of teminal nodes
% - Lmin = minimal distance between a node and a branch (m), e.g. 1e-6
% Outputs:
% - G = graph object, nodes represent the tree bifurcations, edges
% represent the branches
% ADD NODES AND EDGES DESCRIPTION
% ----------------------------------
warning('off');
%% Hardcoded parameters
% initiate a max number of tries to place a new point to avoid infinite loops
maxTries = 1000;

% number of closest branches to consider when placing a new node
nClosest = 1; % will be 5 or 10 in the future


%% Initiate graph
G = graph;


%% create perfusion node
G = addnode(G, 'n0');
G.Nodes.Coord{1}=perfPosition;


%% add first terminal node and first edge

% we might need a function that gets a random point in a defined space
% here the point can be anywhere in the volume but that might not be true
% for further use
coord = createRandCoord(spaceDimensions);
G = addnode(G, 'n1');
G.Nodes.Coord{2}=coord;
G = addVascEdge(G, 'n0', 'n1');
%% Loop over number of required terminal nodes
nTries = 0;
while (size(G.Nodes, 1) < Nterm && nTries <= maxTries)
    nTries = nTries+1;
    coord = createRandCoord(spaceDimensions);
    % Check if not too close from other nodes / branch (compare with  Lmin)
    % if trop près
    % continue % ends this while iteration and passes to the next
    %end
    
    % compute distance to mid-branches
    distances = pdist2(coord, G.Edges.middle);

    % remove points that are too close to branches
    % distances = distances(distances>Lmin);
    
    % keep only the nClosest branches (or less if less than nClosest
    % branches are available)
    [sortedDistances, sortingIdx] = sort(distances);
    closestBranchesIdx = sortingIdx(1:min(numel(sortingIdx), nClosest));
    
    % loop on these branches
    score = inf;
    for i = 1:numel(closestBranchesIdx)
        % create a temp G
        % tmpG = G;
        n = numnodes(G);
        tmpG = addnode(G,['n',num2str(n)]);
        tmpG.Nodes.Coord{numnodes(tmpG)}=coord;
        edgeName = tmpG.Edges.Name{closestBranchesIdx(i)};
        tmpG=branchNode(tmpG, edgeName, ['n',num2str(n)]);
        
        % check for collision
        
        % Go up and down the tree to compute a score to minimize (volume?)
        % [tempG, tmpScore] = updateTree(tempG);
        % for the moment:
        bestG = tmpG;
        tmpScore = 0;
        if tmpScore < score
            bestG = tmpG;
            score = tmpScore;
        end
    end
    
    % There we should have found the best candidate, so we keep it
    G = bestG;
    
    % Go into bifurcation position optimization
    %G = optimizeBifurcation(G);
    
    % We successfully added a new node! Reset try counter and go for next
    % node
    nTries = 0;
end



