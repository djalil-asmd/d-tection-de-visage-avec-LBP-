function [magnit,angles] = getSHOGDescriptor(hog, img)

assert(isequal(size(img), hog.winSize))

hx = [-1,0,1];
hy = hx';

dx = filter2(hx, double(img));
dy = filter2(hy, double(img));

dx = dx(2 : (size(dx, 1) - 1), 2 : (size(dx, 2) - 1));
dy = dy(2 : (size(dy, 1) - 1), 2 : (size(dy, 2) - 1)); 

angles = atan2(dy, dx);
magnit = ((dy.^2) + (dx.^2)).^.5;

    
end
