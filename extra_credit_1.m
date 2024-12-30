%% Extra Credit 1

% Defining original intrinsic matrices, rotation, and translation
K1_original = cameraParams1.Parameters.Kmat;
K2_original = cameraParams2.Parameters.Kmat;
R1 = cameraParams1.Parameters.Rmat; % Rotation matrix between cam1 and world
C1 = cameraParams1.Parameters.position'; % Translation vector between cam1 and world
R2 = cameraParams2.Parameters.Rmat; % Rotation matrix between cam2 and world
C2 = cameraParams2.Parameters.position'; % Translation vector between cam2 and world

% Defining cropping parameters that focus most tightly around the person 
x1_start = 430;
y1_start = 350;
width1 = 300;
height1 = 400;

x2_start = 900;
y2_start = 300;
width2 = 300;
height2 = 540;

% Cropping images based on specified rectangles
cropped_img1 = imcrop(img1, [x1_start, y1_start, width1, height1]);
cropped_img2 = imcrop(img2, [x2_start, y2_start, width2, height2]);

figure;
imshow(cropped_img1); title('Cropped Image 1');
figure;
imshow(cropped_img2); title('Cropped Image 2');

% Initialize empty column vectors to store points selected
x1 = [];
y1 = [];
x2 = [];
y2 = [];

% Get points in the first image from user input
figure(1);
[x1_pts, y1_pts] = getpts;
figure(1); imagesc(cropped_img1); axis image; hold on;
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
figure(2); imagesc(cropped_img2); axis image; hold on;
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

% Call the function for processing the cropped views and getting F
[K1_cropped, K2_cropped, F_cropped] = processing_cropped_views(cropped_img1, cropped_img2, K1_original, K2_original, R1, R2, C1, C2, x1, y1, x2, y2);

disp('Updated Fundamental Matrix for Cropped Views');
F_cropped