% Ref
% https://www.mathworks.com/help/images/ref/fitgeotrans.html
% ----------------------------------------------------------------------- %
clear all;close all; clc;

startTime = clock;
%% load Image
distImage = imread('wb.JPEG');
%% Find CheckerboardPoints
refXIndex = 0:341:3751;
refXIndex = repmat(refXIndex',7,1);
refYIndex = 0:341:2046;
refYIndex = repmat(refYIndex,12,1);
refYIndex = refYIndex(:);
imageP1 = [refXIndex,refYIndex];
carmXIndex = [122,316,560,859,1226,1634,2116,2567,2998,3359,3647,3890,...
              170 371,611,914,1258,1667,2128,2570,2980,3318,3614,3856,...
              265,461,697,994,1315,1714,2137,2553,2931,3263,3551,3787,...
              364,558,791,1077,1376,1760,2140,2528,2874,3197,3470,3705,...
              465,656,886,1160,1441,1813,2141,2497,2818,3115,3380,3610,...
              579,767,985,1244,1506,1850,2143,2468,2762,3037,3293,3519,...
              686,872,1080,1323,1566,1885,2137,2434,2696,2950,3191,3405]';
carmYIndex = [824,758,680,605,531,469,426,418,440,484,528,587,...
              1084,1044,1005,960,924,869,868,861,868,880,910,937,...
              1386,1369,1349,1324,1324,1310,1280,1265,1255,1259,1266,1270,...
              1637,1641,1643,1637,1658,1661,1638,1618,1595,1582,1566,1554,...
              1856,1871,1885,1901,1935,1950,1932,1912,1884,1860,1835,1806,...
              2082,2098,2117,2139,2164,2182,2164,2149,2118,2086,2055,2015,...
              2250,2279,2308,2323,2339,2378,2368,2371,2355,2323,2284,2241]';
imageP2 = [carmXIndex,carmYIndex];

%% Use transformation (local weighted mean)
fixedPoints = imageP1;
movingPoints = imageP2;
tform = fitgeotrans(movingPoints,fixedPoints,'pwl');

%% Map distImage to origImage
resolution = [2046 3751 3];
registImage = imwarp(distImage,tform,'OutputView',imref2d(resolution));
fig2 = figure;
montage({distImage,registImage});
imwrite(registImage, "exportImage.png");

%% Display time for processing
endTime = clock;
usedTime = etime(endTime,startTime);
disp(['Used time:',num2str(usedTime),' sec.']);
