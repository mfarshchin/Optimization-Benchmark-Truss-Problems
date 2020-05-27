function [WE,GOAL]=ST72(In,D)
% This function analysis the design
% The truss analyser function is taken from this link: http://www.mathworks.com/matlabcentral/fileexchange/14313-truss-analysis
% and is slightly modified to be used in this code
D.A=In;

w=size(D.Re);S=zeros(3*w(2));U=1-D.Re;f=find(U);
WE=0;
for i=1:size(D.Con,2)
   H=D.Con(:,i);C=D.Coord(:,H(2))-D.Coord(:,H(1));Le=norm(C);
   T=C/Le;s=T*T';G=D.E(i)*D.A(i)/Le;Tj(:,i)=G*T;
   e=[3*H(1)-2:3*H(1),3*H(2)-2:3*H(2)];S(e,e)=S(e,e)+G*[s -s;-s s];
   WE=WE+Le*D.A(i)*D.RO;
end
%analyse for LoadCase1
U(f)=S(f,f)\D.LoadCase1(f);F=sum(Tj.*(U(:,D.Con(2,:))-U(:,D.Con(1,:))));
R=reshape(S*U(:),w);R(f)=0;
TS1=(((abs(F'))./D.A)/D.TM)-1;%tanesh
US1=abs(U')/D.DM-1;%Displacement

%analyse for LoadCase2
U(f)=S(f,f)\D.LoadCase2(f);F=sum(Tj.*(U(:,D.Con(2,:))-U(:,D.Con(1,:))));
R=reshape(S*U(:),w);R(f)=0;
TS2=(((abs(F'))./D.A)/D.TM)-1;%Tension
US2=abs(U')/D.DM-1;%Displacement

TS=max([TS1,TS2],[],2);
US3=max(US1,US2);
US=US3(end-3:end,:);% only check displacements for top 4 nodes
PS=sum(TS.*(TS>0));
PD=sum(sum(US.*(US>0)));
GOAL=WE*(1+PS+PD)^2;