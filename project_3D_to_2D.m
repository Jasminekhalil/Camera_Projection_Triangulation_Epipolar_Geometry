%% Function for projecting 3D Mocap points to 2D points

function pixel_coords = project_3D_to_2D(pts3D, cameraParams)
    % pts3D: the 3D points from the mocapPoints3D.mat file
    % cameraParams: Used to access camera parameters for current camera view

    % Extracting corresponding parameters depending on camera view
    K = cameraParams.Kmat; 
    R = cameraParams.Rmat; 
    T = cameraParams.position(:); 
    
    % Finding number of points
    num_points = size(pts3D, 2);
    
    % Initializing an array for the 2D projected points
    pixel_coords = zeros(2, num_points);
    
    % Projecting each point
    for i = 1:num_points
        % First step: Transforming the 3D point to the camera coordinate system
        X_world = pts3D(:, i); % The 3D point in world coordinates
        X_cam = R * (X_world - T); % The 3D point in camera coordinates
        
        % Second step: Camera coordinate to image plane 
        X_image_hom = K * X_cam; % Homogeneous 2D image point
        
        % Step 3: Normalize to get pixel coordinates
        pixel_coords(:, i) = X_image_hom(1:2) / X_image_hom(3);
    end
end