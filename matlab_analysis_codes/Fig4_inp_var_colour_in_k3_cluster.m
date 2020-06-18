%%%%%%%%%%%%%%%%%%%%%color coding of points based on input variable values
%load 5val_x123, 5val_ix123

inp=1 % column number of intended input variable in ix123

range(:,1)=[2.0,4.0,6.0,8.0,10.0]
range(:,2)=[0.0,0.25,0.5,0.75,1.0]
range(:,3)=[4,18,32,46,60]
range(:,4)=[4,18,32,46,60]
range(:,5)=[4,18,32,46,60]
range(:,6)=[0.005,0.01,0.025,0.04,0.055]

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

% separating line for k=3 of dataset 5val_3rep
plot([82 3083 12090 18870 25750],[60 59 57 81 105],'k','LineWidth',2)
hold on
plot([12090 14770],[57 1],'k','LineWidth',2)
hold off