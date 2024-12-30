%% Function for triangulating 2 points and obtaining a 3D coordinate 

function point3D = triangulate_point(ray1_origin, ray1_dir, ray2_origin, ray2_dir)

    % Direction cross product
    cross_directions = cross(ray1_dir, ray2_dir);
    denominator = norm(cross_directions)^2;
    
    % Compute the closest point
    d = ray2_origin - ray1_origin;
    t1 = dot(cross(d, ray2_dir), cross_directions) / denominator;
    t2 = dot(cross(d, ray1_dir), cross_directions) / denominator;
    
    % Calculate the closest points on each ray
    closest_point1 = ray1_origin + t1 * ray1_dir;
    closest_point2 = ray2_origin + t2 * ray2_dir;
    
    % Final point is the midpoint between closest points
    point3D = (closest_point1 + closest_point2) / 2;
end
