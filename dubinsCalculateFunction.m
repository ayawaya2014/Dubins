function [xa,ya,xb,yb] = dubinsCalculateFunction(R,x0,y0,phi1,a0,b0,theta1)

phi0=phi1/pi*180;
x=x0+R*cos((phi0+90)/57.3);   %��ʱ��ԲԲ��--��ʼԲ
y=y0+R*sin((phi0+90)/57.3);

x1=x0+R*cos((phi0-90)/57.3);  %˳ʱ��ԲԲ��--��ʼԲ
y1=y0+R*sin((phi0-90)/57.3);

theta0=theta1/pi*180;
a=a0+R*cos((theta0+90)/57.3);    %��ʱ��ԲԲ��--��ֹԲ
b=b0+R*sin((theta0+90)/57.3);

a1=a0+R*cos((theta0-90)/57.3);    %˳ʱ��ԲԲ��--��ֹԲ
b1=b0+R*sin((theta0-90)/57.3);


%Բ�ľ�
L1=sqrt((x-a)*(x-a)+(y-b)*(y-b));
L2=sqrt((x-a1)*(x-a1)+(y-b1)*(y-b1));
L3=sqrt((x1-a)*(x1-a)+(y1-b)*(y1-b));
L4=sqrt((x1-a1)*(x1-a1)+(y1-b1)*(y1-b1));

[Lmin,index] = min([L1 L2 L3 L4]); 
switch index
    case 1%x,y a,b ��ʼԲ����ֹԲ��
        
        %�����
%         alpa=pi/2+atan(R/L1);
        alpa=pi/2;
        F=[a;b]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[x-a;y-b]*R/L1;
        xb=F(1);       %�е�����
        yb=F(2);
        alpa=alpa+pi;
        I=[x;y]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[a-x;b-y]*R/L1;
        xa=I(1);       %�������
        ya=I(2);
  
    case 2%x,y a1,b1 ��ʼԲ����ֹԲ˳
        
        %�����
%         alpa=-pi/2+atan(2*R/L2);
        alpa=-(pi/2-asin(2*R/L2));
        F=[a1;b1]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[x-a1;y-b1]*R/L2;
        xb=F(1);       %�е�����
        yb=F(2);
        I=[x;y]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[a1-x;b1-y]*R/L2;
        xa=I(1);       %�������
        ya=I(2);
  
    case 3%x1,y1 a,b ��ʼԲ����ֹԲ˳
        
        %�Ҷ���
%         alpa=pi/2-atan(2*R/L1);
        alpa=pi/2-asin(2*R/L3);
        F=[a;b]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[x1-a;y1-b]*R/L3;
        xb=F(1);       %�е�����
        yb=F(2);
        I=[x1;y1]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[a-x1;b-y1]*R/L3;
        xa=I(1);       %�������
        ya=I(2);
        
    case 4%x1,y1 a1,b1 ��ʼԲ˳��ֹԲ˳
        
        %�Ҷ���
%         alpa=-pi/2+atan(R/L4);
        alpa=-pi/2;
        F=[a1;b1]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[x1-a1;y1-b1]*R/L4;
        xb=F(1);       %�е�����
        yb=F(2);
        alpa=alpa+pi;
        I=[x1;y1]+[cos(alpa) -sin(alpa);sin(alpa) cos(alpa)]*[a1-x1;b1-y1]*R/L4;
        xa=I(1);       %�������
        ya=I(2);
      
    otherwise
        error('�쳣')
end

end

