% Ref
% https://www.mathworks.com/help/images/ref/fitgeotrans.html
% ----------------------------------------------------------------------- %
clear all;close all; clc;

startTime = clock;
%% load Image
origImage = imread('myRef.png');
distImage = imread('wb.JPEG');

%% Find CheckerboardPoints
refXIndex = 500:250:3750;
refXIndex = repmat(refXIndex',7,1);
refYIndex = 250:250:1750;
refYIndex = repmat(refYIndex,14,1);
refYIndex = refYIndex(:);
imageP1 = [refXIndex,refYIndex];
carmXIndex = [3,172,396,602,912,1258,1665,2127,2571,2980,3322,3615,3858,4043,99,260,457,695,992,1314,1713,2141,2558,2932,3262,3552,3786,3981,200,362,558,790,1077,1376,1760,2140,2525,2876,3193,3467,3704,3902,297,416,654,884,1157,1443,1817,2139,2493,2819,3113,3378,3612,3813,417,576,767,984,1238,1504,1849,2139,2469,2763,3036,3290,3519,3716,...
    517,676,867,1084,1338,1604,1949,2239,2569,2863,3136,3390,3619,3816,...
    617,776,967,1184,1438,1704,2049,2339,2669,2963,3236,3490,3719,3916]';
carmYIndex = [1127,1089,1049,1004,964,924,879,868,859,864,884,911,939,964,1401,1387,1371,1350,1334,1326,1313,1284,1270,1254,1258,1270,1274,1287,1642,1640,1644,1634,1637,1656,1663,1642,1620,1596,1584,1572,1556,1536,1850,1859,1872,1887,1905,1946,1958,1930,1910,1882,1862,1833,1812,1773,2072,2082,2098,2120,2134,2169,2189,2159,2147,2123,2087,2059,2018,1978,...
    2272,2282,2298,2320,2334,2369,2389,2359,2347,2323,2287,2259,2218,2178,...
    2472,2482,2498,2520,2534,2569,2589,2559,2547,2523,2487,2459,2418,2378]';
imageP2 = [carmXIndex,carmYIndex];

%% Display CheckerboardPoints in picture
imageT1 = insertMarker(origImage, imageP1,'x','Color','blue','size',20);
imageT2 = insertMarker(distImage, imageP2,'x','Color','blue','size',20);

fig1 = figure; 
montage({imageT1,imageT2});

%% Use transformation (local weighted mean)
fixedPoints = imageP1;
movingPoints = imageP2;
tform = fitgeotrans(movingPoints,fixedPoints,'lwm',12);

%% Map distImage to origImage
registImage = imwarp(distImage,tform,'OutputView',imref2d(size(origImage)));
fig2 = figure; 
imshowpair(distImage,registImage,'montage')

%% Display time for processing
endTime = clock;
usedTime = etime(endTime,startTime);
disp(['Used time:',num2str(usedTime),' sec.']);
