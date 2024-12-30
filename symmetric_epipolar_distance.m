%% Function for calculating the Symmetric Epipolar Distance Error 

function sed = symmetric_epipolar_distance(F, projected_points_v1, projected_points_v2)

    % Ensuring all points are in homogeneous coordinates
    pts1 = [projected_points_v1; ones(1,39)]';
    pts2 = [projected_points_v2; ones(1,39)]';
    
    % Initializing the distance accumulator
    total_distance = 0;

    % Looping through each point pair to compute the distance
    for i = 1:39
        % Points in homogeneous coordinates
        p1 = pts1(i, :)';  % Point in image 1 
        p2 = pts2(i, :)';  % Corresponding point in image 2
        
        % Epipolar line in image 2 for p1 (l2 = F * p1)
        l2 = F * p1;
        
        % Calculating squared geometric distance from p2 to l2 in image 2
        dist2 = (l2(1) * p2(1) + l2(2) * p2(2) + l2(3))^2 / (l2(1)^2 + l2(2)^2);
        
        % Epipolar line in image 1 for p2 (l1 = F' * p2)
        l1 = F' * p2;
        
        % Calculating squared geometric distance from p1 to l1 in image 1
        dist1 = (l1(1) * p1(1) + l1(2) * p1(2) + l1(3))^2 / (l1(1)^2 + l1(2)^2);
        
        % Accumulating symmetric distance
        total_distance = total_distance + dist1 + dist2;
    end

    % Computing the mean squared distance
    sed = total_distance / 39;
end
