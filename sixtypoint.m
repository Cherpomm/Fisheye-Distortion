clear all;close all; 

distortImageName = 'whiteboard_resize.JPEG';

dist = imread(fullfile(pwd,'Images',distortImageName));

% 60 point 12*5
refX_2 = repmat([0, 250:200:2050 ,2300]',5,1);
refY_2 = sort(repmat([50:150:650]',12,1));
distX_2 = [0, 216, 356, 535, 734, 972, 1242, 1501, 1739, 1933, 2106, 2360,... 
        59, 270, 410, 583, 767, 1004, 1247, 1490, 1712, 1906, 2073, 2327,... 
        119, 324, 459, 632, 805, 1031, 1253, 1474, 1679, 1863, 2025, 2279,... 
        173, 383, 518, 675, 842, 1058, 1247, 1458, 1647, 1820, 1976, 2225,...
        248, 448, 572, 724, 875, 1080, 1247, 1442, 1614, 1776, 1922, 2176]';
distY_2 = [652, 609, 582, 560, 539, 523, 507, 501, 507, 512, 528, 560,... 
        814, 798, 787, 771, 771, 765, 744, 738, 733, 733, 738, 744,... 
        954, 954, 954, 954, 965, 970, 954, 943, 927, 922, 911, 895,... 
        1071, 1087, 1098, 1103, 1125, 1135, 1125, 1108, 1098, 1081, 1065, 1033,... 
        1205, 1222, 1227, 1243, 1254, 1270, 1259, 1248, 1232, 1211, 1195, 1146]';

resolution = [670 2300 3];
start_time = clock;

refPoint = [refX_2,refY_2];
distPoint = [distX_2,distY_2];


fixedPoints = refPoint;
movingPoints = distPoint;

tform = fitgeotrans(movingPoints,fixedPoints,'pwl');

registImage = imwarp(dist,tform,'OutputView',imref2d(resolution)); %%%%%

end_time = clock;
%     
imagemarked = insertMarker(dist, distPoint,'o','Color','blue','size',40);

figure
imshow(imagemarked)
figure
imshow(registImage)

time_used = etime(end_time, start_time);
disp([' used time:',num2str(time_used),' sec.']); 
