%% eye mouth pair verification
% there are 4 rules for the verification:
% 1. mouth is underneath the eyes
% 2. the angle between (triangle height) and (ellipse principal axis) is
% small
% 3. the angle between base of triangle and the triangle height is near 90
% degree
% 4. the ratio of the height of triangle to the base is in predefined
% region -------> about 0.5 ~ 2

% potential_eye1 : y-component of potential eyes -> array of data
% potential_eye2 : x-component of potential eyes -> array of data
% potential_mouth_x , potential_mouth_y -> 1 data only

final_output = input_image;

%% rule 1

eye_y_r1 = [];
eye_x_r1 = [];
for index = 1:size(potential_eye1,2)
    if potential_eye1(index) < potential_mouth_x
        eye_y_r1 = [eye_y_r1, potential_eye1(index)];
        eye_x_r1 = [eye_x_r1, potential_eye2(index)];
    end
end

%% rule 2
all_condition = false;


for ellipse_iter = 1:size(record_rotate_angle,2)
    if record_rotate_angle(ellipse_iter) ~= 0
        for i = 1:size(eye_y_r1,2)-1
            current_eye_1 = [eye_y_r1(i),eye_x_r1(i)];
            for j = i+1:size(eye_x_r1,2)
                current_eye_2 = [eye_y_r1(j),eye_x_r1(j)];

                midpoint_of_eyes = [(current_eye_1(1)+current_eye_2(1))/2,(current_eye_1(2)+current_eye_2(2))/2];

                gradient_of_height = (potential_mouth_y - midpoint_of_eyes(1))/(potential_mouth_x - midpoint_of_eyes(2));
                
                angle_of_height = atan(gradient_of_height)*180/pi;
                
                if angle_of_height < 0
                    angle_of_height = angle_of_height + 180;
                end
                
                angle_of_princ_axis = record_rotate_angle(ellipse_iter)*180/pi;
                
                angle_of_princ_axis
                if angle_of_princ_axis < 0
                    angle_of_princ_axis = angle_of_princ_axis + 180;
                end

                ang_r2 = abs(angle_of_height - angle_of_princ_axis);
                ang_r2
                
                if  ang_r2 <= 13 || ( ang_r2 >= 80 && ang_r2 <= 100 ) % pass rule 2!
                    disp('pass r2')
                    % proceed to rule 3!
                    gradient_of_base = (current_eye_1(1)-current_eye_2(1))/(current_eye_1(2)-current_eye_2(2));
                    angle_of_base = atan(gradient_of_base) *180/pi;
                    
                    
                    ang_r3 = abs(angle_of_height - angle_of_base);
                    ang_r3

                    if ang_r3 >= 77 && ang_r3 <= 103 % pass rule 3!
                        % disp('pass r3')
                        % proceed to rule 4!
                        base_length = calc_dist(current_eye_1, current_eye_2);
                        height_length = calc_dist([potential_mouth_y, potential_mouth_x], midpoint_of_eyes);
%                         base_length
%                         height_length
%                         current_eye_1
%                         current_eye_2
%                         height_length/base_length

                        if height_length/base_length >= 1 && height_length/base_length <= 2.5
                            
                            % pass rule 4! 
                            % pass all the condition, now we can locate the eyes
                            % and mouth on our candidate ellipse
                            eye_1_y = current_eye_1(1) - 2: current_eye_1(1) + 2;
                            eye_1_x = current_eye_1(2) - 2: current_eye_1(2) + 2;
                            eye_2_y = current_eye_2(1) - 2: current_eye_2(1) + 2;
                            eye_2_x = current_eye_2(2) - 2: current_eye_2(2) + 2;
                            
                            final_output(eye_1_y,eye_1_x,1) = 1;
                            final_output(eye_1_y,eye_1_x,2) = 0;
                            final_output(eye_1_y,eye_1_x,3) = 0;
                            
                            final_output(eye_2_y,eye_2_x,1) = 1;
                            final_output(eye_2_y,eye_2_x,2) = 0;
                            final_output(eye_2_y,eye_2_x,3) = 0;
                            
                            final_output(potential_mouth_y-2:potential_mouth_y+1,potential_mouth_x-4:potential_mouth_x+4,1) = 0;
                            final_output(potential_mouth_y-2:potential_mouth_y+1,potential_mouth_x-4:potential_mouth_x+4,2) = 1;
                            final_output(potential_mouth_y-2:potential_mouth_y+1,potential_mouth_x-4:potential_mouth_x+4,3) = 0;
                            
                            all_condition = true;
                            break;
                        end
                    end
                end
            end
            if all_condition == true
                break;
            end
        end
        if all_condition == true
            break;
        end
    end
end

figure,imshow(final_output),title('this is the final detection of our face');


function output = calc_dist(a,b)
    output = ((a(1)-b(1))^2 + (a(2)-b(2))^2)^0.5;
end
        
        
        