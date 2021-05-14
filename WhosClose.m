function closestBranchesIdx = WhosClose(G,coord,nClosest,Lmin)

%Returns a list of the middles' indexes that are the closest to coord

    % compute distance to mid-branches
    distances = pdist2(coord, cell2mat(G.Edges.middle));
    % remove points that are too close to branches
    
    % keep only the nClosest branches (or less if less than nClosest
    % branches are available)
    [sortedDistances, sortingIdx] = sort(distances);
    sortingIdx = sortingIdx(sortedDistances>Lmin);
    sortingIdx = sortingIdx(G.Edges.L(sortingIdx)>2*Lmin);
    %sortedDistances = sortedDistances(sortedDistances>Lmin);
    %sortingIdx = sortingIdx(sortedDistances<Lmax);
%     sortingIdx = sortingIdx(sortedDistances>Lmin/(N_actuel^exposant));
%     sortedDistances = sortedDistances(sortedDistances>Lmin/(N_actuel^exposant));
%     sortingIdx = sortingIdx(sortedDistances<Lmax/(N_actuel^exposant));
    %Testing all sorted branches for intersection
    sortedBool = zeros(1,numel(sortingIdx));
    for i = 1:numel(sortingIdx)
        sortedBool(i) = DoesItIntersect(G, coord, G.Edges.Name(sortingIdx(i)));
    end
    %we still have to delete the zeroes in : 
    table = [sortingIdx; sortedBool];
    table_nointersect = table(:,~logical(sortedBool));
    %we just keep what we need
    if isempty(table_nointersect)
        closestBranchesIdx=0;
    else
        closestBranchesIdx = table_nointersect(1,1:min(size(table_nointersect, 2), nClosest));
    end
