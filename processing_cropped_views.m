%% Function to find the fundamental matrix for the cropped versions of the images by adjusting intrinsic parameters

function [K1_cropped, K2_cropped, F_cropped] = processing_cropped_views(cropped_img1, cropped_img2, K1_original, K2_original, R1, R2, C1, C2, x1, y1, x2, y2)
    
    % cropped_img1, cropped_img2: Cropped input images
    % K1_original, K2_original: Original Intrinsic Kmat matrices
    % R1, R2: Rotation matrices between cam1 and cam2 with respect to the world 
    % C1, C2: 3D positions of the two cameras

    % Defining cropping parameters again for updated Kmats
    x1_start = 430;
    y1_start = 350;
    x2_start = 900;
    y2_start = 300;

    % Adjusting intrinsic matrices for cropping
    K1_cropped = K1_original;
    K1_cropped(1, 3) = K1_original(1, 3) - x1_start;
    K1_cropped(2, 3) = K1_original(2, 3) - y1_start;

    K2_cropped = K2_original;
    K2_cropped(1, 3) = K2_original(1, 3) - x2_start;
    K2_cropped(2, 3) = K2_original(2, 3) - y2_start;

    % Rotation matrix between both cameras
    R = R2 * R1';

    % Translation vector between both cameras
    T = R1 * (C2 - C1);

    % Computing the skew-symmetric matrix for T
    T_skew = [0, -T(3), T(2); 
          T(3), 0, -T(1); 
     -T(2), T(1), 0];

    % Computing the essential matrix
    E_cropped = R * T_skew;

    % Computing the updated fundamental matrix for the cropped views
    F_cropped = inv(K2_cropped') * E_cropped * inv(K1_cropped);

    F = F_cropped;
    im2 = cropped_img2;
    im = cropped_img1;

    colors =  'bgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmykbgrcmyk';

    % Overlay epipolar lines on im2
    L = F * [x1' ; y1'; ones(size(x1'))];
    [nr,nc,nb] = size(im2);
    figure(2); clf; imagesc(im2); axis image;
    hold on; plot(x2,y2,'*'); hold off
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi]);
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        end
    end
    
    
    % Overlay epipolar lines on im
    L = ([x2' ; y2'; ones(size(x2'))]' * F)' ;
    [nr,nc,nb] = size(im);
    figure(1); clf; imagesc(im); axis image;
    hold on; plot(x1,y1,'*'); hold off
    for i=1:length(L)
        a = L(1,i); b = L(2,i); c=L(3,i);
        if (abs(a) > (abs(b)))
           ylo=0; yhi=nr; 
           xlo = (-b * ylo - c) / a;
           xhi = (-b * yhi - c) / a;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        else
           xlo=0; xhi=nc; 
           ylo = (-a * xlo - c) / b;
           yhi = (-a * xhi - c) / b;
           hold on
           h=plot([xlo; xhi],[ylo; yhi],'b');
           set(h,'Color',colors(i),'LineWidth',2);
           hold off
           drawnow;
        end

    end

end
