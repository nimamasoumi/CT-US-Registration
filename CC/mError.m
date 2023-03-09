%SimulatedUS_CT_v1

function [d2,d0]=mError(x,xd)

% This function calculates the mean error

%load('../../Data/MyDatabase/P2/L1/L1P2HDR.mat')


%% Initial distance calculation

% Initialization of grid points
x0 = -50:1:50;
y0 = -50:1:50;
z0 = -20:1:20;

p0 = combvec(x0,y0,z0);
p0 = [p0;ones(1,size(p0,2))];

% more smart way to the thing above
% [X,Y,Z] = meshgrid([-50:50],[-50:50],[-20:20]);

% setting rigid transformation parameters
a = xd(1);
b = xd(2);
c = xd(3);
tx = xd(4);
ty = xd(5);
tz = xd(6);

T0 = [cos(a)*cos(b) sin(a)*cos(b) -sin(b) tx;...
        (cos(a)*sin(b)*sin(c))-(sin(a)*cos(c)) (sin(a)*sin(b)*sin(c))+(cos(a)*cos(c)) cos(b)*sin(c) ty;...
        (cos(a)*sin(b)*cos(c))+(sin(a)*sin(c)) (sin(a)*sin(b)*cos(c))-(cos(a)*sin(c)) cos(b)*cos(c) tz;...
        0 0 0 1];

p1 = T0*p0;

%Tm=[repmat([CThd.hist.qoffset_y CThd.hist.qoffset_x CThd.hist.qoffset_z],size(p0,2),1) ones(size(p0,2),1)];
%Sm=[repmat([CThd.dime.pixdim(2) CThd.dime.pixdim(3) CThd.dime.pixdim(4)],size(p0,2),1) ones(size(p0,2),1)];
%p0mm = p0'.*Sm + Tm;
%p1mm = p1'.*Sm + Tm;

d0 = mean(sqrt(sum((p1-p0).^2,1)));
%d0mm = mean(sqrt(sum((p1mm-p0mm).^2,2)));

%% Distance after registration

a = x(1);
b = x(2);
c = x(3);
tx = x(4);
ty = x(5);
tz = x(6);

Tr = [cos(a)*cos(b) sin(a)*cos(b) -sin(b) tx;...
        (cos(a)*sin(b)*sin(c))-(sin(a)*cos(c)) (sin(a)*sin(b)*sin(c))+(cos(a)*cos(c)) cos(b)*sin(c) ty;...
        (cos(a)*sin(b)*cos(c))+(sin(a)*sin(c)) (sin(a)*sin(b)*cos(c))-(cos(a)*sin(c)) cos(b)*cos(c) tz;...
        0 0 0 1];

p2 = Tr*p1;

%p2mm = p2'.*Sm + Tm;


d2 = mean(sqrt(sum((p2-p0).^2,1)));
%d2mm = mean(sqrt(sum((p2mm-p0mm).^2,2)));



