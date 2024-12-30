%% Function for gathering user selected points and calling the triangulate_point function for each of these points

function [point3D] = triangulate_user_selected_points(img1, img2, cameraParams1, cameraParams2)

    % Show first image and select a point
    figure;
    imshow(img1);
    title('Click on a point in the first image');
    [x1, y1] = ginput(1); % Get user click in the first image
    close;

    % Show second image and select a corresponding point
    figure;
    imshow(img2);
    title('Click on the matching point in the second image');
    [x2, y2] = ginput(1); % Get user click in the second image
    close;

    % Convert the 2D pixel points to viewing rays for each camera by calling the get_ray_from_pixel function
    [ray1_origin, ray1_dir] = get_ray_from_pixel([x1; y1], cameraParams1);
    [ray2_origin, ray2_dir] = get_ray_from_pixel([x2; y2], cameraParams2);

    % Perform triangulation using the viewing rays by calling the triangulate_point function
    point3D = triangulate_point(ray1_origin, ray1_dir, ray2_origin, ray2_dir);
end