% pca of k-means clusters

%load x123, ix123
%%%%%%%%%%%%%% uncomment and run this part only once 
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
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


ixn123= normalize(ix123)
kmain= k1 % change the clusters here
clear inTc1
for i=1:length(kmain) 
    inTc1(i,:)=ixn123(kmain(i),:)
end


[coeff,scores,~,~,explained]= pca(inTc1,'Algorithm','eig')
PCFigure= figure
subplot(2,2,[1 2])
x= scores(:,1)
y= scores(:,2)
z= scores(:,3)
scatter3(x,y,z,10,'filled')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
subplot(2,2,3)
bar(explained)
title('scree plot')
subplot(2,2,4)
ybarcoeff(1,:)=coeff(:,1)
ybarcoeff(2,:)=coeff(:,2)
ybarcoeff(3,:)=coeff(:,3)
bar(ybarcoeff)
xticklabels({'PC1','PC2','PC3'})
legend({'RD-co-op','cell-growth','C1-C-adh','C-C-adh','C-lam-adh','MMP-difC'})
title('variable coeff.');