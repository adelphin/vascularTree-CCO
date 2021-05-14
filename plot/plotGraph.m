function plotGraph(G, FOVx, FOVy, FOVz)

figure;
coords = cell2mat(G.Nodes.Coord);
rfact = 10/max(G.Edges.r);
plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact)
hold on
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,FOVy/FOVx,FOVz/FOVx])