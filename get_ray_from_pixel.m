%% Function for getting ray from pixel coordinates

function [origin, direction] = get_ray_from_pixel(pixel, cameraParams)
    % pixel: Vector containing x and y pixel coordinates
    % cameraParams: Used to access camera parameters for current camera view

    % Extracting corresponding parameters depending on camera view
    K = cameraParams.Kmat; 
    R = cameraParams.Rmat; 
    T = cameraParams.position(:); 
    
    % First step: Converting pixel coordinate to be normalized
    normalized_pixel = K \ [pixel; 1];

    % Second step: Converting to world coordinates (rotating the ray direction)
    direction = R' * normalized_pixel;
    direction = direction / norm(direction); % Normalizing to a unit vector

    % Camera center in world coordinates
    origin = T;
end