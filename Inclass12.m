%Inclass 12. 
%GB comments
1) 100
2) 100
3) 100 think your thresholding is a bit high, but its fine for answering the question
4) 100
Overall 100


% Continue with the set of images you used for inclass 11, the same time 
% point (t = 30)

% 1. Use the channel that marks the cell nuclei. Produce an appropriately
% smoothed image with the background subtracted. 

filename = '011917-wntDose-esi017-RI_f0016.tif';
book = bfGetReader(filename);
inplane_nu = book.getIndex(0, 1, 29)+1;
inplane_me = book.getIndex(0, 0, 29)+1;

img1 = bfGetPlane(book, inplane_nu);
img1_sm = imfilter(img1, fspecial('gaussian',4,2));
imshow(imadjust(img1_sm))
img2 = bfGetPlane(book, inplane_me);

img1_bg = imopen(img1, strel('disk',100));
img1_sm_bgsub = imsubtract(img1_sm, img1_bg);
imshow(img1_sm_bgsub,[100,700])

% 2. threshold this image to get a mask that marks the cell nuclei. 

img_mask = img1_sm_bgsub > 220;
imshow(img_mask)

% 3. Use any morphological operations you like to improve this mask (i.e.
% no holes in nuclei, no tiny fragments etc.)

img_improved = imclose(imopen(img1_sm_bgsub, strel('disk', 6)), strel('disk', 7));
improved_mask = img_improved > 240
imshow(improved_mask)

% 4. Use the mask together with the images to find the mean intensity for
% each cell nucleus in each of the two channels. Make a plot where each data point 
% represents one nucleus and these two values are plotted against each other

mean_intensity1 = regionprops(img_improved, img1, 'MeanIntensity');
mean_intensity2 = regionprops(img_improved, img2, 'MeanIntensity');
x = struct2dataset(mean_intensity1);
y = struct2dataset(mean_intensity2);
plot(x, y,'o')
