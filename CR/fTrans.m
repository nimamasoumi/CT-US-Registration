function [Ireg,If]=fTrans(x,Im,If)

    a = x(1);
    b = x(2);
    c = x(3);
    tx = x(4);
    ty = x(5);
    tz = x(6);    

    Tr = [cos(a)*cos(b) sin(a)*cos(b) -sin(b);...
        (cos(a)*sin(b)*sin(c))-(sin(a)*cos(c)) (sin(a)*sin(b)*sin(c))+(cos(a)*cos(c)) cos(b)*sin(c);...
        (cos(a)*sin(b)*cos(c))+(sin(a)*sin(c)) (sin(a)*sin(b)*cos(c))-(cos(a)*sin(c)) cos(b)*cos(c)];

    sizeY = (size(Im,1)-1)/2;
    sizeX = (size(Im,2)-1)/2;
    sizeZ = (size(Im,3)-1)/2;
    [X, Y, Z]=meshgrid(linspace(-sizeX,sizeX,size(Im,2)),linspace(-sizeY,sizeY,size(Im,1)),linspace(-sizeZ,sizeZ,size(Im,3)));
    tP=Tr*[X(:)'+tx;Y(:)'+ty;Z(:)'+tz];
    tX = reshape(tP(1,:), size(X));
    tY = reshape(tP(2,:), size(Y));
    tZ = reshape(tP(3,:), size(Z));
    tX = tX +sizeX + 1;
    tY = tY +sizeY + 1;
    tZ = tZ +sizeZ + 1;
    
    Ireg = ba_interp3(Im, tX, tY, tZ, 'linear');

end