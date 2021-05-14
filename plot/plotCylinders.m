function BinaryMat = plotCylinders(G,  FOVx, FOVy, FOVz, X, Y, Z)
cyl = graph2cylinders(G);
[BinaryMat] = binarycyl3D(X, Y, Z, FOVx, FOVy, FOVz, cyl.startPoints, cyl.endPoints, cyl.radii);

