function [G, score] = findBestBif(G, coord, branchIdx, Qterm, visc, deltaP, Lmin, flagOptim)
% fprintf('======================== Trying branch %i / %i ========================\n', i, numel(closestBranchesIdx))
%         cyl = graph2cylinders(G);
%         [BinaryMat] = binarycyl3D(spaceDimensions(1), spaceDimensions(2), spaceDimensions(3), cyl.startPoints, cyl.endPoints, cyl.radii);
        % create a temp G
        % tmpG = G;
        [G, candidateNodeName] = addVascNode(G, coord);
%         n = numnodes(G);
%         tmpG = addnode(G,['n',num2str(n)]);
%         tmpG.Nodes.Coord{numnodes(tmpG)}=coord;
        edgeName = G.Edges.Name{branchIdx};
%         tmpG=branchNode(tmpG, edgeName, ['n',num2str(n)]);
        G = branchNode(G, edgeName, candidateNodeName, Qterm, visc, deltaP, Lmin, flagOptim);

        score = costFunction(G);
end