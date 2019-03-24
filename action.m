%�������
clear all;
close all; 
% ����AUV��������
xmin = [0; 0];  
xmax = [50;50]; 

%������ͨ�ò������ã�����%
% ����AUV��Ŀ���Ĳ���
% �趨Ŀ��
Target = [
          15 24;
          10.5 11;
          4 3;
          18 6;
          4 20;
          20 13;
%           9 8;
%          20 20;
%          7 14;
         ]';     


% �趨������ʸ�����ٶȡ���X������н�
TargetV = [
           0 1*pi/4;
           0 2*pi/4;
           0 2*pi/4;
           0 2*pi/4;
           0 3*pi/4;
           0 2*pi/4;
           0 2*pi/4;
           0 3*pi/4
          ]'; 

% �趨������
Robot = [
%     20 20;
%          16 23;
         12 21;
%          11 16;
         4 10;
%          24 1;
%          23 16;
%          9 8;
%          20 20;
%          7 14;
        ]'; 

% �趨������ʸ�����ٶȡ���X������н�
RobotV = [
          0 3*pi/4;
          0 2*pi/4;
          0 1*pi/4;
          0 1*pi/4;
          0 2*pi/4;
          0 1*pi/4;
          0 1*pi/4;
          0 1*pi/4;
          0 1*pi/4
         ]'; 

% �趨�ϰ���
%0-����ʾ 1-��ʾ
ObstacleFlag = 1;
%�ϰ������
Obstacle = [
            -1 0;
            7.5 15;
%             22 15;
%             4 5
           ]'; 
ObstacleR = 1; %�ϰ���뾶


%Ч���ĸ���������
Mat1 = size(Target); 
TarNum = Mat1(1,2);
Mat2 = size(Robot); 
RorNum = Mat2(1,2);
Mat3 = size(TargetV); 
TarVNum = Mat3(1,2);
Mat4 = size(RobotV); 
RorVNum = Mat4(1,2);
if(TarNum~=TarVNum||RorNum~=RorVNum)
%     error('��ʼ�����鳤�ȴ���')
end

%���ݻ����˵�������ʼ����¼����;��������
%��һ�м�¼��Ӧ��������˵���������
%�ڶ��м�¼��Ӧ��������˵����߾��루��λ���ȣ�
RobortMonitor  = zeros(2,RorNum);
%�����趨���ޣ�����ȡ��
taskMax=ceil(TarNum/RorNum)+1;
% taskMax=3;
%������߾����ж�
maxDis=taskMax*100;

%��������
currentFlag=0;%�����������ñ�־ 0-�����ã�1-����
vc=1;%ƫ�Ƴ���
ai=30*pi/180;

%�������켣����������%
%ֱ��dubins����
%0-ֱ��
%1-dubins��Ŀ��ͻ����˶����ٶ������� 
%2-dubins�������˴��ٶ�������
lineFlag=1;

%ת��뾶
turnR=1;
%-------------------------------------------------------------------------%

% �������ʼ״̬
figure
% plot(Robot(1,:),Robot(2,:),'.r','MarkerSize',10);
plot(Robot(1,:),Robot(2,:),'.r','LineWidth', 2, 'Marker', 'd');
axis([0 24 0 30]); 
xlabel('X ��')
ylabel('Y ��','rotation',0)
title('��ʼλ�÷���')
hold on
plot(Target(1,:),Target(2,:),'.g','MarkerSize',30);
hold on
if(ObstacleFlag==0)
    legend('������','����Ŀ��',2);
elseif(ObstacleFlag==1)
    plot(Obstacle(1,:),Obstacle(2,:),'.k','Marker', 'x','MarkerSize',10);
    legend('������','����Ŀ��','�ϰ���',2);
end
hold on
axis equal
Weight{1} = Robot;
WeightV{1} = RobotV;
Target_a = Target;
B = 0.2; % �ɵ�����
r = 0.5; % �ɵ�����
w = 1; %�����˲�������ǰ��һ����ʼ
temp = -1;
tt = 1;

%��һ��ͼ
figure
plot(Robot(1,:),Robot(2,:),'.r','LineWidth', 2, 'Marker', 'd');
axis([0 24 0 30]); 
xlabel('X ��')
ylabel('Y ��','rotation',0)
title('����λ�÷���')
hold on
plot(Target_a(1,:),Target_a(2,:),'.g','MarkerSize',30);
hold on
if(ObstacleFlag==0)
    legend('������','����Ŀ��',2);
elseif(ObstacleFlag==1)
    plot(Obstacle(1,:),Obstacle(2,:),'.k','Marker', 'x','MarkerSize',10);
    legend('������','����Ŀ��','�ϰ���',2);
end
hold on
axis equal
% ��ѭ��
% for t = 1:Step
    t=1;
    for ii=1:TarNum 
       % ԭ������������벢����
%        [Dist{t}(ii),ind(ii),distn] = distanceFunction(Target_a(:,ii),Weight{w}); 
       
       %�ϰ����жϺ���/��������������Ŀ�꣬��ǰ�����˾���
       [Dist{t}(ii),ind(ii),distn] = obstacleFunction(Target_a(:,ii),Weight{w},TargetV(:,ii),WeightV{w},Obstacle,ObstacleR,RobortMonitor,taskMax,maxDis,turnR,lineFlag);
      
       Nk = ii;
       Nm = ind(Nk); 
       % ȡ�û�ʤ��Ԫ
       winnerR = Weight{w}(:,Nm); 
       winnerT = Target_a(:,Nk);
       %���¼�������������
       RobortMonitor(1,Nm) = RobortMonitor(1,Nm)+1;
       
       flag=1;
       
       if(Dist{t}(ii) <= 0.1)
           temp(tt) = ii;
           tt = tt+1;
       end
       flag = 1;
       for zz = 1:tt-1
           if(ii == temp(zz))
               flag = 0;
           end
       end
    
       if(flag == 1)
%            ��ʤ��Ԫ�������
           Neigh{w} = neighborFunction(Weight{w},winnerR,r,t); 
%            	������/���ǵ��������㷨��Ӱ��
           Weight{w+1} = updateCurrentFunction(Weight{w}, B, Neigh{w}, distn, winnerT, Dist{t}(ii),vc,ai,currentFlag);

%             ��ֱ��
%             ʹ�õ�ǰ��ʤ������&��ʤĿ��
%               line([Weight{w}(1,Nm),Target_a(1,Nk)],[Weight{w}(2,Nm),Target_a(2,Nk)])
%             ʹ�õ�ǰ��ʤ������(w)�͸��µ��»�����(w+1)λ�û�ֱ�ߣ����µ��»�����λ�ÿ��ܺ������仯��
%               line([Weight{w}(1,Nm),Weight{w+1}(1,Nm)],[Weight{w}(2,Nm),Weight{w+1}(2,Nm)])
              
              %�������߾���
              if(lineFlag==0)
                  currentDistance = printerLineFunction(Weight{w}(1,Nm),Weight{w+1}(1,Nm),Weight{w}(2,Nm),Weight{w+1}(2,Nm),'b',2);
              elseif(lineFlag==1)%(R,x0,y0,phi1,a0,b0,theta1)
                  currentDistance = printerDubinsFunction(turnR,winnerR(1,1),winnerR(2,1),WeightV{w}(2,Nm),winnerT(1,1),winnerT(2,1),TargetV(2,Nk),'r',2);
              end
              %���»������ٶ�����
              WeightV{w+1}=WeightV{w};
              WeightV{w+1}(2,Nm)=TargetV(2,Nk);
              %���¼������ۻ����߾���
              RobortMonitor(2,Nm) = RobortMonitor(2,Nm)+currentDistance;
            w = w + 1;
       end
    end
    
