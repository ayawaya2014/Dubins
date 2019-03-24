function [J,ind,distn] = obstacleFunction(Target,Robot,TargetV,RobotV,Obstacle,ObstacleR,monitor,max,maxDis,turnR,flag)
%����ԭ������������
[J,ind,distn] = distanceFunction(Target,Robot); 
% 1 = ii;
Nm = ind; 
% ȡ�û�ʤ��Ԫ
winnerR = Robot(:,Nm); 
winnerT = Target;

%�Ի�ʤ��Ԫ����Ч�飨����ѭ��+������
Mat = size(Obstacle); 
ObstacleNum = Mat(1,2);
for i=1:ObstacleNum%���ϰ�����Ϊѭ������+�������ж�
    
    if(monitor(1,Nm)==max||monitor(1,Nm)>maxDis)
        Robot(:,Nm)=9999999;%���������޴�
        [J,ind,distn] = obstacleFunction(Target,Robot,TargetV,RobotV,Obstacle,ObstacleR,monitor,max,maxDis,turnR,flag);
    end
    
    %ֱ�����ϰ����жϺ��������ظ�����˵���ϰ�����ֱ���н���
    if(flag==0)%ֱ��ģʽ��ֱ��ʹ��ֱ�߹�ʽ�ж��ϰ����ֱ�߹�ϵ obstacleLineFunction(x1,y1,x2,y2,Obstacle,ObstacleR)
        oxflag = obstacleLineFunction(winnerR(1,1),winnerR(2,1),winnerT(1,1),winnerT(2,1),Obstacle(:,i),ObstacleR);
    elseif(flag==1)%dubins·������������������ص�ֱ�������ٽ����ж�
        
        %����dubins���㺯������������е����ֱ���ϰ����ж�
        %[xa,ya,xb,yb] = dubinsCalculateFunction(R,x0,y0,phi1,a0,b0,theta1)
            [xa,ya,xb,yb] = dubinsCalculateFunction(turnR,winnerR(1,1),winnerR(2,1),RobotV(2,Nm),winnerT(1,1),winnerT(2,1),TargetV(2,1));
        %�����ж�������Ƿ��ܹ���dubins·������Ϊ����ֱ�߾����������ת��뾶��turnR��
        dis=((winnerR(1,1)-winnerT(1,1))^2+(winnerR(2,1)-winnerT(2,1))^2)^0.5;
        %������һ��ʱ�����Բ���������ת��뾶
        if(dis<2*turnR)
            Robot(:,Nm)=9999999;%���������޴�
            [J,ind,distn] = obstacleFunction(Target,Robot,TargetV,RobotV,Obstacle,ObstacleR,monitor,max,maxDis,turnR,flag);
        end
        oxflag = obstacleLineFunction(xa,ya,xb,yb,Obstacle(:,i),ObstacleR);
    end
    
    if(oxflag < 0)
        Robot(:,Nm)=9999999;%���������޴�
        [J,ind,distn] = obstacleFunction(Target,Robot,TargetV,RobotV,Obstacle,ObstacleR,monitor,max,maxDis,turnR,flag);
    end
    
end
    
end



           
            
