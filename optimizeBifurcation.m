function coordBestBif = optimizeBifurcation(G, nameNewEdge, visc, deltaP, Lmin)

 
idxBif = strcmp(G.Nodes.Name, G.Edges{strcmp(G.Edges.Name, nameNewEdge), 'EndNodes'}{1});  
idxParent = strcmp(G.Nodes.Name, G.Nodes.parentNode{idxBif});
idxChild1 = strcmp(G.Nodes.Name, G.Nodes{idxBif, 'childrenNodes'}{1});
idxChild2 = strcmp(G.Nodes.Name, G.Nodes{idxBif, 'childrenNodes'}{2});

%% Identify bifurcation plane
% get coordinates of points involved in plane
P1 = G.Nodes.Coord{idxParent};
C1 = G.Nodes.Coord{idxChild1};
C2 = G.Nodes.Coord{idxChild2};
% Compute normal to plane
normalBifPlane = cross(P1-C1, P1-C2);
normalBifPlane = normalBifPlane / min(normalBifPlane);
%% Create reference plane
% place a point in this plane
x1 = 0; y1 = 0; z1 = 0;
% give the plane a normal
normalRefPlane = [0,0,1];

%% Get the intersection axis, and the angle bifPlane -> rotPlane in degrees
% axis
[intersectPoint,intersectVect,check]=plane_intersect(normalRefPlane,[x1,y1,z1],normalBifPlane,P1);
% angle
angle = atan2(norm(cross(normalRefPlane,normalBifPlane)),dot(normalRefPlane,normalBifPlane));
angle = angle*180/pi;

% MIGHT NEED TO TEST VALUE "check" FOR CASES WHERE BIF PLANE PARALLEL OR =
% TO REFERENCE PLANE

%% Rotate the bifurcation points to the reference plane
[newPoints, ~, ~] = AxelRot([P1', C1', C2'], -angle, intersectVect, intersectPoint);
rotP1 = [newPoints(1,1), newPoints(2,1), newPoints(3,1)];
rotC1 = [newPoints(1,2), newPoints(2,2), newPoints(3,2)];
rotC2 = [newPoints(1,3), newPoints(2,3), newPoints(3,3)];
%% Set rotation parameters structure to pass to further functions
rotParam.angle = angle;
rotParam.vect = intersectVect;
rotParam.point = intersectPoint;

%% Get center and radius of circumbscribed circle
triangleCoord = [rotP1(1:2)', rotC1(1:2)', rotC2(1:2)'];
[circleParam.r, circleParam.coord] = circumcircle(triangleCoord,0); % second option = plot triangle and circle

%%
%set useful global variable for optimization
tmpG = G;
% setGlobalParameters(tmpG, nameNewEdge, visc, deltaP, rotParam, circleParam, Lmin);

fun = @(x)moveBif(x, tmpG, nameNewEdge, visc, deltaP, rotParam);
const = @(x)constraintCircle(x, circleParam, Lmin);

options = optimoptions('fmincon');%,'Display','iter','Algorithm','sqp');%, 'OptimalityTolerance', 1e-17, 'FiniteDifferenceStepSize', 1e-7);
problem.options = options;
problem.solver = 'fmincon';
problem.objective = fun;
problem.x0 = circleParam.coord;
problem.nonlcon = const;

x = fmincon(problem);

% Once best position is found, replace it in the right plane
[inBifPlaneX, ~, ~] = AxelRot([x; 0], rotParam.angle, rotParam.vect, rotParam.point);

coordBestBif = inBifPlaneX';

end