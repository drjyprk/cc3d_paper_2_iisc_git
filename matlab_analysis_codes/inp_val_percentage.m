%k=k1
%clear inTc1
%each input variables are in each column of any matrix
range(:,1)=[2.0,4.0,6.0,8.0,10.0]
range(:,2)=[0.0,0.25,0.5,0.75,1.0]
range(:,3)=[4,18,32,46,60]
range(:,4)=[4,18,32,46,60]
range(:,5)=[4,18,32,46,60]
range(:,6)=[0.005,0.01,0.025,0.04,0.055]
F1=figure
kclust= kmeans(xn123,3)
cmap = parula(3);
clf; hold on
for i=1:3
    clear inTc1
    k = find(kclust==i);
    hi= plot(x123(k,1), x123(k,2), 's', 'MarkerFaceColor',cmap(i,:));
    h(i) = hi(1);
    for i1=1:length(k)
        i2=k(i1)
        inTc1(i1,:)=ix123(i2,:)
    end
    field= strcat("cluster",num2str(i))
    s{i}=struct(field, inTc1)
end
legend(h, {'c1' 'c2' 'c3'})
hold off
variables= numel(ix123)/length(ix123)
for i=1:length(s)
    field= convertStringsToChars(strcat("cluster",num2str(i)))
    cdatatemp= s{1,i}.(field)
    for i1=1:variables
        clear vararr
        vararr= cdatatemp(:,i1)
        for i2=1:length(range(:,i1)) %for values in variables
            kvar = find(vararr==range(i2,i1))
            clustdata(i2,i1) = length(kvar)/length(vararr)
        end
    end
    sc{i}= struct(field, clustdata)
end
%creating tables
for i= 1:variables
    field= strcat("inpvar",num2str(i))
    clear allcvar
    for i1=1:length(sc)
        cname= convertStringsToChars(strcat("cluster",num2str(i1)))
        allcvar(:,i1)= sc{1,i1}.(cname)(:,i)
    end
        varmaindata{i}=struct(field,allcvar)
        vartable= array2table(allcvar,'VariableNames',{'Feet','Inches','Centimeters'})
        writetable(vartable,fullfile('C:\Users\durja\Desktop\temp',strcat('table',num2str(i),'.csv')));
end