% to have transition from one of the K(=3)-means clusters by input variable change

%%%%%%%%%%%%%% run this part only once to have consistent clusters for subsequent runs
% xn123= normalize(x123)
% kclust= kmeans(xn123,3)
% cmap = parula(3);
% clf; hold on
% for i=1:3
%     k = find(kclust==i);
%     hi= plot(x123(k,1), x123(k,2), 's', 'MarkerFaceColor',cmap(i,:));
%     h(i) = hi(1);
%     if i==1
%         k1=k
%     elseif i==2
%         k2=k
%     elseif i==3
%         k3=k
%     end
% end 
% legend(h, {'c1' 'c2' 'c3'})
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
inp=4 % the column number of input variable in ix123
kmain=k1 % select the specific k=3's cluster here
inTc1=[]
ksrc=[]
for i=1:length(kmain)
    if ix123(kmain(i),inp)== 4 || ix123(kmain(i),inp)== 18 % set the initial values of the input variable here
        inTc1(end+1,:)=ix123(kmain(i),:)
        ksrc(end+1)=kmain(i)
    end
end

% changing the input variable values
inTc1(:,inp)= max(ix123(:,inp)) % maximizing or minimizing depending on the initial set values

bin1=[]
bin2=[]
bin3=[]
for i=1:length(inTc1)
    templogical= ismember(ix123,inTc1(i,:),'rows')
    rep = find(templogical)
    for i1=1:length(rep)
        transindx(i,i1)=rep(i1)
        if find(k1==transindx(i,i1))
            bin1(end+1)= find(k1==transindx(i,i1))
        end
        if find(k2==transindx(i,i1))
            bin2(end+1)= find(k2==transindx(i,i1))
        end
        if find(k3==transindx(i,i1))            
            bin3(end+1)= find(k3==transindx(i,i1))
        end
    end
end
F1= figure
pieX= [length(bin1) length(bin2) length(bin3)]
labels={'C1:indolent','C2:collective','C3:disperse'} % set it according to however 3 clusters come in K=3-means
explode=[0 0 0]
pie(pieX)
legend(labels)
title('indolent-4-18-to-C-C-CE-max') % change it according to configuration

clear xsrc
for i=1:length(ksrc)
    xsrc(i,:)=x123(ksrc(i),:)
end
xtrgt=[]
for i=1:length(bin1)
    xtrgt(end+1,:)=x123(k1(bin1(i)),:)
end
for i=1:length(bin2)
    xtrgt(end+1,:)=x123(k2(bin2(i)),:)
end

for i=1:length(bin3)
    xtrgt(end+1,:)=x123(k3(bin3(i)),:)
end

F2=figure
scatter(xsrc(:,1),xsrc(:,2),7,'g','filled')
hold on
scatter(xtrgt(:,1),xtrgt(:,2),7,'r','filled')
hold on
plot([82 3083 12090 18870 25750],[60 59 57 81 105],'k','LineWidth',2)
hold on
plot([12090 14770],[57 1],'k','LineWidth',2)
hold off