function oxflag = obstacleLineFunction(x1,y1,x2,y2,Obstacle,ObstacleR)
    
    oxflag=1;%�ȸ�����ֵ
    %��ȡ�ϰ������귶Χ��ֵ
    Oxmin=Obstacle(1,1)-ObstacleR;
    Oxmax=Obstacle(1,1)+ObstacleR;
    Oy=Obstacle(2,1);

%-----------------------ֱ�ߵļ��㹫ʽ �����ж��ϰ���-----------------------%
                     %���ж�yֵ�Ƿ��ڻ����˺�Ŀ���֮��
                   %���ж�xֵ�Ƿ���Ŀ��ֱ�ߵ����ˣ��˻���0
            if(((Oy-y1)*(Oy-y2))<=0)
                if(x1 ~= x2)%x������k
                    if(x1<x2)
                        x=x1:0.1:x2;
                    elseif(x1>x2)
                        x=x2:0.1:x1;
                    end
                    k=(y1-y2)/(x1-x2);
                    b=y1-k.*x1;
                    %��ȡ���������ֵ
                    Ox=(Oy-b)/k;
                    oxflag=(Ox-Oxmin)*(Ox-Oxmax);%��С��0���赲·����Ҫ���¼���
    %                 y=k.*x+b;
    %                 plot(x,y);
                end
                if(x1 == x2)
                    if(y1<=y2)
                        y=y2:0.1:y1;
                    elseif(y1>y2)
                        y=y1:0.1:y2;
                    end
                    x=x1;
                    oxflag=(x-Oxmin)*(x-Oxmax);%��С��0���赲·����Ҫ���¼���
    %                 plot(x,y);
                end
            end
%-------------------------------------------------------------------------%
    
    
end



           
            
