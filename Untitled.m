images = imageDatastore('C:\Users\poomy\Desktop\FigAndCode\wb.JPEG');
[imagePoints,boardSize] = detectCheckerboardPoints(images.Files, 'HighDistortion', true);
squareSize = 20; % millimeters
%worldPoints = generateCheckerboardPoints(boardSize,squareSize);
I = readimage(images,10); 
imageSize = [size(I,1) size(I,2)];
params = estimateFisheyeParameters(imagePoints,worldPoints,imageSize);
J1 = undistortFisheyeImage(I,params.Intrinsics);
figure
imshowpair(I,J1,'montage')
title('Original Image (left) vs. Corrected Image (right)')