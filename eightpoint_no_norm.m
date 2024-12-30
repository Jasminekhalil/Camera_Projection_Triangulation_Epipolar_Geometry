%% Function for calculating F using the eightpoint algorithm without Hartley preconditioning 

function [F, pts1, pts2] = eightpoint_no_norm(im, im2, pts1, pts2)

figure(1); imagesc(im); axis image; drawnow;
figure(2); imagesc(im2); axis image; drawnow;


if nargin > 2
    x1 = pts1(:,1);
    y1 = pts1(:,2);
else
    figure(1); imagesc(im); axis image; drawnow;
    [x1, y1] = getpts;
end
figure(1); imagesc(im); axis image; hold on;
for i = 1:length(x1)
   h = plot(x1(i), y1(i), '*'); 
   set(h, 'Color', 'g', 'LineWidth', 2);
   text(x1(i), y1(i), sprintf('%d', i));
end
hold off;
drawnow;

if nargin > 3
    x2 = pts2(:,1);
    y2 = pts2(:,2);
else
    figure(2); imagesc(im2); axis image; drawnow;
    [x2, y2] = getpts;
end
figure(2); imagesc(im2); axis image; hold on;
for i = 1:length(x2)
   h = plot(x2(i), y2(i), '*'); 
   set(h, 'Color', 'g', 'LineWidth', 2);
   text(x2(i), y2(i), sprintf('%d', i));
end
hold off;
drawnow;

% Skipping Hartley preconditioning 

% Building matrix A without normalization
A = [];
for i = 1:length(x1)
    A(i, :) = [x1(i) * x2(i), x1(i) * y2(i), x1(i), y1(i) * x2(i), y1(i) * y2(i), y1(i), x2(i), y2(i), 1];
end

% Getting eigenvector associated with smallest eigenvalue of A' * A
[u, d] = eigs(A' * A, 1, 'SM');
F = reshape(u, 3, 3);

% Make F rank 2
[U, D, V] = svd(F);
D(3,3) = 0;
F = U * D * V';

% Skipping the unnormalizing of F

colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

% Overlay epipolar lines on im2
L = F * [x1'; y1'; ones(size(x1'))];
[nr, nc, nb] = size(im2);
figure(2); clf; imagesc(im2); axis image;
hold on; plot(x2, y2, '*'); hold off;
for i = 1:length(L)
    a = L(1, i); b = L(2, i); c = L(3, i);
    if abs(a) > abs(b)
       ylo = 0; yhi = nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on;
       h = plot([xlo; xhi], [ylo; yhi]);
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off;
    else
       xlo = 0; xhi = nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on;
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off;
    end
end

% Overlay epipolar lines on im
L = ([x2'; y2'; ones(size(x2'))]' * F)';
figure(1); clf; imagesc(im); axis image;
hold on; plot(x1, y1, '*'); hold off;
for i = 1:length(L)
    a = L(1, i); b = L(2, i); c = L(3, i);
    if abs(a) > abs(b)
       ylo = 0; yhi = nr; 
       xlo = (-b * ylo - c) / a;
       xhi = (-b * yhi - c) / a;
       hold on;
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off;
    else
       xlo = 0; xhi = nc; 
       ylo = (-a * xlo - c) / b;
       yhi = (-a * xhi - c) / b;
       hold on;
       h = plot([xlo; xhi], [ylo; yhi], 'b');
       set(h, 'Color', colors(i), 'LineWidth', 2);
       hold off;
    end
end

% Display the F matrix
fprintf('F matrix (no normalization):\n');
for j = 1:3
    for i = 1:3
        fprintf('%10g ', 10000 * F(j, i));
    end
    fprintf('\n');
end

end