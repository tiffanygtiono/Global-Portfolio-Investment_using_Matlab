% HW 2 SECTION 1
load HW1.mat
RI=RI(1:241,:);
A=5
Rf=0.0005

%Plot all portfolios in a Mean-Variance framework

R=(RI(2:end,:)-RI(1:end-1,:))./RI(1:end-1,:)
[T N]=size(R)
r=mean(R(:,1:9))'   
s=std(R(:,1:9))'    
S=cov(R(:,1:9));   
plot(s,r,'x','Linewidth',9) 

for i=1:N,
    text(s(i)+0.002,r(i),Names(i));
end;

hold on

%the utility of the investor from holding each industry portfolio 

U=r-0.5*A*s.^2 
sig=[0:0.001:max(s)*1.2]';
Er=max(U)+0.5*5*sig.^2;    %A=5 
line(sig,Er,'Linewidth',2,'Color','r')

%Which portfolio would this investor prefer
maxU1=max(U)

hold on

%SECTION 2 
SR=(r-Rf)./s
MaxVal=find(SR==max(SR))
Names(find(SR==max(SR)))

%Risk-Free Rate Included
y=[0:0.001:2]';
r_port=r(MaxVal)*y+Rf*(1-y);
s_port=y*s(MaxVal);
line(s_port,r_port,'Linewidth',2,'Color','b')

% Finding the maximum utility portfolio numerically
r_p=r(MaxVal)*y+Rf*(1-y);
U_maximum=r_p-0.5*A*s_port.^2;
maxU2=max(U_maximum)
best_port=find(U_maximum==max(U_maximum))
best_Value_y=y(best_port)

% Optimal indifference curves for A=5 
hold on
Er_1=maxU2+0.5*A*s_port.^2;    
line(s_port,Er_1,'Linewidth',2,'Color','g')
line(s_port(best_port),Er_1(best_port),'marker','d','Linewidth',2,'color','k')

save HW2.mat

%SECTION 3

%Efficient frontier with portfolios
hold off 

r=mean(R(:,1:9))'  
s=std(R(:,1:9))'    
plot(s,r,'x','Linewidth',9) 

for i=1:N,
    text(s(i)+0.002,r(i),Names(i));
end;

S=cov(R(:,1:9));   

hold on 

p = Portfolio;
p = setAssetMoments(p, r, S);
p = setDefaultConstraints(p);

w_p = estimateFrontier(p, 100);

[s_p, r_p] = estimatePortMoments(p, w_p); 

plot(s_p,r_p,'color','r','Linewidth',2)                

[s_p,r_p]=plotFrontier(p, 100); 

%the optimal portfolio for the investor (the one with the highest utility) and report
%its weights
w_p=w_p';
PortReturn=r_p;
PortRisk=s_p;
PortWeights=w_p;

U_efficient=PortReturn-0.5*A*PortRisk.^2;

find(U_efficient==max(U_efficient))
PortWeights(U_efficient==max(U_efficient),:)

%max utility of the investor at this optimal portfolio

maxU3=max(U_efficient)
best_portfolio_efficient=find(U_efficient==max(U_efficient))

%Plot the indifference curve across the optimal portfolio

hold on 

Er_2=maxU3+0.5*A*PortRisk.^2;    
line(PortRisk,Er_2,'Linewidth',2,'Color','g')
line(PortRisk(best_portfolio_efficient),Er_2(best_portfolio_efficient),'marker','d','Linewidth',2,'color','m')

save HW2.mat

%SECTION 4

%Plot the new efficient frontier with the risk free rate based on the portfolios
hold off

portalloc(s_p,r_p,w_p,Rf,Rf,A);

hold on 

plot(s_p,r_p,'Color','r','Linewidth',2)

plot(s,r,'x','Linewidth',9) 
for i=1:N,
    text(s(i)+0.002,r(i),Names(i));
end;

%the weights of the different industries in the optimal “RISKY” portfolio
%the return and standard deviation of the optimal RISKY portfolio

[RiskyRisk,RiskyReturn,RiskyWts,RiskyFraction,OverallRisk,...
        OverallReturn] = portalloc(s_p,r_p,w_p,Rf,Rf,A)
    
% the utility of the investor at this optimal overall portfolio
U_Opt_PortOverall=OverallReturn-0.5*A*OverallRisk.^2
