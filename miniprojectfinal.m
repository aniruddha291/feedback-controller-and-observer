clc;
clear all;
close all;
m=5;
M=10;
l=20;
g=9.81;
a=[0 1 0 0;0 0 -((m*g)/M) 0;0 0 0 1;0 0 ((M+m)*g/(M*l)) 0];
b=[0; (1/M); 0; -(1/(M*l))];
c=[1 0 0 0];
eig(a)
t=0:0.01:30;
u=zeros(size(t));
sys=ss(a,b,c,0);
x0=[0.1 0 0 0.2];
figure(1)
lsim(sys,u,t,x0)

Cont= ctrb(sys);
rank(Cont)
% k=place(a,b,[-2.1 -2.89 -3.06 -3.08]);
k=place(a,b,[-1.1-j -1.1+j -1.2 -1.5])
sys_cl=ss(a-b*k,b,c,0);
eig(sys_cl)
figure(2)
lsim(sys_cl,u,t,x0)

 n=4;
 [y,t,x]=lsim(sys_cl,u,t,[x0]);
 x=x(:,1:4);
 x1=x(:,1);x2=x(:,2);x3=x(:,3);x4=x(:,4)
 figure(3)
 plot(t,x1,'r--',t,x2,'b--',t,x3,'y--',t,x4,'g--')
x10=[0.3 0.2 0.4 0.5];
 obs=obsv(sys);
 Ro=rank(obs);
 L=place(a',c',[-3,-4,-5,-3.5])'
 at=[a-b*k b*k;zeros(size(a)) a-L*c];
 bt=[b; zeros(size(b))];
 ct=[c zeros(size(c))];
 sys_o=ss(at,bt,ct,0);
 x1=[0.01 0.5 -5 -2.4];
 figure(4)
 lsim(sys_o,u,t,[x0 x10]);

n=4;
[y,t,x]=lsim(sys_o,u,t,[x0 x10]);
e=x(:,n+1:end);
x=x(:,1:n);
xe=x-e;
x1=x(:,1);x2=x(:,2);x3=x(:,3);x4=x(:,4);
xe1=xe(:,1);xe2=xe(:,2);xe3=xe(:,3);xe4=x(:,4);
figure(5)
plot(t,x1,'-r',t,xe1,'--c',t,x2,'-b',t,xe2,'--g',t,x3,'-k',t,xe3,'--m',t,x4,'-c',t,xe4,'--b','LineWidth',2);
figure(6)
e1=x(:,1)-xe(:,1);
e2=x(:,2)-xe(:,2);e3=x(:,3)-xe(:,3);e4=x(:,4)-xe(:,4);
plot(t,e1,'-r',t,e2,'-b',t,e3,'-k',t,e4,'-c','LineWidth',2);



