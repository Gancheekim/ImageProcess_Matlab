# Face Recognition project 
- this is my undergraduate research of face recognition of image
- enviroment: matlab with image processing and SVM classifier
- you can contact me via my email: b07901133@ntu.edu.tw   to share your commend with me! many thanks

## code description:
- Main code : Main_code.m, you can run this code to do all things.
- the project has been working around 6 weeks, so i separate the skeleton code into 6 parts, which is week1.m to week6.m

### brief project process:
#### week 1: collect data and build a svm model to classify the skin-like pixel of image (input feature of model: R,G,B matrix)
- image source: myself, please do not use my photo for any profit use, many thanks.
<img src="https://user-images.githubusercontent.com/55738449/113845471-22ead200-97c8-11eb-9692-cb44f2edda27.jpg" width="320" height="440">

#### week 2: input testing image into the model and obtain the skin-like detection. (labeling: 0: non-skin, 1: skin)
- for any region that is too small, we discard the region as it may be noise to our prediction
- apply morphology closing for better result
<img src="https://user-images.githubusercontent.com/55738449/113845635-4e6dbc80-97c8-11eb-89e4-a76650fa127f.jpg" width="350" height="460"> <img src="https://user-images.githubusercontent.com/55738449/113849586-3e57dc00-97cc-11eb-96ae-aa771010e35e.png" width="350" height="460">

#### week 3: for the regions detected, we apply PCA estimation of data as ellipse, then we measure the similarity between the region and the estimated ellipse.
- for any region that score under 70%, we discard it.
<img src="https://user-images.githubusercontent.com/55738449/113845716-5f1e3280-97c8-11eb-96a5-4eeb44765a84.png" width="320" height="440">

#### week 4: on the result of week3, we apply linear combination of YCbCr to obtain our eyemap, and find the potential candidate(location) of eyes.
<img src="https://user-images.githubusercontent.com/55738449/113845800-73622f80-97c8-11eb-8946-c89e94c74291.png" width="320" height="440">

#### week 5: linear combination of YCbCr to obtain the mouth map of our detected result, and find the possible-center location of our mouth.
<img src="https://user-images.githubusercontent.com/55738449/113845876-84ab3c00-97c8-11eb-937e-e2b0697c08b5.png" width="320" height="440">

#### week 6: eyes-mouth pair verification according to some rules we created(most are according to the geometry characteristic of face that we observed)
- for any pairs of eye and mouth that satiesfies all the rules, we conclude that the result is a human-face,
- we return the output image as ellipse-masking of human-face, that has red-dot near the iris(eye), and green-dot near the mouth.
<img src="https://user-images.githubusercontent.com/55738449/113845920-912f9480-97c8-11eb-9315-331fcdf2437e.png" width="320" height="440">

## for other results: (image source: MIT database)
<img src="https://user-images.githubusercontent.com/55738449/113847966-91c92a80-97ca-11eb-8cc4-792b5835a409.jpg" width="400" height="440"> <img src="https://user-images.githubusercontent.com/55738449/113848177-c9d06d80-97ca-11eb-9583-cd24fa6676b4.png" width="400" height="440"> 

<img src="https://user-images.githubusercontent.com/55738449/113848404-04d2a100-97cb-11eb-8788-ed244a86462c.jpg" width="400" height="440"> <img src="https://user-images.githubusercontent.com/55738449/113849051-a9ed7980-97cb-11eb-8bbc-282504642dba.png" width="400" height="440"> 

<img src="https://user-images.githubusercontent.com/55738449/113848596-3e0b1100-97cb-11eb-96ce-6d8c2a34b430.jpg" width="400" height="440"> <img src="https://user-images.githubusercontent.com/55738449/113848803-6abf2880-97cb-11eb-8078-48a5ae7eea96.png" width="400" height="440"> 




