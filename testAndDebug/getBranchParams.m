function [radiiList, lengthList] = getBranchParams(G)

termNodes = G.Nodes.Name(logical(G.Nodes.isTermNode));

N = numel(termNodes);
radiiList = cell(N,1);
lengthList = cell(N,1);

for i = 1:N
    pathNodes = shortestpath(G, 'n0', termNodes{i});
    r = zeros(1,numel(pathNodes)-1);
    L = zeros(1,numel(pathNodes)-1);
    for j = 1:numel(pathNodes)-1
        edgeIdx = strcmp(G.Edges.Name, [pathNodes{j}, '-', pathNodes{j+1}]);
        r(j) = G.Edges.r(edgeIdx);
        L(j) = G.Edges.L(edgeIdx);
    end
    radiiList{i} = r;
    lengthList{i} = L;
end