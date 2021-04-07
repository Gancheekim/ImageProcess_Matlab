%% mouth detection
% apply color and t-norms/ product
skin_mask = output2.*ellipse_mask;

Cr = Cr.* skin_mask;
Cb = Cb.* skin_mask;

[fy,fx] = find(skin_mask == 1);
N = size(fx,1);

Cr_div_Cb = zeros(1,N);
for i = 1:N
    Cr_div_Cb(i) = Cr(fy(i),fx(i))/Cb(fy(i),fx(i));
end

up = sum(sum(Cr.^2))/N;
bottom = sum(Cr_div_Cb)/N;
eta = 0.95*(up/bottom);

intermediate1 = Cr.^2;
intermediate2 = (Cr.^2 - eta * Cr./Cb).^2;

% Mouthmap = tnorm(a, b);  % this doesn't perform well
Mouthmap = intermediate1 .* intermediate2 .* 255;
Mouthmap = Mouthmap ./ max(max(Mouthmap)); % normalized the mouthmap into [0,1]

%figure,imshow(Mouthmap),title('our mouthmap result');

%% finding the center of mouth

% create a horizontal ellipse as mouth mapping: mouth_like_mat
% potential_mouth_x : stores the x location of potential mouth
% potential_mouth_y : stores the y location of potential mouth

for region = 1:max(max(ellipse_label))
    if diameter_record(1,region) ~= 0
        height1 = round(diameter_record(1,region)/15);
        width1 = round(diameter_record(2,region)*0.25);
        if height1 >= 1 && width1 >= 1
            mouth_like_mat = ones(height1,width1);

            x0 = round(width1/2);
            y0 = round(height1/2);

            y = 1:height1;
            x_neg = round(-(((width1/2)^2)*(1-(((y-y0).^2)./((height1/2)^2)))).^0.5 + x0);
            x_pos = round((((width1/2)^2)*(1-((y-y0).^2)./((height1/2)^2))).^0.5 + x0);

            for index = 1:size(y,2)
                x_interval = [1:x_neg(index)-1, x_pos(index)+1: width1];
                mouth_like_mat(y(index),x_interval) = 0; 
            end

            mouth_max = conv2(Mouthmap,mouth_like_mat,'same');

            % define the global maximum of mouth_max as our center of mouth
            [y,x] = find(mouth_max == max(max(mouth_max)));
            Mouthmap(y,x) = 0.5;
            potential_mouth_x = x;
            potential_mouth_y = y;

            
        end
    end
end

figure,
imshow(Mouthmap),title('red dot is the center of our mouthmap');
axis on;
hold on;
plot(potential_mouth_x,potential_mouth_y, 'r+', 'MarkerSize', 3, 'LineWidth', 2);

%%
function output = tnorm(a,b)
    [m,n] = size(a);
    zero = zeros(m,n);
    output = max(a+b-1,zero);
end