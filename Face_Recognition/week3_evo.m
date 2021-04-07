%% week 3: PCA & measure score

B = bwlabel(output2);
[m,n] = size(B);
ellipse_mask = zeros(m,n);
% ellipse = zeros(m,n);
ellipse_label = zeros(m,n);
diameter_record = zeros(2,max(max(B)));
record_rotate_angle = [];

tic;
for i = 1 :max(max(B))
    [fy,fx] = find(B == i);
    
    % center of the region
    x0 = round(mean(fx));
    y0 = round(mean(fy));
    
    z = [fx-x0, fy-y0];
    z1 = z.'*z;

    [E, D] = eig(z1);
    e11 = E(1,1);
    e12 = E(1,2);
    e21 = E(2,1);
    e22 = E(2,2);

    lambda1 = D(1,1);
    lambda2 = D(2,2);
    
    % [x1, x2] = z*E
    temp = z*E;
    x1 = temp(:,1);
    x2 = temp(:,2); %

    m11 = mean(abs(x1));
    m12 = mean(abs(x2));
    m21 = mean(x1.^2);
    m22 = mean(x2.^2);

    a1 = 3*pi*m11/4;
    a2 = (4*m21)^0.5;
    b1 = 3*pi*m12/4;
    b2 = (4*m22)^0.5;
    
    a = (a1+a2)/2;
    b = (b1+b2)/2;
    
    if b/a < 3 && b/a > 1/3

        if a > b
            diameter_record(1,i) = round(a);
            diameter_record(2,i) = round(b);
            diameter_record
            
        else
            diameter_record(1,i) = round(b);
            diameter_record(2,i) = round(a);
            diameter_record
        end
        
        % x1: y-axis   x2: x-axis
        y_interval = round(y0-b):round(y0+b);
        x_neg = zeros(1,size(y_interval,2));
        x_pos = zeros(1,size(y_interval,2));
        
        all_coord = [];
        for index = 1:size(y_interval,2)
            x_neg(index) = round(-(a*((1-((y_interval(index)-y0)/b).^2)).^(1/2)) + x0,0);
            x_pos(index) = round(a*((1-((y_interval(index)-y0)/b).^2)).^(1/2) + x0,0);
            
            x_interval = x_neg(index):x_pos(index);
            temp = linspace(y_interval(index),y_interval(index),size(x_interval,2));
            
            temp1 = [temp ; x_interval].';
            
            all_coord = [all_coord; temp1];
        end
        
        all_coord = all_coord - [y0,x0];
        
        if lambda2 > lambda1
            rotate_angle = atan(e12/e22);
        else
            rotate_angle = atan(e11/e21);
        end
        record_rotate_angle = [record_rotate_angle, rotate_angle];
        
        E1 = E*[cos(rotate_angle),-sin(rotate_angle);sin(rotate_angle),cos(rotate_angle)];
        temp2 = all_coord * E1;
        x1 = round(temp2(:,1)) + y0;
        x2 = round(temp2(:,2)) + x0;

        for test = 1:size(x1,1)
            if x1(test) >= 1 && x1(test) <= m && x2(test) >=1 && x2(test) <= n
                ellipse_mask(x1(test),x2(test)) = 1;
                ellipse_label(x1(test),x2(test)) = i;
            end
        end
        
        ellipse_mask = imclose(ellipse_mask, strel('disk',1));
        ellipse_label = imclose(ellipse_label, strel('disk',1));
        
        and_area = 0;
        for index = 1:size(fy,1)
            if ellipse_mask(fy(index),fx(index)) == 1
                and_area = and_area + 1;
            end
        end
        score = and_area / size(fy,1);
        disp(score)
        
        if score < 0.7
            for test = 1:size(x1,1)
                if x1(test) >= 1 && x1(test) <= m && x2(test) >=1 && x2(test) <= n
                    ellipse_mask(x1(test),x2(test)) = 0;
                    ellipse_label(x1(test),x2(test)) = 0;
                end
            end
            ellipse_mask = imopen(ellipse_mask, strel('disk',1));
            ellipse_label = imopen(ellipse_label,strel('disk',1));
            diameter_record(:,i) = 0;
            record_rotate_angle(i) = 0;
        end
    end
end

figure;
subplot(1,2,1),imshow(output2);
subplot(1,2,2),imshow(ellipse_mask.*(test_input/255)),title('if score < 0.7, discard the region');
