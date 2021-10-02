load 'HW1.mat'
RI=RI(241:261,:);
R=(RI(2:end,:)-RI(1:end-1,:))./RI(1:end-1,:)
[T N]=size(R)
Rf=0.001
EqualWts=ones(1,N)/N;
B=(EqualWts*R')';
P=(RiskyWts*R')'; %RiskyFraction

%using fitlm
rm=mean([P B])
st=std([P B])
SR=[mean([P B]-Rf)./std([P B])]
rs=fitlm(B-Rf,P-Rf)
se=[std(rs.Residuals.Raw)]
b=rs.Coefficients.Estimate(2)
TM=[mean([P B]-Rf)./[b(1) 1]]
a=rs.Coefficients.Estimate(1)
AR=[a/se]



