% to find simulation screenshot from parameter scan folder
%load x123, 5_val_T123_mm_do_mincircle
xn123= normalise(x123)
kclust= kmeans(xn123,3)
cmap = parula(3); 

cindx=[]
for i=1:length(x123)
if x123(i,1)>14000 && x123(i,1)<16000 && x123(i,2)>20 && x123(i,2)<25 %selecting the search region of the phenospace
cindx(end+1)= i
end
end

anyindx= cindx(1) 
for i=1:length(T1)
    if T1(1,i)== x123(anyindx,1) && T1(2,i)== x123(anyindx,2)
        mainindx1= i-1 %actual index
        break
    end
end



%%%%%%%%%%%%%%%%%%%% please replace 'parameterscan/directory/location' with
%%%%%%%%%%%%%%%%%%%% actual CC3D parameterscan directory location
strimg= (strcat('C:\Users\Durjay\CC3DWorkspace\cancol2_GFattr_1\',num2str(mainindx1),'\Cell_Field_CellField_2D_XY_0\Cell_Field_CellField_2D_XY_0_1500.png'))
% replace the first string in the above line with location of the folder from parameter scan
img= imread(strimg)
F1=figure
clf;
hold on
for i=1:3
k = find(kclust==i);
hi= plot(x123(k,1), x123(k,2), 's', 'MarkerFaceColor',cmap(i,:));
h(i) = hi(1);
end
% legend(h, {'c1' 'c2' 'c3'})
scatter((x123(anyindx,1)),(x123(anyindx,2)),100,'r','filled')
hold off
ax1 = gca; % get handle to axes of figure
F2=figure
imshow(img);
ax2 = gca;
h3 = figure; %create new figure
s1 = subplot(2,1,1); %create and get handle to the subplot axes
s2 = subplot(2,1,2);
fig1 = get(ax1,'children'); %get handle to all the children in the figure
fig2 = get(ax2,'children');
copyobj(fig1,s1); %copy children to new parent axes i.e. the subplot axes
copyobj(fig2,s2);
