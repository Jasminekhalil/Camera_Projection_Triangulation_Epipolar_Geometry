%% Task 3.6.2 - Eightpoint algorithm without Hartley Preconditioning 

% Displaying images
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

% Calling eightpoint function without normalization to calculate the Fundamental matrix
F = eightpoint_no_norm(im1,im2,pts1,pts2);


%% Task 3.7 for F from task 3.6.2

% Calling SED error function to calculate SED
sed_error = symmetric_epipolar_distance(F, projected_points_v1, projected_points_v2);
fprintf('Symmetric Epipolar Distance (SED): %f\n', sed_error);