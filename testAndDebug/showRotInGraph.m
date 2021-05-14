res = 1;
% define 1st plane
x1 = 0;
y1 = 0;
z1 = 0;
v1 = [0,0,1];
% plot it
w = null(v1); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(-res:res); % Provide a gridwork (you choose the size)
X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = y1+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = z1+w(3,1)*P+w(3,2)*Q;
surf(X,Y,Z)

%plot it
w = null(normalBifPlane); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(-res:res); % Provide a gridwork (you choose the size)
X = P1(1)+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = P1(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = P1(3)+w(3,1)*P+w(3,2)*Q;
surf(X,Y,Z)

ptInter0 = rotParam.point;
ptInter1 = rotParam.point + rotParam.vect*1e7;

plot3([ptInter0(1); ptInter0(1)], [ptInter0(2); ptInter0(2)], [ptInter0(3); ptInter0(3)], 'p:y', 'LineWidth', 2) 
plot3([ptInter0(1); ptInter1(1)], [ptInter0(2); ptInter1(2)], [ptInter0(3); ptInter1(3)], 'p:y', 'LineWidth', 2) 
%%
Angles = linspace(0,angle, 10);
[newPoints, ~, ~] = AxelRot([P1', C1', C2'], -Angles(1), intersectVect, intersectPoint);
rotP1 = [newPoints(1,1), newPoints(2,1), newPoints(3,1)];
rotC1 = [newPoints(1,2), newPoints(2,2), newPoints(3,2)];
rotC2 = [newPoints(1,3), newPoints(2,3), newPoints(3,3)];
plot3(rotP1(1), rotP1(2), rotP1(3), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
plot3(rotC1(1), rotC1(2), rotC1(3), 'o', 'MarkerFaceColor', 'c', 'MarkerSize', 8)
plot3(rotC2(1), rotC2(2), rotC2(3), 'o', 'MarkerFaceColor', 'y', 'MarkerSize', 8)

for i = 2:9
    [newPoints, ~, ~] = AxelRot([P1', C1', C2'], -Angles(i), intersectVect, intersectPoint);
    rotP1 = [newPoints(1,1), newPoints(2,1), newPoints(3,1)];
    rotC1 = [newPoints(1,2), newPoints(2,2), newPoints(3,2)];
    rotC2 = [newPoints(1,3), newPoints(2,3), newPoints(3,3)];
    plot3(rotP1(1), rotP1(2), rotP1(3), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 4)
    plot3(rotC1(1), rotC1(2), rotC1(3), 'o', 'MarkerFaceColor', 'c', 'MarkerSize', 4)
	plot3(rotC2(1), rotC2(2), rotC2(3), 'o', 'MarkerFaceColor', 'y', 'MarkerSize', 4)
end

[newPoints, ~, ~] = AxelRot([P1', C1', C2'], -Angles(10), intersectVect, intersectPoint);
rotP1 = [newPoints(1,1), newPoints(2,1), newPoints(3,1)];
rotC1 = [newPoints(1,2), newPoints(2,2), newPoints(3,2)];
rotC2 = [newPoints(1,3), newPoints(2,3), newPoints(3,3)];
plot3(rotP1(1), rotP1(2), rotP1(3), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 8)
plot3(rotC1(1), rotC1(2), rotC1(3), 'o', 'MarkerFaceColor', 'c', 'MarkerSize', 8)
plot3(rotC2(1), rotC2(2), rotC2(3), 'o', 'MarkerFaceColor', 'y', 'MarkerSize', 8)




%% Plane equations (ax+by+cz = d)
[abc, d] = planefit([P1', C1', C2']);
refAbc = [0,0,1];
refD = 0;

sys = [abc; refAbc];
sol = [d; refD];

result = sys\sol;


