function plotGraph(G, FOVx, FOVy, FOVz)

coords = cell2mat(G.Nodes.Coord);
rfact = 10/max(G.Edges.r);

figure;
subplot(2,2,[1,3])
h = plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact, 'ArrowSize', 0);
hold on
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,FOVy/FOVx,FOVz/FOVx])

% nameList = {'a', 'v', 'n'};
% colorList = {'r', 'b', 'g'};
% for i = 1:numel(nameList)
%     idxEdges = cellfun(@contains,G.Edges.Name, repmat(nameList(i), [numel(G.Edges.Name), 1]));
%     sG = digraph;
%     sG = addnode(sG, G.Nodes);
%     sG = addedge(sG, G.Edges(idxEdges,:));
%     highlight(h, sG, 'EdgeColor', colorList{i}, 'NodeColor', colorList{i})
% end

subplot(subplot(2,2,2))
histogram(G.Edges.r, floor(numedges(G)/16))
xlabel('Branches radii (m)')

subplot(subplot(2,2,4))
histogram(G.Edges.L, floor(numedges(G)/16))
xlabel('Branches Lengths (m)')