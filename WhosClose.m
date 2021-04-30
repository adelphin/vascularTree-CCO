function closestBranchesIdx = WhosClose(G,coord,nClosest,Lmin)

%Returns a list of the middles' indexes that are the closest to coord and 

    % compute distance to mid-branches
    distances = pdist2(coord, cell2mat(G.Edges.middle));

    % remove points that are too close to branches
    % distances = distances(distances>Lmin);
    
    
    
    % keep only the nClosest branches (or less if less than nClosest
    % branches are available)
    [sortedDistances, sortingIdx] = sort(distances);
    
    %Testing all sorted branches for intersection
    sortedBool = [];
    for i = 1:numedges(G)
        sortedBool = [sortedBool, DoesItIntersect(G, coord, G.Edges.Name(sortingIdx(i)),Lmin)];
    end
    %we still have to delete the zeroes in : 
    table = [sortedDistances; sortingIdx; sortedBool];
    table_nointersect = table(:,logical(sortedBool));
    %we just keep what we need
    if table_nointersect(2,1:min(numel(sortingIdx), nClosest)) == []
        closestBranchesIdx=0;
    else
        closestBranchesIdx = table_nointersect(2,1:min(numel(sortingIdx), nClosest));
    end
