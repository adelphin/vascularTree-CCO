function plotGraph(G, FOVx, FOVy, FOVz)

coords = cell2mat(G.Nodes.Coord);
rfact = 10/max(G.Edges.r);

figure;
subplot(2,2,[1,3])
plot(G, 'XData', coords(:,1), 'YData', coords(:,2),'ZData', coords(:,3), 'LineWidth',G.Edges.r*rfact)
hold on
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,FOVy/FOVx,FOVz/FOVx])

subplot(subplot(2,2,2))
histogram(G.Edges.r, floor(numedges(G)/4))
xlabel('Branches radii (m)')

subplot(subplot(2,2,4))
histogram(G.Edges.L, floor(numedges(G)/4))
xlabel('Branches Lengths (m)')