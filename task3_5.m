%% Task 3.5 - Computing fundamental matrix from known camera calibration parameters

% Loading Parameters
cameraParams1 = load('Parameters_V1_1.mat');
cameraParams2 = load('Parameters_V2_1.mat');
im1 = imread('im1corrected.jpg');
im2 = imread('im2corrected.jpg');

% Extracting Kmats Rmats and Position parameters
K1 = cameraParams1.Parameters.Kmat;
R1 = cameraParams1.Parameters.Rmat;
C1 = cameraParams1.Parameters.position(:); % Converting to a column vector
K2 = cameraParams2.Parameters.Kmat;
R2 = cameraParams2.Parameters.Rmat;
C2 = cameraParams2.Parameters.position(:); % Converting to a column vector

% Computing the relative rotation and translation
R = R2 * R1';
T = R1 * (C2 - C1); % Translating camera 2 to camera 1’s coordinate system

% Constructing skew-symmetric matrix for T
T_skew = [0 -T(3) T(2); 
        T(3) 0 -T(1); 
     -T(2) T(1) 0];

% Computing the Essential matrix
E = R * T_skew;

% Computing the Fundamental matrix
disp('Fundamental Matrix for task 3.5: ')
F = inv(K2)' * E * inv(K1)

colors = 'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

% Sanity check by plotting epipolar lines in both images 
% Selecting the same points I selected in task 3.6 for validation 
x1 = [1553.6; 1164.4;	1138.9;	516.9;	591.7;	452.4;	515.2;	1050.6]; 
y1 = [269.4378;	158.9736;	551.5464;	221.8533;	368.0059;	425.7872;	735.0869;	954.3159]; 
x2 = [770.2;	221.2;	231.4;	90.4;	1111.8;	1101.6;	1105.0;	1699.8]; 
y2 = [204.8588;	36.6133;	 534.5519;	80.7990;	 335.7164;	442.7817;  833.6550;	709.5952]; 


colors = 'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

% Overlay epipolar lines on im2
L = F * [x1'; y1'; ones(size(x1'))]; 
[nr, nc, ~] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2, y2, '*'); hold off
for i = 1:length(L)
    a = L(1,i); b = L(2,i); c = L(3,i);
    if abs(a) > abs(b)
       ylo = 0; yhi = nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h = plot([xlo; xhi], [ylo; yhi]);
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off
       drawnow;
    else
       xlo = 0; xhi = nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off
       drawnow;
    end
end

% Overlay epipolar lines on im1
L_prime = ([x2'; y2'; ones(size(x2'))]' * F)'; 
[nr, nc, ~] = size(im1);
figure(1); clf; imagesc(im1); axis image;
hold on; plot(x1, y1, '*'); hold off
for i = 1:length(L_prime)
    a = L_prime(1,i); b = L_prime(2,i); c = L_prime(3,i);
    if abs(a) > abs(b)
       ylo = 0; yhi = nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off
       drawnow;
    else
       xlo = 0; xhi = nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off
       drawnow;
    end
end

%% Task 3.7 for F from task 3.5

sed_error = symmetric_epipolar_distance(F, projected_points_v1, projected_points_v2);
fprintf('Symmetric Epipolar Distance (SED): %f\n', sed_error);