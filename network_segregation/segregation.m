clear;
K=4;
p=0.05;
q1=5*p/8; q2=(5-sqrt(5))*p/8; q3=(5+sqrt(5))*p/8;
C1=-3/100; C2=-(2*sqrt(5)+5)/50; C3=-(5-2*sqrt(5))/50;%random graph
%C1=1/50; C2=123/248; C3=61/15127; %short edges only
%C1=-9/50;C2=-451/1284;C3=183/3571; %long edges only
%The following equations are found by solving eq. (10)
e1=@(x) 12/25 + C1.*exp(-q1.*x) + C2.*exp(-q2.*x) + C3.*exp(-q3.*x);
e2=@(x) 6/25 + 3.*C1.*exp(-q1.*x)+0.5.*C2.*(1-sqrt(5)).*exp(-q2.*x)+...
0.5.*C3.*(1+sqrt(5)).*exp(-q3.*x);
e3=@(x) 4/25 - 3.*C1.*exp(-q1.*x)+C2.*(2-sqrt(5)).*exp(-q2.*x)+...
C3.*(2+sqrt(5)).*exp(-q3.*x);
e4=@(x)1-(12/25 + C1.*exp(-q1.*x) + C2.*exp(-q2.*x) + C3.*exp(-q3.*x))-...
(6/25 + 3.*C1.*exp(-q1.*x)+0.5.*C2.*(1-sqrt(5)).*exp(-q2.*x)...
+0.5.*C3.*(1+sqrt(5)).*exp(-q3.*x))-...
(4/25 - 3.*C1.*exp(-q1.*x)+C2.*(2-sqrt(5)).*exp(-q2.*x)+...
C3.*(2+sqrt(5)).*exp(-q3.*x));
hold on;
set(gca,'fontsize',20);
fplot(e1,[0 100],'LineWidth',2);
fplot(e2,[0 100],'LineWidth',2);
fplot(e3,[0 100],'LineWidth',2);
fplot(e4,[0 100],'LineWidth',2);
lgd=legend('0.25','0.5','0.75','1');
lgd.FontSize=20;
xlabel('x');