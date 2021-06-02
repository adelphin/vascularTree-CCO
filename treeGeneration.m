function G = treeGeneration(pathParamFile)
% ----------------------------------
% Generates a graph object representing a vascular tree
% Inputs:
% - spaceDimensions = 1x3 vector, size of the target space (m), e.g. [250, 250, 750]*1e-6
% - perfPosition = 1x3 vector, position of the perfusion point in the target space (m), e.g. [125,125,750]*1e-6
% - Qperf = scalar, initial perfusion flux (m/h/kg)
% - Pperf = scalar, initial perfusion pressure (mmHg)
% - Pterm = scalar, terminal perfusion pressure (mmHg)
% - Nterm = scalar, desired number of teminal nodes
% - Lmin = minimal distance between a node and a branch (m), e.g. 1e-6
% Outputs:
% - G = graph object, nodes represent the tree bifurcations, edges
% represent the branches
% ADD NODES AND EDGES DESCRIPTION
% ----------------------------------
warning('off');
%% Toolbox flags
flagParallel = 1; % Turn this to 0 if you don't have the parallel computing toolbox
flagOptim = 1; % Turn this to 0 if you don't have the optimization toolbox

%% Parameters parsing
[spaceDimensions, perfPosition, Qperf, Pperf, Pterm, Nterm, Lmin, Lmax] = readTreeParameters(pathParamFile);

%% Hardcoded parameters
% initiate a max number of tries to place a new point to avoid infinite loops
maxTries = 100000;
visc = 0.036; % 36mPa.sec
% number of closest branches to consider when placing a new node
nClosest = 5; % will be 5 or 10 in the future

%% Initiate graph
G = digraph;
Qterm = Qperf/Nterm; %Qperf = Nterm * Qterm
deltaP = Pperf-Pterm;

%% create perfusion node
G = addVascNode(G, perfPosition, 0, 'n0');
% G = addnode(G, 'n0');
% G.Nodes.Coord{1}=perfPosition;


%% add first terminal node and first edge

% we might need a function that gets a random point in a defined space
% here the point can be anywhere in the volume but that might not be true
% for further use
coord = createRandCoord(spaceDimensions);
G = addVascNode(G, coord);
% G = addnode(G, 'n1');
% G.Nodes.Coord{2}=coord;
G = addVascEdge(G, 'n0', 'n1', Qterm); %Qterm, so that after N terminal nodes we have Qperf
G = updateTree(G, 'n0-n1', visc, deltaP);
%% Loop over number of required terminal nodes
nTries = 0;
while (sum(G.Nodes.isTermNode) < Nterm && nTries <= maxTries)
    if nTries ==0
        fprintf('======================== Placing terminal node %i ========================\n', sum(G.Nodes.isTermNode)+1)
    end
    nTries = nTries+1;
    coord = createRandCoord(spaceDimensions);
    
    % Check if not too close from other nodes / branch (compare with  Lmin)
    % if too close
    % continue % ends this while iteration and passes to the next
    %end
    closestBranchesIdx = WhosClose(G,coord,nClosest,Lmin, Lmax);
    if closestBranchesIdx == 0
        continue
    end
    
    if flagParallel
        % loop on these branches
        Futures(1:numel(closestBranchesIdx)) = parallel.FevalFuture; 
        for i = 1:numel(closestBranchesIdx)
            Futures(i) = parfeval(@findBestBif, 2, G, coord, closestBranchesIdx(i), Qterm, visc, deltaP, Lmin, flagOptim);
        end

        for i =1:numel(closestBranchesIdx)
            [~, score] = Futures(i).fetchOutputs;
        end

        [~, idxMin] = min(score);
        [G, ~] = Futures(idxMin).fetchOutputs;
    
    else
        % loop on these branches
        score = inf;
        for i = 1:numel(closestBranchesIdx)
            fprintf('============ Trying candidate branch %i/%i ============\n', i, numel(closestBranchesIdx))
            [tmpG, candidateNodeName] = addVascNode(G, coord);
            edgeName = tmpG.Edges.Name{closestBranchesIdx(i)};
            tmpG = branchNode(tmpG, edgeName, candidateNodeName, Qterm, visc, deltaP, Lmin, flagOptim);
            tmpScore = costFunction(tmpG);
            if tmpScore < score
                bestG = tmpG;
                score = tmpScore;
            end
        end
%         
%         figure;
%         coords = cell2mat(G.Nodes.Coord);
%         rfact = 10/max(G.Edges.r);
%         plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact)

            
        % There we should have found the best candidate, so we keep it
        G = bestG;
    end
    
    % We successfully added a new node! Reset try counter and go for next
    % node
    nTries = 0;
end



