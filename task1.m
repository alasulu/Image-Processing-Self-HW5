% Image Sources:
%https://blog.microscopeworld.com/2016/12/lungs-under-microscope.html 
%https://people.ee.ethz.ch/~ogoksel/pre/Mattausch_realistic_17pre.pdf
%https://www.melbourneradiology.com.au/diagnostic-imaging/mri-scan-brain/
%https://www.simplypsychology.org/neuron.html
clear
clc

% Part 1, 2, 3, 4, 5
I = imread("lung_cell.jpg"); % Image Reading
Ig = im2gray(I); % Image Converting to Grayscale
Ig_b = imbinarize(Ig); % Grayscale Image Converting to Binarized Image
struct = strel('square',4);
I_erode = imerode(Ig_b,struct); % Erosion of Image
I_dilate = imdilate(Ig_b,struct); % Dilation of Image
I_open = imopen(Ig_b,struct); % Opening of Image
I_close = imclose(Ig_b,struct); % Closing of Image
I_boundary = (Ig_b - I_erode);% Boundary Extraction of Image
figure
subplot(2,3,1)
imshow(I)
title('Original Image')
subplot(2,3,2)
imshow(I_erode)
title('Erosion of Image')
subplot(2,3,3)
imshow(I_dilate)
title('Dilation of Image')
subplot(2,3,4)
imshow(I_open)
title('Opening of Image')
subplot(2,3,5)
imshow(I_close)
title('Closing of Image')
subplot(2,3,6)
imshow(I_boundary)
title('Boundary Extraction of Image')

% Part 6
I2 = imread("heart_ultrasound.jpeg"); % Image Reading 2
Ig2 = im2gray(I2); % Image Converting to Grayscale
Ig_b2 = imbinarize(Ig2); % Grayscale Image Converting to Binarized Image
I_fill = imfill(Ig_b2,"holes"); % Image Filling with Holes
figure
subplot(1,3,1);
imshow(I2)
title('Original Image')
subplot(1,3,2);
imshow(Ig_b2)
title('Binarized Grayscale Image')
subplot(1,3,3)
imshow(I_fill)
title('Filled Image')

% Part 7
I3 = imread("mri_brain.jpeg"); % Image Reading 3
Ig3 = im2gray(I3); % Image Converting to Grayscale
Ig_b3 = imbinarize(Ig3); % Grayscale Image Converting to Binarized Image
[labels, component_num] = bwlabel(Ig_b3); % Extraction of Connected Components of Image
figure
subplot(1,3,1);
imshow(I3)
title('Original Image')
subplot(1,3,2);
imshow(Ig_b3)
title('Binarized Grayscale Image')
subplot(1,3,3);
imshow(im2gray(label2rgb(labels)))
title('Extraction of Connected Components')

% Task 8
I4 = imread("nerve_cells.jpg"); % Image Reading 4
Ig4 = im2gray(I4); % Image Converting to Grayscale
Ig_b4 = imbinarize(Ig4); % Grayscale Image Converting to Binarized Image
I_skel = bwmorph(Ig_b4,'skeleton', Inf);
I_prune = bwmorph(I_skel,'clean');
figure
subplot(2,2,1);
imshow(I4);
title('Original Image')
subplot(2,2,2);
imshow(Ig_b4)
title('Binarized Grayscale Image')
subplot(2,2,3);
imshow(I_skel)
title('Skeleton of Image')
subplot(2,2,4);
imshow(I_prune)
title('Pruned Skeleton Image')

%Oğuzhan Alasulu, Hayriye Kaymaz