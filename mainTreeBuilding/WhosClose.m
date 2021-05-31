function closestBranchesIdx = WhosClose(G,coord,nClosest,Lmin, Lmax)

%Returns a list of the middles' indexes that are the closest to coord

    % compute distance to mid-branches
    distances = pdist2(coord, cell2mat(G.Edges.middle))';

    % get min and max possible branch length according to number of
    % bifurcation above
    minLmin = 80e-6;
    minLmax = 200e-6;
    lengthRange = getLengthRange(G, Lmin, Lmax, minLmin, minLmax);
    [sortedDistances, sortingIdx] = sort(distances);
    sortedRange = lengthRange(sortingIdx, :);
    
    sortingIdx = sortingIdx(sortedDistances>sortedRange(:,1) & sortedDistances<sortedRange(:,2));
    if isempty(sortingIdx)
        closestBranchesIdx=0;
        return
    else
        sortingIdx = sortingIdx(G.Edges.L(sortingIdx)>2*sortedRange(sortingIdx,1));
    end
    
    
    
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
%     table = [sortingIdx; sortedBool'];
%     table_nointersect = table(:,~logical(sortedBool));
    table_nointersect = sortingIdx(~logical(sortedBool'));
    %we just keep what we need
    if isempty(table_nointersect)
        closestBranchesIdx=0;
    else
        closestBranchesIdx = table_nointersect(1,1:min(size(table_nointersect, 2), nClosest));
    end
