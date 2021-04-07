%% week 2: spatial grouping & closing
%% testing (implement with pixel validation)
function [output,output2] = week2(test_input, themean, thestd, model)
    tic;
    [m,n,d] = size(test_input);
    testing_instance_matrix = zeros(m*n,3);
    testing_label_vector = zeros(m*n,1);
    mean_of_test = mean(mean(test_input/255));

    mean_R = themean(1);
    mean_G = themean(2);
    mean_B = themean(3);
    
    std_R = thestd(1);
    std_G = thestd(2);
    std_B = thestd(3);
    
    % does predicting unknown input data requires normalization?
    k = 1;
    for i = 1:m
        for j = 1:n
            testing_instance_matrix(k,1) = (test_input(i,j,1)/255-mean_R)/std_R;
            testing_instance_matrix(k,2) = (test_input(i,j,2)/255-mean_G)/std_G;
            testing_instance_matrix(k,3) = (test_input(i,j,3)/255-mean_B)/std_B;
             k = k+1;
        end
    end
    toc;

    [predicted_label] = svmpredict(testing_label_vector, testing_instance_matrix, model);

    k = 1;
    output = zeros(m,n);
    for i = 1:m
        for j = 1:n
            output(i,j) = predicted_label(k);
            k = k+1;
        end
    end
    toc;
    imshow(output);

    %% ------------------------------------------------------------------------
    output1 = output;

    % spatial grouping
    group = bwlabel(output1); % bwlabeling the result
    total_size = size(group,1)*size(group,2);
    threshold_size = total_size/200; % our candidate must have atleast size of total/500

    the_max = max(max(group));
    for i = 1:the_max 
        [grp_row, grp_column] = find(group == i);
        if size(grp_row,1) < threshold_size
            for j = 1:size(grp_row,1)
                output1(grp_row(j),grp_column(j)) = 0;
            end
        end
    end

    % closing the result, this is approximately our mask
    se = strel('disk',3);
    output2 = imclose(output1, se);

    %%
%     figure;
%     subplot(1,3,1), imshow(output), title('raw result');
%     subplot(1,3,2), imshow(output1), title('spatial grouping of size/200');
%     subplot(1,3,3), imshow(output2), title('closing');

end
