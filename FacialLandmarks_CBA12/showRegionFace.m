clear all;
I = imread('IMG00576.PNG');
I = imresize(I, [224,224]);
%% check the face

FDetect = vision.CascadeObjectDetector;
Face = step(FDetect,I);
detectedImg = insertObjectAnnotation(I,'rectangle',Face,'Face');
imshow(detectedImg,'InitialMagnification',50); hold on;

%%
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I); 
 
%To detect Left Eye
LeftEye = [BB(1) BB(2) BB(3)/2 BB(4)];
detectedLeftEye = insertObjectAnnotation(I,'rectangle',LeftEye,'Eye');
imshow(detectedLeftEye,'InitialMagnification',50); hold on;

%%
EyeDetect = vision.CascadeObjectDetector('EyePairBig');
BB=step(EyeDetect,I); 

%To detect Right Eye
RightEye = [BB(1)+BB(3)/2 BB(2) BB(3)/2  BB(4)];
detectedRightEye= insertObjectAnnotation(I,'rectangle',RightEye,'Eye');
imshow(detectedRightEye,'InitialMagnification',50); hold on;

%%
%%%To detect Mouth
FDetect = vision.CascadeObjectDetector;
Face = step(FDetect,I);
imgFace = (I(Face(1,2):Face(1,2)+Face(1,4),Face(1,1):Face(1,1)+Face(1,3),:));
 
MouthDetect = vision.CascadeObjectDetector('Mouth');
findMouth=step(MouthDetect,imgFace);
orderMouth= sortrows(findMouth,2);
posMouth = size(findMouth,1);
Mouth = orderMouth(posMouth,:);
 
detectedMouth = insertObjectAnnotation(I,'rectangle',Mouth,'r');
imshow(detectedMouth,'InitialMagnification',50); hold on;