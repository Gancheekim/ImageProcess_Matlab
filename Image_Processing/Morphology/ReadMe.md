Program: Matlab (.m)

## Some codes about basic morphology of image

1. combination of 2 input image into 1 output image:
- obtain the FFT of both image, combine the lowpass signal of image1 with highpass signal of image2.

![q1](https://user-images.githubusercontent.com/55738449/107336631-4a892b00-6af4-11eb-9d6d-36f500a2d0fc.png)


2. dilation/erosion of image

![q2](https://user-images.githubusercontent.com/55738449/107336645-4ceb8500-6af4-11eb-92a0-11d652adee2c.png)

- closing (perform erosion 3 times, then perform dilation 3 times)

![q2_close](https://user-images.githubusercontent.com/55738449/107336656-4fe67580-6af4-11eb-89c5-7f9665bd35dc.png)

- opening (perform dilation 3 times, then perform erosion 3 times)

![q2_open](https://user-images.githubusercontent.com/55738449/107336664-5248cf80-6af4-11eb-8fa9-ad012dfe2b81.png)

- for non-binary image:

![q2_nonbinary](https://user-images.githubusercontent.com/55738449/107336670-54129300-6af4-11eb-8580-a31ea8d6ff35.png)

3. equalizer
- first, we create a blurred image from our input.
- then, we try to "deblur" our blur image

![q3](https://user-images.githubusercontent.com/55738449/107336677-570d8380-6af4-11eb-8f71-7ee02ceea8b7.png)

4. PCA of datas:
- input set of data: (2, -1, 3),   (-1, 3, 5),   (0, 2, 4),  (4, -2, -1),  (1, 0, 4), (-2, 5, 5)

![q4](https://user-images.githubusercontent.com/55738449/107336683-58d74700-6af4-11eb-9a0e-ceebcede21f0.png)
