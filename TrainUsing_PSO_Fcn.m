function [Network2  BestCost] = TrainUsing_PSO_Fcn(Network,Xtr,Ytr)

%% Problem Statement
IW = Network.IW{1,1}; IW_Num = numel(IW);
LW1 = Network.LW{2,1}; LW1_Num = numel(LW1);
LW2 = Network.LW{3,2}; LW2_Num = numel(LW2);
LW3 = Network.LW{4,3}; LW3_Num = numel(LW3);

b1 = Network.b{1,1}; b1_Num = numel(b1);
b2 = Network.b{2,1}; b2_Num = numel(b2);
b3 = Network.b{3,1}; b3_Num = numel(b3);
b4 = Network.b{4,1}; b4_Num = numel(b4);

TotalNum = IW_Num + LW1_Num + LW2_Num + LW3_Num + b1_Num + b2_Num + b3_Num + b4_Num;


NPar = TotalNum;
VarSize=[1,NPar];


VarMin = -1*ones(1,TotalNum);
VarMax = +1*ones(1,TotalNum);

CostFuncName = 'Cost_ANN_EA';

%% Problems of PSO
MaxIt=1000;          %Maximum Number of iteration
nPop=300;          %population size  (Sworm size)
w=0.7298;         %Inertia Coefficient  0.7298
wdamp=0.9;      %damping ratio of inertia coefficient
c1=1.8 ;         % Personal Acceleration coefficient  1.4962 
c2=1.8;           % Social Acceleration coefficient
%Initialization

% the particle Templet
empty_particle.Position=[];
empty_particle.Velocity=[];
empty_particle.Cost=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];
%Create Population Array
particle=repmat(empty_particle,nPop,1);


%Initialize globale best
%GlobalBest.Position=[];
GlobalBest.Cost=inf;  %for maximizasion (-inf)
GlobalBest.Position = []; %%%%%%%
GlobalBest.CostMAT = []; %%%%%%%%%%%%

%Initialize Population Members
for i=1:nPop
    
    %Generate random solution
  particle(i).Position=unifrnd(VarMin,VarMax, VarSize);
    %Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
   % Evaluation
      %%%%%particle(i).Cost=CostFuncName(particle(i).Position);
          particle(i).Cost = feval(CostFuncName,particle(i).Position,Xtr,Ytr,Network);             %%%%%%%%%%%%%%

   %Update the personal best
      particle(i).Best.Position=particle(i).Position;
      particle(i).Best.Cost=particle(i).Cost;

     %Update the global best
   
   if particle(i).Best.Cost<GlobalBest.Cost
       %GlobalBest=particle(i).Best;%%%
       GlobalBest.Cost = particle(i).Best.Cost;
       GlobalBest.Position = particle(i).Best.Position;
       
       %GlobalBest.Cost=Particle(i).Best.Cost;
   end
   
end
% Array to hold best cost value on each iteration
BestCost=zeros(MaxIt,1)


%% Main Loop
for it=1:MaxIt
   for i=1:nPop
       
       %update velocity
      particle(i).Velocity=w*particle(i).Velocity...
                            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position)...
                            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
        %update position               
      particle(i).Position=particle(i).Position+particle(i).Velocity;
      %evaluation
      
      particle(i).Position = max(particle(i).Position , VarMin);
      particle(i).Position = min(particle(i).Position , VarMax);
            %%%%%particle(i).Cost=CostFuncName(particle(i).Position);
                particle(i).Cost = feval(CostFuncName,particle(i).Position,Xtr,Ytr,Network);             %%%%%%%%%%%%%


 
      %update personal best
      if particle(i).Cost<particle(i).Best.Cost
          particle(i).Best.Position=particle(i).Position;
          particle(i).Best.Cost=particle(i).Cost;
          %update global best
      if particle(i).Best.Cost<GlobalBest.Cost
          %GlobalBest=particle(i).Best;
                GlobalBest.Cost = particle(i).Best.Cost;   %%%%%%%%%%%%
            GlobalBest.Position = particle(i).Best.Position;%%%%%%%%%%
   
      end
      end
       
   end
   %store the best cost value
% BestCost(it)=GlobalBest.Cost;
 %display iteration information
 %disp(['Iteration: ' num2str(it) ' BestCost: ' num2str(BestCost(it))]) 
     %damping intertia coefficient

 %% Display
    disp(['Itretion = ' num2str(it) '; Best Cost = ' num2str(GlobalBest.Cost) ';'])
    GlobalBest.CostMAT = [GlobalBest.CostMAT GlobalBest.Cost];
        w=w*wdamp;

end

GlobalBest.Position
plot(GlobalBest.CostMAT)
Network2 = ConsNet_Fcn(Network,GlobalBest.Position);
BestCost = GlobalBest.Cost;

end
