
clear,clc
addpath('./common/');
addpath('./svm/');
addpath('./svm/minFunc/');


hog.numBins = 9;
hog.numHorizCells = 8;
hog.numVertCells = 16;

hog.cellSize = 8;

hog.winSize = [(hog.numVertCells * hog.cellSize + 2), ...
    (hog.numHorizCells * hog.cellSize + 2)];

tic,
fs=sprintf('Positive');
fichier=dir(fs);
taille=size(fichier,1);
X_train=[];
y_train=[];
z=0;
for i=3:taille
    fs2=fichier(i).name;
    fs2=strcat(fs,'/',fs2);
    fichier2=dir(fs2);
    taille2=size(fichier2,1);
    for j=3:taille2
        fs3=fichier2(j).name;
        fs3=strcat(fs2,'/',fs3);
        %video=VideoReader(fs2);
        %while hasFrame(video)
        %img=rgb2gray(readFrame(video));
        img=imread(fs3);
        img=imresize(img,[130,66]);
cform = makecform('srgb2xyz');
xyz_img = applycform(img,cform);
cform = makecform('xyz2uvl');
luv_img = applycform(xyz_img,cform);
l = luv_img(:,:,1); 
u = luv_img(:,:,2); 
v = luv_img(:,:,3); 
l=imresize(l,[128,64]);
u=imresize(u,[128,64]);
v=imresize(v,[128,64]);
        if (size(img,3) == 3)
            img = rgb2gray(img);
        end
        [magnit,angles] = getSHOGDescriptor(hog, img);
x=abs(radtodeg(angles));
M1=zeros(128,64);
M2=zeros(128,64);
M3=zeros(128,64);
M4=zeros(128,64);
M5=zeros(128,64);
M6=zeros(128,64);
for i=1:128
    for j=1:64
        if (0< x(i,j)&& x(i,j) <30)
            M1(i,j)=x(i,j);
        elseif (20< x(i,j)&& x(i,j) <60)
            M2(i,j)=x(i,j);
        elseif (40< x(i,j)&& x(i,j) <90)
            M3(i,j)=x(i,j);
        elseif (60< x(i,j)&& x(i,j) <120)
            M4(i,j)=x(i,j);
        elseif (80< x(i,j)&& x(i,j) <150)
            M5(i,j)=x(i,j);
        elseif (100< x(i,j)&& x(i,j) <180)
            M6(i,j)=x(i,j);
        end
    end
end
LBP1= efficientLBP(l);
LBP2= efficientLBP(u);
LBP3= efficientLBP(v);
LBP4= efficientLBP(magnit);
LBP5= efficientLBP(M1);
LBP6= efficientLBP(M2);
LBP7= efficientLBP(M3);
LBP8= efficientLBP(M4);
LBP9= efficientLBP(M5);
LBP10= efficientLBP(M6);
C=[LBP1;LBP2;LBP3;LBP4;LBP5;LBP6;LBP7;LBP8;LBP9;LBP10];
[pc,score,latent,tsquare] = princomp(double(C));
H=reshape(pc,[1,4096]);
        %H=SHOG(magnit,angles);
       % H = getHOGDescriptor(hog, img);
        %H = detectSURFFeatures(img);
        %if (size(H,1)>9)
        %H = H.selectStrongest(10);
        %[features,validPoints] = extractFeatures(img,H);
        %H=double(features(:));
        %[a,b,c,d] = dwt2(img,'haar');
        %H=reshape(a,[1,2145]);
        X_train=[X_train;H];
        y_train=[y_train;1];
    end
    z=z+1;
    printIteration(z);
end


fs=sprintf('Negative');
fichier=dir(fs);
taille=size(fichier,1);
for i=3:taille
    fs2=fichier(i).name;
    fs2=strcat(fs,'/',fs2);
    fichier2=dir(fs2);
    taille2=size(fichier2,1);
    for j=3:taille2
        fs3=fichier2(j).name;
        fs3=strcat(fs2,'/',fs3);
        %video=VideoReader(fs2);
        %while hasFrame(video)
        %img=rgb2gray(readFrame(video));
        img=imread(fs3);
        img=imresize(img,[130,66]);
cform = makecform('srgb2xyz');
xyz_img = applycform(img,cform);
cform = makecform('xyz2uvl');
luv_img = applycform(xyz_img,cform);
l = luv_img(:,:,1); 
u = luv_img(:,:,2);
v = luv_img(:,:,3); 
l=imresize(l,[128,64]);
u=imresize(u,[128,64]);
v=imresize(v,[128,64]);
        if (size(img,3) == 3)
            img = rgb2gray(img);
        end
        [magnit,angles] = getSHOGDescriptor(hog, img);
x=abs(radtodeg(angles));
M1=zeros(128,64);
M2=zeros(128,64);
M3=zeros(128,64);
M4=zeros(128,64);
M5=zeros(128,64);
M6=zeros(128,64);
for i=1:128
    for j=1:64
        if (0< x(i,j)&& x(i,j) <30)
            M1(i,j)=x(i,j);
        elseif (20< x(i,j)&& x(i,j) <60)
            M2(i,j)=x(i,j);
        elseif (40< x(i,j)&& x(i,j) <90)
            M3(i,j)=x(i,j);
        elseif (60< x(i,j)&& x(i,j) <120)
            M4(i,j)=x(i,j);
        elseif (80< x(i,j)&& x(i,j) <150)
            M5(i,j)=x(i,j);
        elseif (100< x(i,j)&& x(i,j) <180)
            M6(i,j)=x(i,j);
        end
    end
end
LBP1= extractLBPFeatures(l);
LBP2= extractLBPFeatures(u);
LBP3= extractLBPFeatures(v);
LBP4= extractLBPFeatures(magnit);
LBP5= extractLBPFeatures(M1);
LBP6= extractLBPFeatures(M2);
LBP7= extractLBPFeatures(M3);
LBP8= efficientLBP(M4);
LBP9= efficientLBP(M5);
LBP10= efficientLBP(M6);
C=[LBP1;LBP2;LBP3;LBP4;LBP5;LBP6;LBP7;LBP8;LBP9;LBP10];
[pc,score,latent,tsquare] = princomp(double(C));
H=reshape(pc,[1,4096]);
        %H=SHOG(magnit,angles);
        %H = getHOGDescriptor(hog, img);
        %H = detectSURFFeatures(img);
        %if (size(H,1)>9)
        %H = H.selectStrongest(10);
        %[features,validPoints] = extractFeatures(img,H);
        %H=double(features(:));
        %[a,b,c,d] = dwt2(img,'haar');
        %H=reshape(a,[1,2145]);
        X_train=[X_train;H];
        y_train=[y_train;0];
    end
    z=z+1;
    printIteration(z);
end

time=toc;


tic,
fprintf('\nTraining linear SVM classifier...\n');
X_train=X_train;
hog.theta = train_svm(X_train, y_train, 1.0);

save('hog_model.mat', 'hog');
 
p = X_train * hog.theta;

numRight = sum((p > 0) == y_train);

fprintf('\napprentissage accuracy: (%d / %d) %.2f%%\n', numRight, length(y_train), numRight / length(y_train) * 100.0);

p = cvpartition(y_train,'Holdout',0.36);
train_input=X_train(p.training,:);
train_output=y_train(p.training);
test_input=X_train(p.test,:);
test_output=y_train(p.test);
hog.theta = train_svm(train_input, train_output, 1.0);

save('hog_model.mat', 'hog');

p = test_input * hog.theta;

numRight = sum((p > 0) == test_output);

fprintf('\nrecaonnaissance accuracy: (%d / %d) %.2f%%\n', numRight, length(test_output), numRight / length(test_output) * 100.0);
time2=toc;