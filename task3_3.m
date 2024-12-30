%% Calling the triangulate_all_points function to reconstruct mocap points and calculate MSE

% Projected 2D points for each view from task 3_2
pts2D_v1 = projected_points_v1;
pts2D_v2 = projected_points_v2;

[reconstructed_pts3D, mse] = triangulate_all_points(pts2D_v1, pts2D_v2, Parameters_V1.Parameters, Parameters_V2.Parameters, pts3D);

% Display the MSE value
disp('Mean Squared Error (MSE) between original and reconstructed points:');
disp(mse);

% Plotting original vs. reconstructed points for visualization
figure;

% Plot the original 3D points
scatter3(pts3D(1, :), pts3D(2, :), pts3D(3, :), 100, 'r');
hold on;

% Plot the reconstructed 3D points
scatter3(reconstructed_pts3D(1, :), reconstructed_pts3D(2, :), reconstructed_pts3D(3, :), 50, 'b');

% Add a legend with larger font size
legend('Original 3D Points', 'Reconstructed 3D Points', 'FontSize', 14);

% Add a title with larger font size
title('Comparison of Original and Reconstructed 3D Points', 'FontSize', 18);

% Add axis labels with larger font size
xlabel('X', 'FontSize', 15);
ylabel('Y', 'FontSize', 15);
zlabel('Z', 'FontSize', 15);

