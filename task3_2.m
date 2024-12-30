%% Task 3.2 - Projecting 3D mocap points into 2D pixel locations

%% Calling the function project_3D_to_2D using pts3D from mocapPoints 

load('mocapPoints3D.mat') % Loading the 3D points
img1 = imread('im1corrected.jpg'); % Reading the two image views
img2 = imread('im2corrected.jpg');


% Projecting points for view 1
projected_points_v1 = project_3D_to_2D(pts3D, Parameters_V1.Parameters);
% Projecting points for view 2
projected_points_v2 = project_3D_to_2D(pts3D, Parameters_V2.Parameters);


% Plotting on images
figure; 
imshow(img1); 
hold on;

plot(projected_points_v1(1, :), projected_points_v1(2, :), 'r.', 'MarkerSize', 10);

% Setting the title with a larger font size
title('Projected Points on Image 1', 'FontSize', 20); % Adjust the font size here

for i = 1:size(projected_points_v1, 2)
    % Annotating each point with its (x, y) coordinates
    x = projected_points_v1(1, i);
    y = projected_points_v1(2, i);
    text(x, y, sprintf('(%.1f, %.1f)', x, y), 'Color', 'yellow', 'FontSize', 8); % Adjusted font size for annotations
end


% Plotting on images
figure; 
imshow(img2); 
hold on;

plot(projected_points_v2(1, :), projected_points_v2(2, :), 'r.', 'MarkerSize', 10);

% Setting the title with a larger font size
title('Projected Points on Image 2', 'FontSize', 20); % Adjust the font size here

for i = 1:size(projected_points_v1, 2)
    % Annotating each point with its (x, y) coordinates
    x = projected_points_v2(1, i);
    y = projected_points_v2(2, i);
    text(x, y, sprintf('(%.1f, %.1f)', x, y), 'Color', 'yellow', 'FontSize', 8); % Adjusted font size for annotations
end