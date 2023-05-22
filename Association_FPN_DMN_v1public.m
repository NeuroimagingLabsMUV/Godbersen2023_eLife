
% Analysis script for Godbersen et al. eLife, 2023
% Task-evoked metabolic demands of the posteromedial default mode network are shaped by dorsal attention and frontoparietal control networks

% % % % % % % 
% association task positive (tetris vs working memory) vs PCC using difference maps
clear
patList = importdata('patList_50HCm1.txt');

patPath = '';
roi_pnfn1 = 'Yeo_map.nii';
roi_pnfn2 = 'Intersection_BOLD_CMRGlu_WorkingMemory_pos.nii';
roi_pnfn22 = 'Intersection_BOLD_CMRGlu_Tetris_pos.nii';
roi_pnfn3 = 'PCC.nii';

roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi22 = load_nii(roi_pnfn22);
roi22.img(isnan(roi22.img)) = 0;
roi22.img(isinf(roi22.img)) = 0;
roi22.img(roi22.img~=0) = 1;
roi3 = load_nii(roi_pnfn3);
roi3.img(isnan(roi3.img)) = 0;
roi3.img(isinf(roi3.img)) = 0;
roi3.img(roi3.img~=0) = 1;

data = zeros(size(patList,1),4);
for iter=1:size(patList,1)
	
    % load PET data
    PetData = load_nii([patPath patList{iter} '_CMRGlu_hard.nii']);
    % extract data
    temp = (roi1.img==1).*roi22.img;    % VN
    temp(temp~=0) = 1;
    temp(roi2.img~=0) = 0;
    data(iter,1) = mean(nonzeros(PetData.img.*temp));
    
    temp = (roi1.img==3).*roi22.img;    % DAN
    temp(temp~=0) = 1;
    temp(roi2.img~=0) = 0;
    data(iter,2) = mean(nonzeros(PetData.img.*temp));
    
    temp = (roi1.img==6).*roi2.img;     % FPN
    temp(temp~=0) = 1;
    temp(roi22.img~=0) = 0;
    data(iter,3) = mean(nonzeros(PetData.img.*temp));
    
    data(iter,4) = mean(nonzeros(PetData.img.*roi3.img));
    
end

% regression analysis
[B1,BINT1,~,~,STATS1] = regress(data(:,4),[ones(size(data,1),1) data(:,1:3)])
% cross check
[B2,~,STATS2] = glmfit(data(:,1:3),data(:,4));
disp(B2)
disp(STATS2.p)

% create figure
disp([min(data(:,2)) max(data(:,2))])
disp([min(data(:,3)) max(data(:,3))])
figure
[x,y] = meshgrid(1:0.2:6, -1:0.2:3);
z = B1(1) + B1(3)*x + B1(4)*y;
surf(x,y,z, 'EdgeColor','none', 'FaceAlpha',0.75)
colormap('JET')
hold on
plot3(data(:,2),data(:,3),data(:,4),'k.', 'MarkerSize',16)
xlabel('DAN CMRGlu')
ylabel('FPN CMRGlu')
zlabel('pmDMN CMRGlu')
hold off





% % % % % % % 
% association task positive (tetris vs working memory) vs PCC using difference maps
% use statistical conjunction maps
clear
patList = importdata('patList_50HCm1.txt');

patPath = '';
roi_pnfn1 = 'Yeo_map.nii';
roi_pnfn2 = 'Conjunction_BOLD_CMRGlu_WorkingMemory_pos.nii';
roi_pnfn22 = 'Conjunction_BOLD_CMRGlu_Tetris_pos.nii';
roi_pnfn3 = 'PCC.nii';

roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img = double(roi2.img);
roi22 = load_nii(roi_pnfn22);
roi22.img = double(roi22.img);
roi22.img(isnan(roi22.img)) = 0;
roi22.img(isinf(roi22.img)) = 0;
roi22.img(roi22.img~=0) = 1;
roi3 = load_nii(roi_pnfn3);
roi3.img = double(roi3.img);
roi3.img(isnan(roi3.img)) = 0;
roi3.img(isinf(roi3.img)) = 0;
roi3.img(roi3.img~=0) = 1;

data = zeros(size(patList,1),4);
for iter=1:size(patList,1)
    
    % load PET data
    PetData = load_nii([patPath patList{iter} '_CMRGlu_hard.nii']);
    % extract data
    temp = (roi1.img==1).*roi22.img;    % VN
    temp(temp~=0) = 1;
    temp(roi2.img~=0) = 0;
    data(iter,1) = mean(nonzeros(PetData.img.*temp));
    
    temp = (roi1.img==3).*roi22.img;    % DAN
    temp(temp~=0) = 1;
    temp(roi2.img~=0) = 0;
    data(iter,2) = mean(nonzeros(PetData.img.*temp));
    
    temp = (roi1.img==6).*roi2.img;     % FPN
    temp(temp~=0) = 1;
    temp(roi22.img~=0) = 0;
    data(iter,3) = mean(nonzeros(PetData.img.*temp));
    
    data(iter,4) = mean(nonzeros(PetData.img.*roi3.img));
    
end

% regression analysis
[B1,BINT1,~,~,STATS1] = regress(data(:,4),[ones(size(data,1),1) data(:,1:3)])
% cross check
[B2,~,STATS2] = glmfit(data(:,1:3),data(:,4));
disp(B2)
disp(STATS2.p)

% create figure
figure
disp([min(data(:,2)) max(data(:,2))])
disp([min(data(:,3)) max(data(:,3))])
[x,y] = meshgrid(2:0.2:7, -0.5:0.2:4);
z = B1(1) + B1(3)*x + B1(4)*y;
surf(x,y,z, 'EdgeColor','none', 'FaceAlpha',0.75)
colormap('JET')
hold on
plot3(data(:,2),data(:,3),data(:,4),'k.', 'MarkerSize',16)
xlabel('DAN CMRGlu')
ylabel('FPN CMRGlu')
zlabel('PCC CMRGlu')
hold off





% % % % % % % 
% association task positive (tetris vs working memory) vs PCC using Yeo maps
clear
patList = importdata('patList_50HCm1.txt');

patPath = '';
roi_pnfn1 = 'Yeo_map.nii';
roi_pnfn3 = 'PCC.nii';

roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
roi3 = load_nii(roi_pnfn3);
roi3.img(isnan(roi3.img)) = 0;
roi3.img(isinf(roi3.img)) = 0;
roi3.img(roi3.img~=0) = 1;

data = zeros(size(patList,1),4);
for iter=1:size(patList,1)
    
    % load PET data
    PetData = load_nii([patPath patList{iter} '_CMRGlu_hard.nii']);
    % extract data
    temp = zeros(size(roi1.img));
    temp(roi1.img==1) = 1;    % VN
    data(iter,1) = mean(nonzeros(PetData.img.*temp));
    
    temp = zeros(size(roi1.img));
    temp(roi1.img==3) = 1;    % DAN
    data(iter,2) = mean(nonzeros(PetData.img.*temp));
    
    temp = zeros(size(roi1.img));
    temp(roi1.img==6) = 1;     % FPN
    data(iter,3) = mean(nonzeros(PetData.img.*temp));
    
    data(iter,4) = mean(nonzeros(PetData.img.*roi3.img));
    
end

% regression analysis
[B1,BINT1,~,~,STATS1] = regress(data(:,4),[ones(size(data,1),1) data(:,1:3)])
% cross check
[B2,~,STATS2] = glmfit(data(:,1:3),data(:,4));
disp(B2)
disp(STATS2.p)

% create figure
figure
disp([min(data(:,2)) max(data(:,2))])
disp([min(data(:,3)) max(data(:,3))])
[x,y] = meshgrid(1:0.2:5, -0.6:0.2:3);
z = B1(1) + B1(3)*x + B1(4)*y;
surf(x,y,z, 'EdgeColor','none', 'FaceAlpha',0.75)
colormap('JET')
hold on
plot3(data(:,2),data(:,3),data(:,4),'k.', 'MarkerSize',16)
xlabel('DAN CMRGlu')
ylabel('FPN CMRGlu')
zlabel('PCC CMRGlu')
hold off
