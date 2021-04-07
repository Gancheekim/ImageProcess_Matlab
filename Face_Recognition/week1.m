%% Face recognition project
clear all;
% step 1 : build our svm model to detect skin-liked pixel of human face
% this is where my ml model locates:
addpath('D:\Users\Lenovo\Desktop\DJJ_Seminar\libsvm-3.24\matlab');

% read training data, using data tips to get our data
x1 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\01.jpg'));
x2 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\1.jpg'));
x3 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\2.jpg'));
x4 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\3.jpg'));
x5 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\4.jpg'));
x6 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\5.jpg'));
x7 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\06.jpg'));
x8 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\7.jpg'));
x9 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\8.jpg'));
x10 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\9.jpg'));
x11 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\10.jpg'));
x12 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\11.jpg'));
x13 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\12.jpg'));
x14 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\13.jpg'));
x15 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\14.jpg'));
x16 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\15.jpg'));
x17 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\16.jpg'));
x18 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\17.jpg'));
x19 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\18.jpg'));
x20 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\19.jpg'));
x21 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\20.jpg'));
x22 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\21.jpg'));
x23 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\22.jpg'));
x24 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\23.jpg'));
x25 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\24.jpg'));
x26 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\25.jpg'));
x27 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\lab1.JPG'));
x28 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\lab2.JPG'));
x29 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\lab7.JPG'));
x30 = double(imread('D:\Users\Lenovo\Desktop\DJJ_Seminar\TestImagesForPrograms\labt.JPG'));

% training data: [R, G, B]
feature_a = [0.302, 0.1765, 0.1333;
             0.4745, 0.4706, 0.5412;
             0.5529, 0.08627, 0.1647;
             0.8353, 0.6824, 0.6627;
             0.4863, 0.4157, 0.4;
             0.6, 0.6039, 0.5725;
             0.7255, 0.6627, 0.5294;
             0.4824, 0.5176, 0.5373;
             0.7412, 0.6471, 0.5529;
             0.9608, 0.7569, 0.6706;
             0.7059, 0.3961, 0.3451;
             0.2431, 0.2667, 0.2667;
             0.01961, 0.1765, 0.04313;
             0.1294, 0.2471, 0.3569;
             0.07451, 0.0549, 0.03137;
             0.9804, 0.8627, 0.8235;
             0.8667, 0.6627, 0.6784;
             0.4471, 0.502, 0.5451;
             0.3255, 0.3059, 0.2902;
             0.3137, 0.3922, 0.2863;
             0.4471, 0.2745, 0.3412;
             0.9569, 0.8431, 0.8196;
             0.8902, 0.6588, 0.6275;
             0.7451, 0.5922, 0.5333;
             0.4078, 0.4118, 0.4196;
             0.4549, 0.3176, 0.302;
             0.8039, 0.7804, 0.7333;
             0.4784, 0.3882, 0.3255;
             0.9529, 0.7529, 0.7882;
             0.5098, 0.2549, 0.3333;
             0.3373, 0.5294, 0.3451;
             0, 0.3529, 0.7294;
             0.7176, 0.5725, 0.549;
             0.9412, 0.8196, 0.7373;
             0.651, 0.549, 0.4588;
             0.3765, 0.2431, 0.2078;
             0.6275, 0.5608, 0.2784;
             0.7647, 0.7804, 0.8235;
             0.5137, 0.3137, 0.2392;
             0.6824, 0.5373, 0.4745;
             0.3608, 0.2196, 0.1569;
             0.9647, 1, 1;
             0.5686, 0.5647, 0.4471;
             0.1608, 0.0549, 0.02745;
             0.9059, 0.6706, 0.4745;
             0.9294, 0.7882, 0.6627;
             0.9765, 0.8588, 0.6627;
             0.1569, 0.2118, 0.1529;
             0.3059, 0.3529, 0.4392;
             0.6157, 0.5961, 0.3294;
             0.7804, 0.7569, 0.5608;
             0.8706, 0.5529, 0.4863;
             0.8353, 0.549, 0.4902;
             0.06275, 0.09804, 0.01569;
             0.8078, 0.2039, 0.2118;
             0.8196, 0.4549, 0.4235;
             0.6706, 0.4432, 0.3961;
             0.2314, 0.3216, 0.2118;
             0.3608, 0.3569, 0.4824;
             0.4314, 0.4078, 0.4078;
             1, 1, 1;
             0.1294, 0.1373, 0.1961;
             0.6627, 0.4235, 0.4431;
             0.8235, 0.5412, 0.4471;
             0.7216, 0.4196, 0.3176;
             0.8824, 0.7255, 0.7176;
             0.1412, 0.08627, 0.05098;
             0.5137, 0.5765, 0.4235;
             0.1843, 0.0902, 0.04314;
             0.7373, 0.6627, 0.6353;
             0.5647, 0.1686, 0.2314;
             0.7843, 0.851, 0.8784;
             0.9569, 0.7647, 0.8902;
             1, 0.8627, 0.9569;
             0.2902, 0.3373, 0.4863;
             0.9765, 0.7765, 0.6706;
             0.7647, 0.5843, 0.4902;
             0.8039, 0.5961, 0.4706;
             0.1412, 0.3529, 0.5333;
             0.3882, 0.3137, 0.1882;
             0.8667, 0.6, 0.5176;
             0.6549, 0.4118, 0.3608;
             0.9412, 0.8667, 0.1294;
             0.9922, 0.6314, 0.3373;
             0.5647, 0.3725, 0.2157;
             0.8745, 0.6784, 0.7137;
             0.9647, 0.7843, 0.8353;
             0.6157, 0.4118, 0.3569;
             0.3686, 0.4039, 0.3922;
             0.3255, 0.3294, 0.3451;
             0.2667, 0.2706, 0.2392;
             0.9725, 0.7137, 0.5255;
             0.7961, 0.5725, 0.5059;
             0.9294, 0.6824, 0.5608;
             0.6039, 0.4275, 0.4039;
             0.6275, 0.3725, 0.349;
             0.3922, 0.2588, 0.2118;
             0.9569, 0.8078, 0.7725;
             0.9686, 0.8118, 0.7137;
             0.9176, 0.6824, 0.5725;
             0.8549, 0.6314, 0.5961;
             0.9922, 0.8471, 0.8235;
             0.9765, 0.8902, 0.898;
             0.8157, 0.6824, 0.7373;
             0.9686, 0.7608, 0.7373;
             0.9725, 0.702, 0.7137;
             0.7765, 0.6471, 0.6118;
             0.7294, 0.5843, 0.5529;
             0.8, 0.6745, 0.6314;
             0.8824, 0.8039, 0.7765;
             0.4431, 0.5098, 0.3843;
             0.8824, 0.8196, 0.8235;
             0.9255, 0.8157, 0.8039;
             0.6784, 0.5255, 0.5059;
             0.07059, 0.07451, 0.08235;
             0.6157, 0.3373, 0.1333;
             0.3843, 0.3216, 0.2588;
             0.8667, 0.9176, 0.8824;
             0.9216, 0.9255, 0.8;
             0.9608, 0.8196, 0.7255;
             0.7059, 0.5255, 0.3843;
             0.7529, 0.5804, 0.4745;
             0.6431, 0.4748, 0.3216;
             0.7529, 0.5765, 0.4235;
             0.6392, 0.4902, 0.3451;
             0.8157, 0.6196, 0.4824;
             0.7176, 0.5059, 0.4118;
             0.5843, 0.4353, 0.251;
             0.8588, 0.5843, 0.3137;
             0.6863,0.4314, 0.2824;
             1,1,0.9922;
             0.7373, 0.6706, 0.5922;
             0.8275, 0.8196, 0.7725;
             0.7255, 0.6667, 0.5843;
             0.7373, 0.3569, 0.4863;
             0.7059, 0.1843, 0.3922;
             0.7882, 0.4627, 0.502;
             0.4431, 0.3059, 0.2275;
             0.8902, 0.8706, 0.8471;
             0.8588, 0.8431, 0.8392;
             0.8157, 0.7765, 0.7373;
             0.8471, 0.8314, 0.7961;
             0.7843, 0.7882, 0.7569;
             0.8392, 0.7842, 0.749;
             0.7216, 0.651, 0.5961;
             0.7686, 0.702, 0.6392;
             0.7961, 0.2902, 0.5098;
             0.6667, 0.4078, 0.4157;
             0.6941, 0.4118, 0.4157;
             0.6275, 0.4549, 0.4196;
             0.6588, 0.5961, 0.5961;
             0.549, 0.4196, 0.3922;
             0.6627, 0.6118, 0.4863;
             0.6549, 0.5412, 0.3843;
             0.8235, 0.7412, 0.6353;
             0.7725, 0.6706, 0.5333;
             0.8825, 0.6863, 0.6118;
             0.7804, 0.5686, 0.6235;
             0.5176, 0.3059, 0.2039;
             0.7490, 0.4941, 0.4706;
             0.6745, 0.4, 0.4;
             0.7137, 0.5804, 0.4706;
             0.8078, 0.4588, 0.4667;
             0.7412, 0.4118, 0.4627;
             0.670588, 0.3804, 0.1412;
             0.6980, 0.3882, 0.1255;
             0.7843, 0.6745, 0.5922;
             0.9333, 0.8588, 0.8314;
             0.85098, 0.709804, 0.482353;
             0.862745, 0.705882, 0.3333;
             0.82745, 0.6667, 0.46275;
             0.72157, 0.56078, 0.34117;
             0.905882, 0.82353, 0.6549;
             0.86667, 0.70588, 0.486275;
             0.905882, 0.819608, 0.658824;
             0.764706, 0.603922, 0.4;
             0.698039, 0.537255, 0.317647;
             0.8902, 0.6549, 0.5137;
             0.992157, 0.898309, 0.803922;
             0.886375, 0.792157, 0.690196;
             0.980392, 1, 0.996078;];
             
% label: 1: skin, 0: non-skin
label_a = [0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0,1,1,1,0,0,0,0,1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,1,1,1,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0,1,1,1];
label_a = [label_a, 1,0,0,0,1,0,0,1,1,0,1,1,1,0,0,1,1,0,0,0,1,1,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,1,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,0];
label_a = [label_a, 0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0];
label_a = [label_a, 0,0,0,0,0,0,0,0,0,1,0,0,0];
label_a = label_a';

tic;
% mean & standard dev. of [R,G,B] from its image
mean_R = mean(feature_a(:,1));
mean_G = mean(feature_a(:,2));
mean_B = mean(feature_a(:,3));
std_R = std(feature_a(:,1));
std_G = std(feature_a(:,2));
std_B = std(feature_a(:,3));

themean = [mean_R,mean_G,mean_B];
thestd = [std_R,std_G,std_B];

[m,n] = size(feature_a);
mean_matrix = repmat([mean_R, mean_G, mean_B],m,1);
feature_a = feature_a - mean_matrix;

feature_a(:,1) = feature_a(:,1)/std_R;
feature_a(:,2) = feature_a(:,2)/std_G;
feature_a(:,3) = feature_a(:,3)/std_B;

% SVM
model = svmtrain(label_a, feature_a);
toc;

clearvars -except model themean thestd
