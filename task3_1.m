%% Task 3.1 - Understanding pinhole camera model parameters 

%% Loading Parameter structures for each camera view 

Parameters_V1 = load('Parameters_V1_1.mat');
Parameters_V2 = load('Parameters_V2_1.mat');

%% Location of Cameras

% Extract the rotation matrix and position for camera 1
R1 = Parameters_V1.Parameters.Rmat; % Rotation matrix
t1 = Parameters_V1.Parameters.position.'; % Position of the camera (making it a column vector)
% Calculating the camera location in world coordinates
camera_1_location = -transpose(R1) * t1;
% Displaying the camera location
disp('Camera 1 Location in World Coordinates:');
disp(camera_1_location);

% Extract the rotation matrix and position for camera 2
R2 = Parameters_V2.Parameters.Rmat; % Rotation matrix
t2 = Parameters_V2.Parameters.position.'; % Position of the camera (making it a column vector)
% Calculating the camera location in world coordinates
camera_2_location = -transpose(R2) * t2;
% Displaying the camera location
disp('Camera 2 Location in World Coordinates:');
disp(camera_2_location);

%% Verifying that the location of camera 1 and its rotation combine to yield to appropriate Pmat

% Extracting parameters from the structure
foclen = Parameters_V1.Parameters.foclen;
prinpoint = Parameters_V1.Parameters.prinpoint;
aspectratio = Parameters_V1.Parameters.aspectratio;
skew = Parameters_V1.Parameters.skew;
position = Parameters_V1.Parameters.position;
Rmat = Parameters_V1.Parameters.Rmat;
Kmat = Parameters_V1.Parameters.Kmat;
Pmat = Parameters_V1.Parameters.Pmat;

% Constructing the intrinsic matrix K
fx = foclen;
fy = foclen * aspectratio;
cx = prinpoint(1);
cy = prinpoint(2);

K_constructed = [fx, skew, cx; 
                 0, fy, cy; 
                 0, 0, 1];

% Checking if K_constructed matches Kmat
disp('Constructed intrinsic matrix K:');
disp(K_constructed);
disp('Provided intrinsic matrix Kmat:');
disp(Kmat);
if isequal(round(K_constructed, 6), round(Kmat, 6))
    disp('Intrinsic matrix Kmat matches the constructed matrix K_constructed.');
else
    disp('Intrinsic matrix Kmat does NOT match the constructed matrix K_constructed.');
end

% Creating the camera location matrix that we will combine with the rotation matrix to produce Pmat
C = position(:);
camera_location_matrix = [1 0 0; 0 1 0; 0 0 1];
camera_location_matrix = [camera_location_matrix -C; [0 0 0 1]]; 

% Turning given Rmat into 4x4 matrix 
Rmat = [Rmat [0; 0; 0]; [0 0 0 1]];

% Constructing the full projection matrix
P_constructed = [1 0 0 0; 0 1 0 0; 0 0 1 0] * Rmat * camera_location_matrix;

% Displaying the result
disp('Constructed projection matrix P:');
disp(P_constructed);
disp('Provided projection matrix Pmat:');
disp(Pmat);
if isequal(round(P_constructed, 6), round(Pmat, 6))
    disp('Projection matrix Pmat matches the constructed matrix P_constructed.');
else
    disp('Projection matrix Pmat does NOT match the constructed matrix P_constructed.');
end

%% Verifying that the location of camera 2 and its rotation combine to yield to appropriate Pmat

% Extracting parameters from the structure
foclen = Parameters_V2.Parameters.foclen;
prinpoint = Parameters_V2.Parameters.prinpoint;
aspectratio = Parameters_V2.Parameters.aspectratio;
skew = Parameters_V2.Parameters.skew;
position = Parameters_V2.Parameters.position;
Rmat = Parameters_V2.Parameters.Rmat;
Kmat = Parameters_V2.Parameters.Kmat;
Pmat = Parameters_V2.Parameters.Pmat;

% Constructing the intrinsic matrix K
fx = foclen; 
fy = foclen * aspectratio;
cx = prinpoint(1);
cy = prinpoint(2);

K_constructed = [fx, skew, cx; 
                 0, fy, cy; 
                 0, 0, 1];

% Checking if K_constructed matches Kmat
disp('Constructed intrinsic matrix K:');
disp(K_constructed);
disp('Provided intrinsic matrix Kmat:');
disp(Kmat);
if isequal(round(K_constructed, 6), round(Kmat, 6))
    disp('Intrinsic matrix Kmat matches the constructed matrix K_constructed.');
else
    disp('Intrinsic matrix Kmat does NOT match the constructed matrix K_constructed.');
end

% Creating the camera location matrix that we will combine with the rotation matrix to produce Pmat
C = position(:);
camera_location_matrix = [1 0 0; 0 1 0; 0 0 1];
camera_location_matrix = [camera_location_matrix -C; [0 0 0 1]]; 

% Turning given Rmat into 4x4 matrix 
Rmat = [Rmat [0; 0; 0]; [0 0 0 1]];

% Constructing the full projection matrix
P_constructed = [1 0 0 0; 0 1 0 0; 0 0 1 0] * Rmat * camera_location_matrix;

% Displaying the result
disp('Constructed projection matrix P:');
disp(P_constructed);
disp('Provided projection matrix Pmat:');
disp(Pmat);
if isequal(round(P_constructed, 6), round(Pmat, 6))
    disp('Projection matrix Pmat matches the constructed matrix P_constructed.');
else
    disp('Projection matrix Pmat does NOT match the constructed matrix P_constructed.');
end