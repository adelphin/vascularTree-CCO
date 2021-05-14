close all
res = 10;

% define 1st plane
x1 = 0.5;
y1 = 0.5;
z1 = 0;
v1 = [0,0,1];
% plot it
w = null(v1); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(-res:res); % Provide a gridwork (you choose the size)
X = x1+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = y1+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = z1+w(3,1)*P+w(3,2)*Q;
surf(X,Y,Z)

hold on

%define second plane
P1 = rand(1,3)*res;
P2 = rand(1,3)*res;
P3 = rand(1,3)*res;
v2 = cross(P1-P2, P1-P3);

%plot it
w = null(v2); % Find two orthonormal vectors which are orthogonal to v
[P,Q] = meshgrid(-res:res); % Provide a gridwork (you choose the size)
X = P1(1)+w(1,1)*P+w(1,2)*Q; % Compute the corresponding cartesian coordinates
Y = P1(2)+w(2,1)*P+w(2,2)*Q; %   using the two vectors in w
Z = P1(3)+w(3,1)*P+w(3,2)*Q;
surf(X,Y,Z)
plot3(P1(1), P1(2), P1(3), 'd', 'MarkerFaceColor', 'r', 'MarkerSize', 12)
plot3(P2(1), P2(2), P2(3), 'd', 'MarkerFaceColor', 'y', 'MarkerSize', 12)
plot3(P3(1), P3(2), P3(3), 'd', 'MarkerFaceColor', 'c', 'MarkerSize', 12)

% get rotation axis
[intersectPoint,intersectVect,check]=plane_intersect(v1,[x1,y1,z1],v2,P1);
% get angle to rotate
angle = atan2(norm(cross(v1,v2)),dot(v1,v2));
angle = angle*180/pi;
% get rotation matrix
[newPoints, rotMat, t] = AxelRot([P1', P2', P3'], -angle, intersectVect, intersectPoint);

% get rotated points
plot3(newPoints(1,1), newPoints(2,1), newPoints(3,1), 'h', 'MarkerFaceColor', 'r', 'MarkerSize', 12)
plot3(newPoints(1,2), newPoints(2,2), newPoints(3,2), 'h', 'MarkerFaceColor', 'y', 'MarkerSize', 12)
plot3(newPoints(1,3), newPoints(2,3), newPoints(3,3), 'h', 'MarkerFaceColor', 'c', 'MarkerSize', 12)


%inverse rotation
[invPoints, rotMat, t] = AxelRot(newPoints, angle, intersectVect, intersectPoint);
plot3(invPoints(1,1), invPoints(2,1), invPoints(3,1), 'or', 'MarkerSize', 12)
plot3(invPoints(1,2), invPoints(2,2), invPoints(3,2), 'oy', 'MarkerSize', 12)
plot3(invPoints(1,3), invPoints(2,3), invPoints(3,3), 'oc', 'MarkerSize', 12)
