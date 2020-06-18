
%%%%%%%%%%%%%%%%%%%%%color coding of points based on input variable values

inp=1
v1= range(1,inp)
v2= range(2,inp)
v3= range(3,inp)
v4= range(4,inp)
v5= range(5,inp)
    
c1x=[]
c1y=[]
ic1=[]
ic2=[]
ic3=[]
ic4=[]
ic5=[]
ic6=[]
ic7=[]
ic8=[]
for i=1:length(x123)
    if ix123(i,inp)==v1
        c1x(end+1)= x123(i,1)
        c1y(end+1)= x123(i,2)
    elseif ix123(i,inp)==v2
        ic1(end+1)= x123(i,1)
        ic2(end+1)= x123(i,2)
    elseif ix123(i,inp)==v3
        ic3(end+1)= x123(i,1)
        ic4(end+1)= x123(i,2)
    elseif ix123(i,inp)==v4
        ic5(end+1)= x123(i,1)
        ic6(end+1)= x123(i,2)
    elseif ix123(i,inp)==v5
        ic7(end+1)= x123(i,1)
        ic8(end+1)= x123(i,2)
    end
end
scatter(c1x,c1y,7,'g','filled')
hold on
scatter(ic1,ic2,7,'g','filled')
hold on
scatter(ic3,ic4,7,'b','filled')
hold on
scatter(ic5,ic6,7,'r','filled')
hold on
scatter(ic7,ic8,7,'r','filled')
legend(num2str(v1),num2str(v2),num2str(v3),num2str(v4),num2str(v5))

% separating line for for k=3 of dataset 5val_3rep
plot([82 3083 12090 18870 25750],[60 59 57 81 105],'k','LineWidth',2)
hold on
plot([12090 14770],[57 1],'k','LineWidth',2)
hold off





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%extracting data from simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%folders and processed folder

subf = uigetdir
subf_inDir1 = dir(subf); %2nd subfolders
subf_inDir1 = subf_inDir1(~ismember({subf_inDir1.name},{'.','..','.DS_Store'}));
nrmf = size(subf_inDir1,1);
for i=1:length(subf_inDir1)
subf_inDir1(i).name=str2num(subf_inDir1(i).name)
end
subf_inDir2= struct2table(subf_inDir1)
subf_inDir= sortrows(subf_inDir2)
for i = 1:nrmf
tname = strcat(subf_inDir.folder(i),'\',num2str(subf_inDir.name(i)),'\processed\table.csv');
table = readtable(tname{1,1});
Ttemp= table2array(table)
%j2= subf_inDir.name(col)
%ki = mod(j2,10) + 1  %because there are 10 folders in one paramScan replicate
%quot= fix(j2/10);
T1(1,i)= Ttemp(height(table),7)
%T1.Properties.VariableNames{col} = strcat('val',num2str(ki*mf),'r',num2str(i))
T1(2,i)= Ttemp(height(table),4)
%T1.Properties.VariableNames{col} = strcat('val',num2str(ki*mf),'r',num2str(i))
T1(3,i)= Ttemp(height(table),2)
end
phnoTx= T1(1,:)
phnoTy= T1(2,:)
scatter(phnoTx,phnoTy,10,'filled')


paramname = strcat(subf_inDir.folder(1),'\',num2str(subf_inDir.name(1)),'\Simulation\ParameterScanSpecs.xml');
Fid= fopen(paramname{1,1})
a= textscan(Fid,'%s')
fclo0= fclose(Fid)
rangestr1= a{1,1}{11,1}
rangestr2= a{1,1}{18,1}
rangestr3= a{1,1}{29,1}
rangestr4= a{1,1}{37,1}
rangestr5= a{1,1}{45,1}
rangestr6= a{1,1}{53,1}
rangestr1= rangestr1(9:(length(rangestr1)-9))
rangestr2= rangestr2(9:(length(rangestr2)-9))
rangestr3= rangestr3(9:(length(rangestr3)-9))
rangestr4= rangestr4(9:(length(rangestr4)-9))
rangestr5= rangestr5(9:(length(rangestr5)-9))
rangestr6= rangestr6(9:(length(rangestr6)-9))
range1=sscanf(rangestr1,strcat("%f",","))
range2=sscanf(rangestr2,strcat("%f",","))
range3=sscanf(rangestr3,strcat("%f",","))
range4=sscanf(rangestr4,strcat("%f",","))
range5=sscanf(rangestr5,strcat("%f",","))
range6=sscanf(rangestr6,strcat("%f",","))
for i3=1:nrmf
    paramname = strcat(subf_inDir.folder(i3),'\',num2str(subf_inDir.name(i3)),'\Simulation\ParameterScanSpecs.xml');
    Fid1= fopen(paramname{1,1})
    ait= textscan(Fid1,'%s')
    fclo1= fclose(Fid1)
    it1a= ait{1,1}{7,1}
    it2a= ait{1,1}{14,1}
    it3a= ait{1,1}{24,1}
    it4a= ait{1,1}{32,1}
    it5a= ait{1,1}{40,1}
    it6a= ait{1,1}{48,1}
    it1a= it1a(19:(length(it1a)-1))
    it2a= it2a(19:(length(it2a)-1))
    it3a= it3a(19:(length(it3a)-1))
    it4a= it4a(19:(length(it4a)-1))
    it5a= it5a(19:(length(it5a)-1))
    it6a= it6a(19:(length(it6a)-1))
    it1=sscanf(it1a,strcat("%f"))
    it2=sscanf(it2a,strcat("%f"))
    it3=sscanf(it3a,strcat("%f"))
    it4=sscanf(it4a,strcat("%f"))
    it5=sscanf(it5a,strcat("%f"))
    it6=sscanf(it6a,strcat("%f"))
    inT1(1,i3+lasts)= range1(it1+1)
    inT1(2,i3+lasts)= range2(it2+1)
    inT1(3,i3+lasts)= range3(it3+1)
    inT1(4,i3+lasts)= range4(it4+1)
    inT1(5,i3+lasts)= range5(it5+1)
    inT1(6,i3+lasts)= range6(it6+1)
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% for selecting patches from phenospace
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% for checking k means validity with
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% different pattern
c1x=[]
c1y=[]
for i=1:length(x12)
if (x12(i,1)<1000 && x12(i,2)>30) || (x12(i,1)>12000 && x12(i,2)<30) || (x12(i,1)>4000 && x12(i,1)<8000 &&x12(i,2)>40 && x12(i,2)<80)
c1x(end+1)= x12(i,1)
c1y(end+1)= x12(i,2)
end
end
x= [c1x' c1y']
xn=normalize(x)
kclust= kmeans(xn,3)
cmap = parula(3);
clf; hold on
for i=1:3
k = find(kclust==i);
hi= plot(x(k,1), x(k,2), 's', 'MarkerFaceColor',cmap(i,:));
h(i) = hi(1);
end
legend(h, {'c1' 'c2' 'c3'})




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% min enc. circle
%%%%% 
ic1=[]
ic2=[]
ic3=[]
ic4=[]
ic5=[]
ic6=[]
cminenc=[]
for i=1:length(k1) %change k1
    i1=k1(i) %change k1
    cminenc(end+1)=c1x(i1)
    if c1x(i1)<=c
        ic1(end+1)= x123(i1,1)
        ic2(end+1)= x123(i1,2)
    elseif c1x(i1)>c && c1x(i1)<c1
        ic3(end+1)= x123(i1,1)
        ic4(end+1)= x123(i1,2)
    elseif c1x(i1)>=c1
        ic5(end+1)= x123(i1,1)
        ic6(end+1)= x123(i1,2)
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% getting index of poins from each cluster
kclust= kmeans(xn12,3)
cmap = parula(3);
clf; hold on
for i=1:3
k = find(kclust==i);
hi= plot(x12(k,1), x12(k,2), 's', 'MarkerFaceColor',cmap(i,:));
h(i) = hi(1);
if i==1
k1=k
elseif i==2
k2=k
elseif i==3
k3=k
end
end
legend(h, {'c1' 'c2' 'c3'})
hold off