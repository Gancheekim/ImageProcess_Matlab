%% run this code to run all code 
clear;

%% build our svm model to detect skin-liked pixel of human face
week1;

%% spatial grouping & closing, starting to test input image
path_name = 'D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\';
file_name = 'kim_test16.jpg';
test_input = double(imread(strcat(path_name,file_name)));

[output1,output2] = week2(test_input, themean, thestd, model);

%% PCA estimation of our face region & measure score
week3_evo;

%% computation of EyemapC, EyemapL, EyemapT
% find our eye map and the potential center of eyes
week4;

%% find our mouth map & the center of our potential mouth
week5;

%% verification of eye mouth pair
week6;

