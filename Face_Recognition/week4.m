%% week 4: Eyes detection & finding center of eyes
% computation of EyemapC, EyemapL, EyemapT
clearvars -except test_input output2 ellipse_mask ellipse_label diameter_record record_rotate_angle
% output2: raw skin detect result with closing
% test_input: the input image
% ellipse_mask: the estimate ellipse of human face-like region

mask_input = test_input/255 .* ellipse_mask;
input_image = mask_input;

image_ycbcr = rgb2ycbcr(input_image);

Y = image_ycbcr(:,:,1);
Cb = image_ycbcr(:,:,2);
Cr = image_ycbcr(:,:,3);

% EyemapC
EyemapC = ((Cb).^2 + (max(max(Cr))-Cr).^2 + (Cb./Cr))/3;

% EyemapL
[m,n,d] = size(input_image);
Y_erosion = zeros(m,n);
target = Y;
for iter = 1:5
    for i = 2:m-1
        for j = 2:n-1
            Y_erosion(i,j) = min([target(i,j),target(i+1,j),target(i-1,j),target(i,j+1),target(i,j-1)]);
        end
    end
    target = Y_erosion;
end
EyemapL = 1 - Y_erosion;

% EyemapT
temp = extractTexture(Y);
% 1,2,3:    '/'orientation
% 4:        '|'orientation
% 5,6,7:    '\'orientation
% 8:        '-'orientation
EyemapT = temp(:,:,13); % 13 % 9 = 4
% here i choose the orientation close to vertical

%% for validating which orientation to be chosen in EyemapT
% figure,
% subplot(2,4,1), imshow(temp(:,:,9)), title('EyemapT');
% subplot(2,4,2), imshow(temp(:,:,10)), title('EyemapT');
% subplot(2,4,3), imshow(temp(:,:,11)), title('EyemapT');
% subplot(2,4,4), imshow(temp(:,:,12)), title('EyemapT');
% subplot(2,4,5), imshow(temp(:,:,13)), title('EyemapT');
% subplot(2,4,6), imshow(temp(:,:,14)), title('EyemapT');
% subplot(2,4,7), imshow(temp(:,:,15)), title('EyemapT');
% subplot(2,4,8), imshow(temp(:,:,16)), title('EyemapT');

%% check result
% figure;
% subplot(1,3,1), imshow(EyemapC), title('EyemapC');
% subplot(1,3,2), imshow(EyemapL), title('EyemapL');
% subplot(1,3,3), imshow(EyemapT), title('EyemapT');

% figure;
Eyemap = 0.4*EyemapC + 0.2*EyemapL + 0.4*EyemapT;
% subplot(2,2,[1,2]),imshowpair(Eyemap,imadjust(Eyemap),'montage');
% title('linear combination of C,T,L');

combineCL = max(EyemapC+EyemapL-1,0);
finalEyemap = combineCL .* EyemapT;
% subplot(2,2,[3,4]),imshowpair(finalEyemap,imadjust(finalEyemap),'montage');
% title('lukasiewicz t-norm C & L, then multiply T');

% we choose the result of eyemap as linear combinational
%% locate the center of eyes
potential_eye1 = []; % store y-location
potential_eye2 = []; % store x-location

for region = 1:max(max(ellipse_label))
    % first, create a circular-like matrix of ones
    iris_diameter = round(diameter_record(1,region)/40);
    circular_one = zeros(iris_diameter,iris_diameter);
    
    x0 = round(iris_diameter/2);
    y0 = round(iris_diameter/2);
    
    y = 1:iris_diameter;
    x_neg = round(-((iris_diameter/2)^2 - (y-y0).^2).^0.5 + x0);
    for temp = 1:size(x_neg,2)
        if x_neg(temp) <= 0
            x_neg(temp) = 1;
        end
    end
    x_pos = floor(((iris_diameter/2)^2 - (y-y0).^2).^0.5 + x0);
    for temp = 1:size(x_pos,2)
        if x_pos(temp) > iris_diameter
            x_pos(temp) = 1;
        end
    end
    
    for index = 1:iris_diameter
        x = [x_neg(index):x_pos(index)];
        circular_one(y(index),x) = 1;
    end
    
    % Eyemap convolution with circular ones matrix
    e = conv2(Eyemap,circular_one,'same');
    
    % determine if e(m,n) is a the center of our iris
    % rule 1: e(m,n) is local maximum
    conn = conndef(2,'maximal');
    islocalmax = imregionalmax(e,conn);   

%     islocalmax = zeros(size(Eyemap,1),size(Eyemap,2));
%     for m = 4:size(islocalmax,1)-3
%         for n = 4:size(islocalmax,2)-3
%             container = [e(m-1,n),e(m+1,n),e(m,n-1),e(m,n+1)];
%             container = [container, e(m-2,n),e(m+2,n),e(m,n-2),e(m,n+2),e(m+1,n+1),e(m-1,n-1),e(m+1,n-1),e(m-1,n+1)];
%             container = [container, e(m-3,n),e(m+3,n),e(m,n-3),e(m,n+3),e(m-2,n+1),e(m+2,n+1),e(m+2,n-1),e(m-2,n-1),e(m+1,n+2),e(m-1,n+2),e(m+1,n-2),e(m-1,n-2)];
%             if sum(e(m,n) > container) == 12
%                 islocalmax(m,n) = 1;
%             end
%         end
%     end

    [fy,fx] = find(islocalmax == 1);
    max_threshold = max(max(e));
    
    se = strel('disk',round(diameter_record(1,region)*0.15));
    current_ellipse = imerode(ellipse_label,se);
    
    for k = 1:size(fx,1)
        threshold_condition = false;
        geometry_condition = false;

        % rule 2: e(m,n) > threshold; (threshold = max*0.7)
        if e(fy(k),fx(k)) > max_threshold*0.7
            threshold_condition = true;
        end
        % rule 3: it locates inside the circle of our estimate ellipse,
        % and the radius = 0.8*r_old
        if current_ellipse(fy(k),fx(k)) == region
            geometry_condition = true;
        end

        % if pass rule 2 & 3, then it is the potential candiate
        if threshold_condition == true && geometry_condition == true
            potential_eye1 = [potential_eye1, fy(k)];
            potential_eye2 = [potential_eye2, fx(k)];
        end
    end
end
figure,
imshow(Eyemap),title('red dot is our potential center of eyes');
axis on;
hold on;
for count = 1:size(potential_eye1,2)
    plot(potential_eye2(count),potential_eye1(count),'r+', 'MarkerSize', 3, 'LineWidth', 2);
end




