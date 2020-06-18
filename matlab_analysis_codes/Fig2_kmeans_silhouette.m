%load x123, 5val_6inp_1


%%%%%%%%%%%%% this section is for silhouette plot of specific k-means clustering
xn123= normalize(x123)
kval=4 % the value of k-means clusters
kclust= kmeans(xn123,kval) 

 cmap = parula(kval); 
clf; hold on 
for i=1:kval
    k = find(kclust==i);
    hi= plot(x123(k,1), x123(k,2), 's', 'MarkerFaceColor',cmap(i,:));
    if i==1
        k1=k
    elseif i==2
        k2=k
    elseif i==3
        k3=k
    elseif i==4
        k4=k    
    end
end
% k1,2,3,4 store the index of points in x123 with respect to clusters
% add k5, k6 etc similarly for to store for more clusters 
legend(hi, {'c1' 'c2' 'c3' 'c4'})
hold off 

F= figure
[sil,sh]= silhouette(xn123,kclust)
hold on
silm= mean(sil)
xline(silm,'--',num2str(silm))
hold off


%%%%%%%% for getiing sttistics for k=2,10 and 15 replicates
% uncomment and run the below section seperately from the above section

% FinalDestinationStr= 'C:\Users\Durjay\Desktop\all_kmeans_plasticity_5val_3rep_1\' % replace this with appropriate folder location
% k= 10
% n= 15
% for i=2:k
%     cmap = parula(i);
%     mkdir([FinalDestinationStr,num2str(i)]);
%     for j=1:n
%         kclust= kmeans(xn123,i)
%         [sil,sh]= silhouette(xn123,kclust)
%         silmr(j,i)= mean(sil)
%         F=figure
%         clf; hold on 
%         for i1=1:i
%             k1 = find(kclust==i1);
%             hi= plot(x123(k1,1), x123(k1,2), 's', 'MarkerFaceColor',cmap(i1,:));
%             h(i1) = hi(1);  
%         end
%         hold off
%         DestinationFolderName = strcat(FinalDestinationStr,'\',num2str(i)); %'/' in mac and '\'in windows
%         outFileName = fullfile(DestinationFolderName,strcat('rep',num2str(j)))
%         saveas(F,outFileName,'png');
%         close all
%     end
%     silm(i)= mean(silmr(:,i))
%     silstd(i)= std(silmr(:,i))
% end
