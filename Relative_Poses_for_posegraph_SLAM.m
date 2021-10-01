Z_State = State.Ekf.PG;
Z_StateN = Z_State(1:3,1);
ID_P_O=1;
for i =1:nSteps-1
%     LM = Z_State(ID_P_O+3:IP_P_N-3,1);
    
    IP_P_N = find(State.Ekf.PG(:,4)==i,1,'last');
    Z_StateN(ID_P_O+3:2:IP_P_N-3,1)=-Z_State(ID_P_O,1)+Z_State(ID_P_O+3:2:IP_P_N-3,1);
    Z_StateN(ID_P_O+4:2:IP_P_N-3,1)=-Z_State(ID_P_O+1,1)+Z_State(ID_P_O+4:2:IP_P_N-3,1);
%     LM(5:2:end,1:2:3)=[NState(2,1)-NState(5:2:end,1) (1:NoLM)']
%     temp(4:end,4) = k;
    
    Relative_Pose = [-Z_State(ID_P_O,1)+Z_State(IP_P_N-2,1);-Z_State(ID_P_O+1,1)+Z_State(IP_P_N-1,1);...
        -Z_State(ID_P_O+2,1)+Z_State(IP_P_N,1)];
    Z_StateN(IP_P_N-2:IP_P_N,1)=Relative_Pose;
    ID_P_O=IP_P_N-2;
    if i==nSteps-1
        Z_StateN(ID_P_O+3:2:length(Z_State),1)=Z_State(ID_P_O,1)-Z_State(ID_P_O+3:2:length(Z_State),1);
        Z_StateN(ID_P_O+4:2:length(Z_State),1)=Z_State(ID_P_O+1,1)-Z_State(ID_P_O+4:2:length(Z_State),1);
        
        
    end
    
end
% Z_StateN(ID_P_O+3:length(Z_State),1)=Z_State(ID_P_O+3:end,1);
Z_StateN(:,2:4)=Z_State(:,2:4);