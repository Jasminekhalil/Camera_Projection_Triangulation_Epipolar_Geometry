%% Function for computing the equation of a plane from 3 points  

function [plane_eqn, normal_vector] = compute_plane_equation(points)
    % Points: A 3x3 matrix where each row is a point in 3D space
    
    % Vectors from the first point to the other two points
    v1 = points(2,:) - points(1,:);
    v2 = points(3,:) - points(1,:);
    
    % Normal vector to the plane: Cross product of v1 and v2
    normal_vector = cross(v1, v2);
    
    % Plane equation coefficients (A, B, C) are the components of the normal vector
    A = normal_vector(1);
    B = normal_vector(2);
    C = normal_vector(3);
    
    % D is found by substituting the first point into the plane equation
    D = -dot(normal_vector, points(1,:));
    
    % Returning the plane equation as a row vector [A, B, C, D]
    A = A / D;
    B = B / D;
    C = C / D;
    D = 1;
    
    plane_eqn = sprintf('%dx + %dy + %dz + %d = 0', A, B, C, D);
end