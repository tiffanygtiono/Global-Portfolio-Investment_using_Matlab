%Homework 1

RI=RI(1:260,:);
R=(RI(2:end,:)-RI(1:end-1,:))./RI(1:end-1,:)
[T N]=size(R)

%1. Descriptive Data
for i=1:N,
    subplot (3,3,i)
    plot(R(:,i));
    set(gca,'Xlim',[1 length(Date)])
    title(Names(i)')
end

figure
for i=1:N,
    subplot(3,3,i)
    hist(R(:,i),15);
    title(Names(i)')
end

r=mean(R)

s=std(R)

skew=skewness(R)

kurt=kurtosis(R)

S=cov(R)

C=corrcoef(R)
