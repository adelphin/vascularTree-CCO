load('graphTest.mat', 'G');

cyl = graph2cylinders(G);

[BinaryMat] = binarycyl3D(100,100,300 , cyl.startPoints, cyl.endPoints, cyl.radii);
