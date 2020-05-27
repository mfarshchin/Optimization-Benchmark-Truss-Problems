function D=Data72

%  Nodal Coordinates
Coord=[0,0,0;120,0,0;120,120,0;0,120,0];
for I=1:4
    Coord=[Coord;[Coord(end-3:end,1:2),Coord(end-3:end,3)+60]];
end
%  Connectivity
Con=[1,5;2,6;3,7;4,8;1,6;2,5;2,7;3,6;3,8;4,7;4,5;1,8;5,6;6,7;7,8;8,5;5,7;6,8];

for I=1:3
    Con=[Con;Con(end-17:end,:)+4];
end
%%

% Definition of Degree of freedom (free=0 &  fixed=1); for 2-D trusses the last column is equal to 1
Re=zeros(size(Coord));Re(1:4,:)=[1 1 1;1 1 1;1 1 1;1 1 1];

% Definition of Nodal loads 
LoadCase1=zeros(size(Coord));LoadCase1(17:20,:)=1e3*[0 0 -5;0 0 -5;0 0 -5;0 0 -5];
LoadCase2=zeros(size(Coord));LoadCase2(17,:)=1e3*[5,5,-5];

% Definition of Modulus of Elasticity
E=ones(1,size(Con,1))*1e7;

% Initialize Section Areas
A=ones(1,72);
% Available sections
AV=.1*1:26;%in^2 We do not need this part because its continuous
%Allowable stress
TM=25000;%Ksi
%Allowable displacement
DM=0.25;%inch In the uppermost nodes (17,18,19,20)
DMControlNodes=[17 18 19 20];
%WEIGHT PER UNIT VOLUME
RO=.1;%lb/in^3
% Groups
Group={{[1:4]';[5:12]';[13:16]';[17:18]';[19:22]';[23:30]';[31:34]';[35:36]';[37:40]';[41:48]';[49:52]',...
    ;[53:54]';[55:58]';[59:66]';[67:70]';[71:72]'}};
LB=ones(1,16)*0.1;
UB=ones(1,16)*3;

% Convert to structure array
D=struct('Coord',Coord','Con',Con','Re',Re','LoadCase1',LoadCase1','LoadCase2',LoadCase2','E',E','A',A','AV',AV','TM',TM','DM',DM','RO',RO','Group',Group,'LB',LB,'UB',UB,'DMControlNodes',DMControlNodes);

