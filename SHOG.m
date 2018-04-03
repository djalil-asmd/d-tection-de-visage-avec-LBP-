function [C] = SHOG(magnit,angles)
x=abs(radtodeg(angles));
M1=zeros(128,64);
M2=zeros(128,64);
M3=zeros(128,64);
M4=zeros(128,64);
M5=zeros(128,64);
M6=zeros(128,64);
M7=zeros(128,64);
M8=zeros(128,64);
M9=zeros(128,64);
for i=1:128
    for j=1:64
        if (0< x(i,j)&& x(i,j) <20)
            M1(i,j)=magnit(i,j);
        elseif (20< x(i,j)&& x(i,j) <40)
            M2(i,j)=magnit(i,j);
        elseif (40< x(i,j)&& x(i,j) <60)
            M3(i,j)=magnit(i,j);
        elseif (60< x(i,j)&& x(i,j) <80)
            M4(i,j)=magnit(i,j);
        elseif (80< x(i,j)&& x(i,j) <100)
            M5(i,j)=magnit(i,j);
        elseif (100< x(i,j)&& x(i,j) <120)
            M6(i,j)=magnit(i,j);
        elseif (120< x(i,j)&& x(i,j) <140)
            M7(i,j)=magnit(i,j);
        elseif (140< x(i,j)&& x(i,j) <160)
            M8(i,j)=magnit(i,j);
        elseif (160< x(i,j)&& x(i,j) <180)
            M9(i,j)=magnit(i,j);
        end
    end
end
C1=[];
C2=[];
C3=[];
C4=[];
C5=[];
C6=[];
C7=[];
C8=[];
C9=[];
H=size(M1,1);
L=size(M1,2);
m=0;
for i=2:2:16
    x=floor(H/i);
    y=floor(L/i);
    for j=0:(i-1)
        for k=0:(i-1)
        C1=[C1;mean(mean(M1(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C2=[C2;mean(mean(M2(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C3=[C3;mean(mean(M3(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C4=[C4;mean(mean(M4(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C5=[C5;mean(mean(M5(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C6=[C6;mean(mean(M6(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C7=[C7;mean(mean(M7(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C8=[C8;mean(mean(M8(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        C9=[C9;mean(mean(M9(1+(j*x):x+(j*x),1+(k*y):y+(k*y))))];
        end
    end
end
C=[C1;C2;C3;C4;C5;C6;C7;C8;C9];
     
    