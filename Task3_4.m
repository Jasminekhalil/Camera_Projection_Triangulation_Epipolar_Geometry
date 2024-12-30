%% Task 3.4 - Triangulation to make measurments about the scene

%% Using triangulation to make measurments about the scene

% Load images and camera parameters
img1 = imread('im1corrected.jpg');
img2 = imread('im2corrected.jpg');
cameraParams1 = Parameters_V1.Parameters;
cameraParams2 = Parameters_V2.Parameters;

% Define arrays to store triangulated points for floor and wall
floor_points = [];
wall_points = [];

% Triangulating 3 points on the floor
for i = 1:3
    fprintf('Select point %d of the floor in both camera views.\n',i)
    floor_point = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
    floor_points = [floor_points; floor_point'];  % Append new point as a row
end

% Triangulating 3 points on the wall
for i = 1:3
    fprintf('Select point %d of the wall in both camera views.\n',i)
    wall_point = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
    wall_points = [wall_points; wall_point']; % Append new point as a row
end

% Displaying floor_points and wall_points
floor_points
wall_points

% Computing the plane equations for the floor and wall
[floor_plane_eqn, floor_normal] = compute_plane_equation(floor_points);
[wall_plane_eqn, wall_normal] = compute_plane_equation(wall_points);

% Output the plane equations for floor and wall
disp('Floor plane equation:');
disp(floor_plane_eqn);

disp('Wall plane equation:');
disp(wall_plane_eqn);


% Measuring the height of the doorway
disp('Select a point at the top of the doorway in both camera views')
doorway_top = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
disp('Select a point at the bottom of the doorway in both camera views')
doorway_bottom = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
doorway_height = abs(doorway_top(3) - doorway_bottom(3));
fprintf("Height of the doorway: %.2f units\n", doorway_height);


% Measuring the height of the person
disp('Select a point on the persons head in both camera views')
person_head = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
disp('Select a point on the persons shoes in both camera views')
person_feet = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
person_height = abs(person_head(3) - person_feet(3));
fprintf("Height of the person: %.2f units\n", person_height);


% Locating the 3D location of the camera on the tripod near the wall
disp('Select a point at the center of the camera near the striped wall in both camera views')
tripod_camera_position = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2);
fprintf("3D location of the tripod camera: (%.2f, %.2f, %.2f)\n", tripod_camera_position(1), tripod_camera_position(2), tripod_camera_position(3));

% Visualization

% Plotting floor and wall points
figure;
scatter3(floor_points(:,1), floor_points(:,2), floor_points(:,3), 'gs', 'DisplayName', 'Floor Points');
hold on;
scatter3(wall_points(:,1), wall_points(:,2), wall_points(:,3), 'md', 'DisplayName', 'Wall Points'); 
% Plotting door and person points
scatter3(doorway_top(1), doorway_top(2), doorway_top(3), 'rv', 'filled', 'DisplayName', 'Door Top');
scatter3(doorway_bottom(1), doorway_bottom(2), doorway_bottom(3), 'r^', 'filled', 'DisplayName', 'Door Bottom');
scatter3(person_head(1), person_head(2), person_head(3), 'b^', 'filled', 'DisplayName', 'Person Head');
scatter3(person_feet(1), person_feet(2), person_feet(3), 'bv', 'filled', 'DisplayName', 'Person Feet');
scatter3(tripod_camera_position(1), tripod_camera_position(2), tripod_camera_position(3), 'bo', 'DisplayName', 'Camera Center');

% Labeling axes and adding legend
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D Points');
legend show;
grid on;
hold off;