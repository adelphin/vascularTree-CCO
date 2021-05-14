function [BinaryMat] = binarycyl3D(Nx, Ny, Nz, FOVx, FOVy, FOVz, InitC, EndC, Radii)

% Given coordinates of start and end as well as radii of N cylinders,
% creates a binary matrix with 1s inside cylinders and 0s outside

% inputs:  Nx,Ny,Nz: dimensions of binary matrix
%          FOVx, FOVy, FOVz: field of view : warning! spatial resolution FOV/N must be the
%          same in all direction
%          InitC: init coordinates of cylinders. size:[nbcyl 3]
%          EndC:  end coordinates of cylinders.  size:[nbcyl 3]
%          Radii: radii of cylinders.  size:[1 nbcyl]

% ex 1cyl
% [BinaryMat] = binarycyl3D(64, 64, 64,64,64,64, [0,0,0], [64,64,64], 4);

%ex multicyl
% clear all
% Nx=256;
% Ny=256;
% Nz=256;
% FOV=256
% Nbcyl=10;
% InitC=randi([1 Nx],Nbcyl,3);
% EndC=randi([1 Ny],Nbcyl,3);
% Radii=randi([1 10],1,Nbcyl);
% [BinaryMat] = binarycyl3D(Nx, Ny, Nz,FOV,FOV,FOV, InitC, EndC, Radii);


%% 
%Check for isotropic resolution
if ((FOVx/Nx)-(FOVy/Ny))-((FOVx/Nx)-(FOVz/Nz))< 1e-15
else
    error('spatial resolution FOV/N must be the same in all direction');
end
    
%%
% Pre_Allocation of Space
Temp3D = zeros(Nx,Ny,Nz);                 % A Temporarily Used Logical Structure
BinaryMat_Temp= zeros(size(Temp3D));
BinaryMat = zeros(Nx,Ny,Nz);                % 3D Distribution of Vessels

for count=1:length(Radii) %loop over cylinders

%% Current cylinder carac
xinit = round(InitC(count,:)*Nx/FOVx); %init coordinates
xend = round(EndC(count,:)*Nx/FOVx);% end coordinates
radius=round(Radii(count)*Nx/FOVx);% Vessel Radius in voxel Elements

% rearrange coordinates
pts = [xinit; xend];
a=xinit(1);
b=xinit(2);
c=xinit(3);
delta_x=xend(1)-xinit(1);
delta_y=xend(2)-xinit(2);
delta_z=xend(3)-xinit(3);

%% Create the center line
t=floor(pdist(pts));% Lengh of cylinder
d=1;
while(d<t)
    a=(a+delta_x/t);
    b=(b+delta_y/t);
    c=(c+delta_z/t);
    Temp3D(floor(a)+1,floor(b)+1,floor(c)+1)=1;
    d=d+1;
end

%% Adjust for radius
BinaryMat_Temp= bwdist(Temp3D);
BinaryMat_Temp(BinaryMat_Temp<=radius) = 1;
BinaryMat_Temp(BinaryMat_Temp>radius)  = 0;
BinaryMat=BinaryMat+BinaryMat_Temp(1:Nx,1:Ny,1:Nz);
end


BinaryMat(BinaryMat>0)=1;

%Plot 3d
figure();
% isosurface(BinaryMat(:,:,:),0.5), colormap hot ,axis([0 Nx 0 Ny 0 Nz]);
% p = patch(isosurface(BinaryMat(:,:,:),0.5));
% p.FaceColor = 'red';
volshow(BinaryMat, 'BackgroundColor', 'white', 'Colormap', repmat([1,0,0], [256,1]));  
