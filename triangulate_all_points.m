%% Function for triangualting all the mocap points by calling the triangulate_point function and calculates MSE value

function [reconstructed_pts3D, mse] = triangulate_all_points(pts2D_v1, pts2D_v2, cameraParams1, cameraParams2, original_pts3D)
    
    num_points = size(pts2D_v1, 2);
    reconstructed_pts3D = zeros(3, num_points); % To store all reconstructed 3D points

    % Loop through all points
    for i = 1:num_points
        % Get the viewing rays from each camera
        [origin1, direction1] = get_ray_from_pixel(pts2D_v1(:, i), cameraParams1);
        [origin2, direction2] = get_ray_from_pixel(pts2D_v2(:, i), cameraParams2);
        
        % Triangulate the current point
        reconstructed_pts3D(:, i) = triangulate_point(origin1, direction1, origin2, direction2);
    end

    % Compute the Mean Squared Error (MSE) between original and reconstructed points
    mse = mean(vecnorm(original_pts3D - reconstructed_pts3D, 2, 1).^2);
end