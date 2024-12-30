%% Task 3.6.1 - Computing fundamental matrix using the Eight-point algorithm

im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

figure(1); imagesc(im1); axis image; drawnow;
figure(2); imagesc(im2); axis image; drawnow;

% Initializing empty column vectors to store points
x1 = [];
y1 = [];
x2 = [];
y2 = [];

% Getting points in the first image from user input
figure(1);
[x1_pts, y1_pts] = getpts;
figure(1); imagesc(im1); axis image; hold on;
for i = 1:length(x1_pts)
    h = plot(x1_pts(i), y1_pts(i), '*'); 
    set(h, 'Color', 'g', 'LineWidth', 2);
    text(x1_pts(i), y1_pts(i), sprintf('%d', i));
    
    % Append each x1 and y1 value to column vectors
    x1 = [x1; x1_pts(i)];
    y1 = [y1; y1_pts(i)];
end
hold off;
drawnow;

% Get points in the second image from user input
figure(2);
[x2_pts, y2_pts] = getpts;
figure(2); imagesc(im2); axis image; hold on;
for i = 1:length(x2_pts)
    h = plot(x2_pts(i), y2_pts(i), '*'); 
    set(h, 'Color', 'g', 'LineWidth', 2);
    text(x2_pts(i), y2_pts(i), sprintf('%d', i));
    
    % Append each x2 and y2 value to column vectors
    x2 = [x2; x2_pts(i)];
    y2 = [y2; y2_pts(i)];
end
hold off;
drawnow;

% Calling the eightpoint algorithm function
[F, pts1, pts2] = eightpoint(im1,im2,[x1 y1],[x2 y2]);


%% Tas 3.7 for F from task 3.6.1

sed_error = symmetric_epipolar_distance(F, projected_points_v1, projected_points_v2);
fprintf('Symmetric Epipolar Distance (SED): %f\n', sed_error);