function  radC=dubinsRadHelper(ox,oy,xa,ya,xb,yb,R,rad,flag,~,width)%Բ�ġ���ʼ�㡢�е㡢�뾶��������0-��� 1-�յ�

%��ʼ��-Բ�ĵ�����
tx1=xa-ox;
ty1=ya-oy;
% a*b/[|a|*|b|]
%���ʼ��Բ�ĺ�X����н�(1,0)
p=(tx1*1+ty1*0)/(((tx1^2+ty1^2)^0.5)*((1^2+0^2)^0.5));
o=acos(p);
if(ty1<0)%���y����С��0 ��н�Ϊ��
    o=-o;
end
if(o<0)%�����Ƕ�ת��Ϊ���Ƕ�
    o=o+2*pi;
end

%�е�-Բ�ĵ�����
tx2=xb-ox;
ty2=yb-oy;
%���е�Բ�ĺ�X����н�(1,0)
% t=(tx1*tx2+ty1*ty2)/(((tx1^2+ty1^2)^0.5)*((tx2^2+ty2^2)^0.5));
t=(tx2*1+ty2*0)/(((tx2^2+ty2^2)^0.5)*((1^2+0^2)^0.5));
q=acos(t);
if(ty2<0)%���y����С��0 ��н�Ϊ��
    q=-q;
end
if(q<0)%�����Ƕ�ת��Ϊ���Ƕ�
    q=q+2*pi;
end

%Ч��Ƕȹ�ϵ������ֵ��0.01������ΪΪͬһ�Ƕȣ������ƻ���
if(o>=q)
    temp=o-q;
elseif(o<q)
    temp=q-o;
end

if(temp>0.01)
    %rad-���� o-��ʼ��-Բ�ĵ����� q-�е�-Բ�ĵ�����
    %ox,oy,xa,ya,xb,yb,R - Բ�ġ���ʼ�㡢�е㡢�뾶
    % 0-��� 1-�յ�
    if(flag==0)%��㣬˳�ų�ȥ
        if(0<=rad&&rad<=180)%��������
            if(ox>xa)%Բ�������ұߣ�˳Բ��o-q
                if(o>=q)%˵��0<q<o
                    dubinsCycleHelper(ox,oy,R,q,o,'-r',width);
                    radC=o-q;
                elseif(o<q)%˵��o<q<360
                    dubinsCycleHelper(ox,oy,R,0,o,'-r',width);
                    dubinsCycleHelper(ox,oy,R,q,2*pi,'-r',width);
                    radC=o+2*pi-q;
                end
            elseif(ox<xa)%Բ��������ߣ���Բ��o-q
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,0,q,'-r',width);
                    dubinsCycleHelper(ox,oy,R,o,2*pi,'-r',width);
                    radC=q+2*pi-o;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,o,q,'-r',width);
                    radC=q-o;
                end
            end
        elseif(180<rad&&rad<=360)%��������
            if(ox>xa)%Բ�������ұߣ���Բ��o-q
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,0,q,'-r',width);
                    dubinsCycleHelper(ox,oy,R,o,2*pi,'-r',width);
                    radC=q+2*pi-o;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,o,q,'-r',width);
                    radC=q-o;
                end
            elseif(ox<xa)%Բ��������ߣ�˳Բ��o-q
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,q,o,'-r',width);
                    radC=o-q;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,0,o,'-r',width);
                    dubinsCycleHelper(ox,oy,R,q,2*pi,'-r',width);
                    radC=o+2*pi-q;
                end
            end
        end
    elseif(flag==1)%�յ㣬˳�Ž���
        if(0<rad&&rad<=180)%��������
            if(ox>xa)%Բ�������ұߣ�˳Բ��q-o
                if(o>=q)%˵��0<q<o
                    dubinsCycleHelper(ox,oy,R,0,q,'-r',width);
                    dubinsCycleHelper(ox,oy,R,o,2*pi,'-r',width);
                    radC=q+2*pi-o;
                elseif(o<q)%˵��o<q<360
                    dubinsCycleHelper(ox,oy,R,o,q,'-r',width);
                    radC=q-o;
                end
            elseif(ox<xa)%Բ��������ߣ���Բ��q-o
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,q,o,'-r',width);
                    radC=o-q;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,0,o,'-r',width);
                    dubinsCycleHelper(ox,oy,R,q,2*pi,'-r',width);
                    radC=o+2*pi-q;
                end
            end
        elseif(180<rad&&rad<=360||rad==0)%��������
            if(ox>xa)%Բ�������ұߣ���Բ��q-o
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,q,o,'-r',width);
                    radC=o-q;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,0,o,'-r',width);
                    dubinsCycleHelper(ox,oy,R,q,2*pi,'-r',width);
                    radC=o+2*pi-q;
                end
            elseif(ox<xa)%Բ��������ߣ�˳Բ��q-o
                if(o>=q)%
                    dubinsCycleHelper(ox,oy,R,0,q,'-r',width);
                    dubinsCycleHelper(ox,oy,R,o,2*pi,'-r',width);
                    radC=q+2*pi-o;
                elseif(o<q)%
                    dubinsCycleHelper(ox,oy,R,o,q,'-r',width);
                    radC=q-o;
                end
            end
        end
    end
end

end