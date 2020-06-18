%for analysing simulation screenshots


%function Func1 = P2_1_sdist(input) %uncomment to run as function in
%different code, don't forget to uncomment the end for this fn

input = uigetdir %uncomment to run this code, select simulation screenshots containing folder
ans= batchcreateMask(input)
nrows = size(ans,1);
for i = 1:nrows
    image = ans.output{i,1};
    str = ans.fileName{i};
    a = regionprops(image,'area');
    area = cat(1,a.Area);
    S = sum(area);
    c = regionprops(image,'centroid');
    e = regionprops(image,'Extrema');
    centroids = cat(1,c.Centroid);
    extrema= cat(1,e.Extrema)
    %imshow(image);
    pointsX = extrema(:,1);
    pointsY = extrema(:,2);
    
    [iX iY NoOfColorChannel] = size(image);
    textPosition = [10 10];
    P0 = [iX/2 iY/2];
    [P, radiusMin] = fminsearch(@(P) radiusFromPoint(P,pointsX,pointsY), P0);
    [xx,yy]= meshgrid(1:iX, 1:iY)
    mask= hypot(P(1)-xx, P(2)-yy) <=radiusMin
    circleArea = length(nonzeros(mask));
    AllS(i) = circleArea;
    Tempk = str((length(str)-6):(length(str)-4));
    k(i) = str2num(Tempk);
    
    %surface
    se = strel('diamond',1.0);
    s1 = imdilate(image,se);

    s2 = imfill(s1,'holes');

    s3 = bwperim(s2,8);
    s4 = bwpropfilt(s3,'perimeter',1);
    e2= regionprops(s4,'Extrema');
    extrema2= cat(1,e2.Extrema);
    %imshow(s3);
    T(i) = sum(s3(:));
    mmfill = imfill(s4,'holes');
    mmarea= length(nonzeros(mmfill));
    Tmm(i) = mmarea; %perim of mainmass
    mmoctagon= roipoly(s4,extrema2(:,1),extrema2(:,2))
    octarea= length(nonzeros(mmoctagon));
    MIrat(i)= (mmarea)/octarea;
    [labeledImage, numberOfObject] = bwlabel(s3);
    N1(i) = numberOfObject
    c2= regionprops(s2);
    centroids2 = cat(1,c2.Centroid)
    
    RGB = imread(str);
    drawCircle = insertShape(RGB,'circle',[P(1) P(2) radiusMin],'LineWidth',5);
    temp_img = imoverlay(drawCircle,s3,'white');
    text_str = ['radius:' num2str(radiusMin)  '; circle area:' num2str(circleArea) '; cell area:' num2str(S(1)) '; surface:' num2str(T(i)) '; dconn_obj:' num2str(N1(i))];
    finalImg = insertText(temp_img,textPosition,text_str,'FontSize',10,'BoxColor','white','BoxOpacity',0.2,'TextColor','white');
    %rename = convertCharsToStrings(str);
    %Frename = regexp(rename,'["]');
    F4= figure
    imshow(s3);
    hold on
    xk= 0;
    yk= 0;
    if numel(centroids2)>2
        bin1= []
        bin2= []
        bin3= []
        bin4= []
        shval= []
        [mmcol,mmrow] = find(s4) %mind the position of row and column
        for n=1:length(mmrow)
            if mmrow(n)>= 150 && mmcol(n)>= 150
                bin1(end+1)= n
            elseif mmrow(n)< 150 && mmcol(n)>= 150
                bin2(end+1)= n
            elseif mmrow(n)< 150 && mmcol(n)< 150
                bin3(end+1)= n
            elseif mmrow(n)>= 150 && mmcol(n)< 150
                bin4(end+1)= n
            end
        end 
        [maxArea,idx]=max([c2.Area])
        for j=setdiff(1:(length(centroids2)),idx)
            if centroids2(j,1)>= 150 && centroids2(j,2)>= 150 && length(bin1)~=0
                Xmm = mmrow(bin1)
                Ymm = mmcol(bin1)
                sC1= centroids2(j,1)
                sC2= centroids2(j,2)
                [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
                shval(end+1)= sdist
                plot([sC1 Xmm(spos)],[sC2 Ymm(spos)])
            elseif centroids2(j,1)< 150 && centroids2(j,2)>= 150 && length(bin2)~=0
                Xmm = mmrow(bin2)
                Ymm = mmcol(bin2)
                sC1= centroids2(j,1)
                sC2= centroids2(j,2)
                [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
                shval(end+1)= sdist
                plot([sC1 Xmm(spos)],[sC2 Ymm(spos)])
            elseif centroids2(j,1)< 150 && centroids2(j,2)< 150 && length(bin3)~=0
                Xmm = mmrow(bin3)
                Ymm = mmcol(bin3)
                sC1= centroids2(j,1)
                sC2= centroids2(j,2)
                [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
                shval(end+1)= sdist
                plot([sC1 Xmm(spos)],[sC2 Ymm(spos)])
            elseif centroids2(j,1)>= 150 && centroids2(j,2)< 150 && length(bin4)~=0
                Xmm = mmrow(bin4)
                Ymm = mmcol(bin4)
                sC1= centroids2(j,1)
                sC2= centroids2(j,2)
                [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
                shval(end+1)= sdist
                plot([sC1 Xmm(spos)],[sC2 Ymm(spos)])
            else
                Xmm = mmrow
                Ymm = mmcol
                sC1= centroids2(j,1)
                sC2= centroids2(j,2)
                [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
                shval(end+1)= sdist
                plot([sC1 Xmm(spos)],[sC2 Ymm(spos)])
            end
        end
        savg(i) = mean(shval)
        sstd(i) = std(shval)
    else
        savg(i)=0
        sstd(i)=0
    end

    %DestinationStr = ans.fileName{1};
    DestI = strfind(str,'Cell_Field_');
    FinalDestinationStr = extractBefore(str,DestI(1));
    mkdir([FinalDestinationStr,'processed']);
    DestinationFolderName = strcat(FinalDestinationStr,'/processed'); %'/' in mac and '\'in windows
    outFileName = fullfile(DestinationFolderName,strcat('processed',num2str(i)))
    saveas(F4,outFileName,'png');
    hold off
end
tempOutputArray(1:length(k),1) = k;
tempOutputArray(1:length(AllS),2) = AllS;
tempOutputArray(1:length(T),3) = T;
tempOutputArray(1:length(N1),4) = N1;
tempOutputArray(1:length(savg),5) = savg;
tempOutputArray(1:length(sstd),6) = sstd;
tempOutputArray(1:length(Tmm),7) = Tmm;
tempOutputArray(1:length(MIrat),8) = MIrat;


outputTable = array2table(tempOutputArray,'VariableNames',{'MCS','circle_Area','Total_Surface','dconn_obj','s_avg','s_std','mainmass_surface','inv_mode'});
tableName = fullfile(DestinationFolderName,'table.csv');
writetable(outputTable,tableName);
figureName = fullfile(DestinationFolderName,'figure1');

F1 = figure
subplot(3,1,1);
plot(k,AllS)
xlabel('MCS')
ylabel('Area of enclosing circle')
hold on


subplot(3,1,2);
plot(k,T)
xlabel('MCS')
ylabel('total surface area')
subplot(3,1,3);
plot(k,N1)
xlabel('MCS')
ylabel('disconnected objects')
saveas(F1,figureName,'png');



F2= figure

subplot(2,1,1)
plot(k,tempOutputArray(:,8))
xlabel('mcs')
ylabel('bm shape inddex')


subplot(2,1,2);
errorbar(k,savg,sstd)
xlabel('mcs')
ylabel('Dist. from mainmass surface')

figureName2 = fullfile(DestinationFolderName,'figure2');
saveas(F2,figureName2,'png');
clear dcvalplot;
clear cvalplot;
clear savg;
clear sstd;
clear tempOutputArray;
close all;
%end
function [sdist,spos] = sdistFromPoint(sC1,sC2,Xmm,Ymm)
    sdistSq = ( Xmm - sC1 ).^2 + ( Ymm - sC2 ).^2;
    [sdist,spos] = min(sqrt(sdistSq));
end
function r = radiusFromPoint(P,pointsX,pointsY)
    px = P(1);
    py = P(2);
    distSq = ( pointsX - px ).^2 + ( pointsY - py ).^2;
    r = sqrt(max(distSq));
end