clc
clear all

% read the input image
%I = imread('svm/IMG_1.png');
%I = imresize(I, [224,224]);

%for i=1:50 %suppose there are 10 image
%file_name=dir(strcat('svm\*.png')); % the path tht u hv imges
 % I=imread(strcat('svm\',file_name(i).name));
  %imtool(I);
 
ims = dir('sunny/*.png');
for i = 1:length(ims),
    fprintf('testing: %d/%d\n', i, length(ims));
    I = imread(['sunny/' ims(i).name]);
    clf; imagesc(I); axis image; axis off; drawnow;

[imgFace, LeftEye, RightEye, Mouth, LeftEyebrow,  RightEyebrow] = detectFacialRegions(I);

% config landmarks to Eyes and Mouth (4 and 5)
landconf = 5;

% config of landmarks Eyebrows (only 2)
landconfEyebrow = 2;

%% landmarks the eyes
imgLeftEye = (imgFace(LeftEye(1,2):LeftEye(1,2)+LeftEye(1,4),LeftEye(1,1):LeftEye(1,1)+LeftEye(1,3),:));
[landLeftEye, leftEyeCont] = eyesProcessing(imgLeftEye,landconf);

imgRightEye = (imgFace(RightEye(1,2):RightEye(1,2)+RightEye(1,4),RightEye(1,1):RightEye(1,1)+RightEye(1,3),:));
[landRightEye, rightEyeCont] = eyesProcessing(imgRightEye,landconf);

% landmarks the eyebrows
imgLeftEyebrow = (imgFace(LeftEyebrow(1,2):LeftEyebrow(1,2)+LeftEyebrow(1,4),LeftEyebrow(1,1):LeftEyebrow(1,1)+LeftEyebrow(1,3),:));
[landLeftEyebrow, leftEyebrowCont] = eyebrowsProcessing(imgLeftEyebrow,landconfEyebrow);2

imgRightEyebrow = (imgFace(RightEyebrow(1,2):RightEyebrow(1,2)+RightEyebrow(1,4),RightEyebrow(1,1):RightEyebrow(1,1)+RightEyebrow(1,3),:));
[landRightEyebrow, RightEyebrowCont] = eyebrowsProcessing(imgRightEyebrow,landconfEyebrow);

%% shows (eyes, mouth and eyebrows)
imshow(imgFace,'InitialMagnification',50); hold on;
showsLandmarks(landLeftEye,leftEyeCont,LeftEye,landconf);
showsLandmarks(landRightEye,rightEyeCont,RightEye,landconf);
showsLandmarks(landLeftEyebrow,leftEyebrowCont,LeftEyebrow,landconfEyebrow);
showsLandmarks(landRightEyebrow,RightEyebrowCont,RightEyebrow,landconfEyebrow);

    tic;
    dettime = toc;
    
fprintf('Detection took %.1f seconds\n',dettime);
    disp('press any key to continue');
    pause;
    close all;
end
disp('done!');