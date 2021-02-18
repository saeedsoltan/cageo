function Network2 = ConsNet_Fcn(Network,X)
%%
IW = Network.IW{1,1}; IW_Num = numel(IW);
LW1 = Network.LW{2,1}; LW1_Num = numel(LW1);
LW2 = Network.LW{3,2}; LW2_Num = numel(LW2);
LW3 = Network.LW{4,3}; LW3_Num = numel(LW3);
b1 = Network.b{1,1}; b1_Num = numel(b1);
b2 = Network.b{2,1}; b2_Num = numel(b2);
b3 = Network.b{3,1}; b3_Num = numel(b3);
b4 = Network.b{4,1}; b4_Num = numel(b4);


IWs = X(1:IW_Num); IW = reshape(IWs,size(IW,1),size(IW,2),size(IW,3),size(IW,4));
LW1s = X(IW_Num+1:IW_Num+LW1_Num);  LW1 = reshape(LW1s,size(LW1,1),size(LW1,2),size(LW1,3),size(LW1,4));
LW2s = X(IW_Num+LW1_Num+1:IW_Num+LW1_Num+LW2_Num); LW2 = reshape(LW2s,size(LW2,1),size(LW2,2),size(LW2,3),size(LW2,4));
LW3s = X(IW_Num+LW1_Num+LW2_Num+1:IW_Num+LW1_Num+LW2_Num+LW3_Num); LW3 = reshape(LW3s,size(LW3,1),size(LW3,2),size(LW3,3),size(LW3,4));
b1s = X(IW_Num+LW1_Num+LW2_Num+LW3_Num+1:IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num); b1 = reshape(b1s,size(b1,1),size(b1,2),size(b1,3),size(b1,4));
b2s = X(IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+1:IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+b2_Num); b2 = reshape(b2s,size(b2,1),size(b2,2),size(b2,3),size(b2,4));
b3s = X(IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+b2_Num+1:IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+b2_Num+b3_Num); b3 = reshape(b3s,size(b3,1),size(b3,2),size(b3,3),size(b3,4));
b4s = X(IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+b2_Num+b3_Num+1:IW_Num+LW1_Num+LW2_Num+LW3_Num+b1_Num+b2_Num+b3_Num+b4_Num); b4 = reshape(b4s,size(b4,1),size(b4,2),size(b4,3),size(b4,4));

Network2 = Network;

Network2.IW{1,1} = IW;
Network2.LW{2,1} = LW1;
Network2.LW{3,2} = LW2;
Network2.LW{4,3} = LW3;
Network2.b{1,1} = b1;
Network2.b{2,1} = b2;
Network2.b{3,1} = b3;
Network2.b{4,1} = b4;

end