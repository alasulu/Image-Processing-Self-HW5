clear
clc

%---------------------------%

I = imread("grayscale_brain.png"); % Image Reading
I2 = imread("grayscale_brain_2.png"); % Image Reading
I3 = imread("mri_brain.jpeg"); % Image Reading
Ig = rgb2gray(I); % Image Converting to Grayscale
Ig2 = rgb2gray(I2); % Image Converting to Grayscale
Ig3 = rgb2gray(I3); % Image Converting to Grayscale

% Thresholding %

% Global Threshold
Ig_gl_thres = imbinarize(Ig,'global'); % Binarizing Image Respect Global Threshold
Ig_gl_thres2 = imbinarize(Ig2,'global'); % Binarizing Image Respect Global Threshold
Ig_gl_thres3 = imbinarize(Ig3,'global'); % Binarizing Image Respect Global Threshold

% Adaptive Threshold
Ig_adap_thres = imbinarize(Ig, 'adaptive'); % Binarizing Image Respect Adaptive Threshold
Ig_adap_thres2 = imbinarize(Ig2, 'adaptive'); % Binarizing Image Respect Adaptive Threshold
Ig_adap_thres3 = imbinarize(Ig3, 'adaptive'); % Binarizing Image Respect Adaptive Threshold

% Otsu's Method Threshold
Otsu_thres = graythresh(Ig); % Finding Global Threshold Value
Ig_otsuthres = imbinarize(Ig,Otsu_thres); % Binarizing Image Respect Otsu Threshold
Otsu_thres2 = graythresh(Ig2); % Finding Global Threshold Value
Ig_otsuthres2 = imbinarize(Ig2,Otsu_thres2); % Binarizing Image Respect Otsu Threshold
Otsu_thres3 = graythresh(Ig3); % Finding Global Threshold Value
Ig_otsuthres3 = imbinarize(Ig3,Otsu_thres3); % Binarizing Image Respect Otsu Threshold

% Plotting
figure
subplot(4,3,1);
imshow(Ig)
title('Grayscale Image 1')
subplot(4,3,2);
imshow(Ig2)
title('Grayscale Image 2')
subplot(4,3,3);
imshow(Ig3)
title('Grayscale Image 3')
subplot(4,3,4);
imshow(Ig_gl_thres)
title('Global Thresholding 1')
subplot(4,3,5);
imshow(Ig_gl_thres2)
title('Global Thresholding 2')
subplot(4,3,6);
imshow(Ig_gl_thres3)
title('Global Thresholding 3')
subplot(4,3,7);
imshow(Ig_adap_thres)
title('Adaptive Thresholding 1')
subplot(4,3,8);
imshow(Ig_adap_thres2)
title('Adaptive Thresholding 2')
subplot(4,3,9);
imshow(Ig_adap_thres3)
title('Adaptive Thresholding 3')
subplot(4,3,10);
imshow(Ig_otsuthres)
title('Otsu Thresholding 1')
subplot(4,3,11);
imshow(Ig_otsuthres2)
title('Otsu Thresholding 2')
subplot(4,3,12);
imshow(Ig_otsuthres3)
title('Otsu Thresholding 3')

%---------------------------%

I4 = imread("nerve_cells.jpg"); % Image Reading
I5 = imread("lung_cell.jpg"); % Image Reading
I6 = imread("mri_brain.jpeg"); % Image Reading
Ig4 = im2gray(I4); % Image Converting to Grayscale
Ig5 = im2gray(I5); % Image Converting to Grayscale
Ig6 = im2gray(I6); % Image Converting to Grayscale

% Segmentation %

% Region-based Segmentation with Watershed Transform
Magnitude_gradient = imgradient(Ig4); % Finding Gradient Magnitude
Magnitude_gradient2 = imgradient(Ig5); % Finding Gradient Magnitude
Magnitude_gradient3 = imgradient(Ig6); % Finding Gradient Magnitude
struct = strel('square',20); % Creating Numerical Structure
Magnitude_gradient_closed = imclose(Magnitude_gradient,struct); % Closing the Gradient Magnitude
Magnitude_gradient_closed2 = imclose(Magnitude_gradient2,struct); % Closing the Gradient Magnitude
Magnitude_gradient_closed3 = imclose(Magnitude_gradient3,struct); % Closing the Gradient Magnitude
Region_minima = imregionalmin(Magnitude_gradient_closed); % Finding Regional Minima
Region_minima2 = imregionalmin(Magnitude_gradient_closed2); % Finding Regional Minima
Region_minima3 = imregionalmin(Magnitude_gradient_closed3); % Finding Regional Minima
Distance_tr = bwdist(Region_minima); % Discrete Transform Computation
Distance_tr2 = bwdist(Region_minima2); % Discrete Transform Computation
Distance_tr3 = bwdist(Region_minima3); % Discrete Transform Computation
Segmentation = watershed(-Distance_tr); % Perform Watershed Segmentation
Segmentation2 = watershed(-Distance_tr2); % Perform Watershed Segmentation 2
Segmentation3 = watershed(-Distance_tr3); % Perform Watershed Segmentation 3

% Plotting
figure
subplot(2,3,1);
imshow(Ig4)
title('Grayscale Image 1')
subplot(2,3,2);
imshow(Ig5)
title('Grayscale Image 2')
subplot(2,3,3);
imshow(Ig6)
title('Grayscale Image 3')
subplot(2,3,4)
imshow(Segmentation,[]);
title('Region-based Segmentation of Image')
subplot(2,3,5)
imshow(Segmentation2,[]);
title('Region-based Segmentation of Image')
subplot(2,3,6)
imshow(Segmentation3,[]);
title('Region-based Segmentation of Image')

% Edge-based Segmentation
I_edge = edge(Ig4, 'canny'); % Implementation of Edge-Based Segmentation
I_edge2 = edge(Ig5, 'canny'); % Implementation of Edge-Based Segmentation 2 
I_edge3 = edge(Ig6, 'canny'); % Implementation of Edge-Based Segmentation 3
figure
subplot(2,3,1);
imshow(Ig4)
title('Grayscale Image 1')
subplot(2,3,2);
imshow(Ig5)
title('Grayscale Image 2')
subplot(2,3,3);
imshow(Ig6)
title('Grayscale Image 3')
subplot(2,3,4)
imshow(I_edge)
title('Edge-Based Segmentation of Image')
subplot(2,3,5)
imshow(I_edge2)
title('Edge-Based Segmentation of Image')
subplot(2,3,6)
imshow(I_edge3)
title('Edge-Based Segmentation of Image')

% Clustering-based Segmentation
[rows,cols,ch] = size(Ig4); % Finding the size of image 
[rows2,cols2,ch2] = size(Ig5); % Finding the size of image 
[rows3,cols3,ch3] = size(Ig6); % Finding the size of image 
Ig4_shaped = reshape(Ig4,rows*cols, ch); % Reshaping Image into 2D Array
Ig5_shaped = reshape(Ig5,rows2*cols2, ch2); % Reshaping Image into 2D Array
Ig6_shaped = reshape(Ig6,rows3*cols3, ch3); % Reshaping Image into 2D Array
K = 5; % Cluster Number
[cluster_indices, clust_centers] = kmeans(double(Ig4_shaped),K); % K-mean Calculation
[cluster_indices2, clust_centers2] = kmeans(double(Ig5_shaped),K); % K-mean Calculation
[cluster_indices3, clust_centers3] = kmeans(double(Ig6_shaped),K); % K-mean Calculation
Ig4_segmented = reshape(cluster_indices,rows,cols); % Clustering-based Segmented Image
Ig5_segmented = reshape(cluster_indices2,rows2,cols2); % Clustering-based Segmented Image 2 
Ig6_segmented = reshape(cluster_indices3,rows3,cols3); % Clustering-based Segmented Image 3
figure
subplot(2,3,1);
imshow(Ig4)
title('Grayscale Image 1')
subplot(2,3,2);
imshow(Ig5)
title('Grayscale Image 2')
subplot(2,3,3);
imshow(Ig6)
title('Grayscale Image 3')
subplot(2,3,4)
imshow(Ig4_segmented, [])
title('Clustering-based Segmentation of Image')
subplot(2,3,5)
imshow(Ig5_segmented, [])
title('Clustering-based Segmentation of Image')
subplot(2,3,6)
imshow(Ig6_segmented, [])
title('Clustering-based Segmentation of Image')

% Oğuzhan Alasulu, Hayriye Kaymaz