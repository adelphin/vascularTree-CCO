function plotDoubleGraph(aG, vG , FOVx, FOVy, FOVz)


coordsA = cell2mat(aG.Nodes.Coord);
rfactA = 10/max(aG.Edges.r);

coordsV = cell2mat(vG.Nodes.Coord);
rfactV = 10/max(vG.Edges.r);

figure;
subplot(4,2,[1,3,5,7])
plot(aG, 'XData', coordsA(:,1), 'YData', coordsA(:,2), 'ZData', coordsA(:,3), 'LineWidth', aG.Edges.r*rfactA, ...
    'EdgeColor', 'r', 'NodeColor', 'r', 'EdgeAlpha',0.9, 'ArrowSize', 0)
hold on
plot(vG, 'XData', coordsV(:,1), 'YData', coordsV(:,2), 'ZData', coordsV(:,3), 'LineWidth', vG.Edges.r*rfactV, ...
    'EdgeColor', 'b', 'NodeColor', 'b', 'EdgeAlpha',0.9, 'ArrowSize', 0)
xlim([0, FOVx])
ylim([0, FOVy])
zlim([0, FOVz])
pbaspect([1,FOVy/FOVx,FOVz/FOVx])

subplot(subplot(4,2,2))
histogram(aG.Edges.r, floor(numedges(aG)/4), 'FaceColor', 'r')
xlabel('Branches radii (m)')

subplot(subplot(4,2,4))
histogram(aG.Edges.L, floor(numedges(aG)/4),  'FaceColor', 'r')
xlabel('Branches Lengths (m)')

subplot(subplot(4,2,6))
histogram(vG.Edges.r, floor(numedges(vG)/4), 'FaceColor', 'b')
xlabel('Branches radii (m)')

subplot(subplot(4,2,8))
histogram(vG.Edges.L, floor(numedges(vG)/4), 'FaceColor', 'b')
xlabel('Branches Lengths (m)')