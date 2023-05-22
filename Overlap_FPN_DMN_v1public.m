
% Analysis script for Godbersen et al. eLife, 2023
% Task-evoked metabolic demands of the posteromedial default mode network are shaped by dorsal attention and frontoparietal control networks

% % % % % % 
% overlap across cortical networks
% express as percentage of cortical networks -> sums to 1 across networks
% resorted by Smallwood2021 gradients
clear
roi_pnfn1 = 'Yeo_map.nii';

% load ROI
% Yeo 
roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
% resort acc to gradients
roi1_new = zeros(size(roi1.img));
roi1_new(roi1.img==1) = 2;
roi1_new(roi1.img==2) = 1;
roi1_new(roi1.img==3) = 3;
roi1_new(roi1.img==4) = 4;
roi1_new(roi1.img==5) = 6;
roi1_new(roi1.img==6) = 5;
roi1_new(roi1.img==7) = 7;

% WM data [Stiernman et al 2021, PNAS]
roi_pnfn2 = 'Intersection_BOLD_CMRGlu_WorkingMemory_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new(:))
    o1n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% Tetris data
roi_pnfn2 = 'Intersection_BOLD_CMRGlu_Tetris_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new(:))
    o2n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% visual/motor task data [Hahn et al 2018, BSAF]
roi_pnfn2 = 'CMRGlu_Visual_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new(:))
    o3n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

roi_pnfn2 = 'CMRGlu_Finger_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new(:))
    o4n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% create figure
figure, bar([o3n; o4n; o2n; o1n; -abs(o1n-o2n)]'), ylim([-0.6 0.9])
legend('eye','rft','tetris','wm','diff')
title('Overlap task activations normalized')
ylabel('% of voxels')
xlabel('SM         VI         DA         VA         FP         FT         DM')



% % % % % % % % 
% same for deactivations
% DMN additionally split by Yeo17
clear
roi_pnfn1 = 'Yeo_map.nii';
roi_pnfn1add = 'Yeo17_map.nii';

% load ROI
% Yeo liberal
roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
% resort acc to gradients
roi1_new = zeros(size(roi1.img));
roi1_new(roi1.img==1) = 2;
roi1_new(roi1.img==2) = 1;
roi1_new(roi1.img==3) = 3;
roi1_new(roi1.img==4) = 4;
roi1_new(roi1.img==5) = 6;
roi1_new(roi1.img==6) = 5;
roi1_new(roi1.img==7) = 7;
roi1 = load_nii(roi_pnfn1add);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
roi1_new2 = zeros(size(roi1.img));
roi1_new2(roi1.img==14) = 1;
roi1_new2(roi1.img==15) = 2;
roi1_new2(roi1.img==16) = 3;
roi1_new2(roi1.img==17) = 4;

% WM data [Stiernman et al 2021, PNAS]
roi_pnfn2 = 'Intersection_BOLD_CMRGlu_WorkingMemory_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new2(:))
    o1n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% Tetris data
roi_pnfn2 = 'Intersection_BOLD_CMRGlu_Tetris_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new2(:))
    o2n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% visual/motor task data [Hahn et al 2018, BSAF]
roi_pnfn2 = 'CMRGlu_Visual_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new2(:))
    o3n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

roi_pnfn2 = 'CMRGlu_Finger_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new2(:))
    o4n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% create figure
figure, bar([[o3n; o4n; o2n; o1n; -abs(o1n-o2n)]'; NaN(3,5)]), ylim([-0.6 0.9])
legend('eye','rft','tetris','wm','diff')
title('Overlap task deactivations normalized')
ylabel('% of voxels')
xlabel('DTD         DTH         DM         DTV                                         ')






% % % % % % 
% overlap across cortical networks using statistical conjunction maps
% express as percentage of cortical networks -> sums to 1 across networks
% resorted by Smallwood2021 gradients
clear
roi_pnfn1 = 'Yeo_map.nii';

% load ROI
% Yeo
roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;

% resort acc to gradients
roi1_new = zeros(size(roi1.img));
roi1_new(roi1.img==1) = 2;
roi1_new(roi1.img==2) = 1;
roi1_new(roi1.img==3) = 3;
roi1_new(roi1.img==4) = 4;
roi1_new(roi1.img==5) = 6;
roi1_new(roi1.img==6) = 5;
roi1_new(roi1.img==7) = 7;

% WM data [Stiernman et al 2021, PNAS]
roi_pnfn2 = 'Conjunction_BOLD_CMRGlu_WorkingMemory_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img = double(roi2.img);
for ind = 1:max(roi1_new(:))
    o1n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% Tetris data
roi_pnfn2 = 'Conjunction_BOLD_CMRGlu_Tetris_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new(:))
    o2n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% visual/motor task data [Hahn et al 2018, BSAF]
roi_pnfn2 = 'CMRGlu_Visual_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new(:))
    o3n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

roi_pnfn2 = 'CMRGlu_Finger_pos.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new(:))
    o4n(ind) = nnz((roi1_new==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% create figure
figure, bar([o3n; o4n; o2n; o1n; -abs(o1n-o2n)]'), ylim([-0.6 0.9])
legend('eye','rft','tetris','wm','diff')
title('Overlap task activations normalized')
ylabel('% of voxels')
xlabel('SM         VI         DA         VA         FP         FT         DM')



% % % % % % % % 
% same for deactivations
% DMN additionally split by Yeo17
clear
roi_pnfn1 = 'Yeo_map.nii';
roi_pnfn1add = 'Yeo17_map.nii';

% load ROI
% Yeo
roi1 = load_nii(roi_pnfn1);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
% resort acc to gradients
roi1_new = zeros(size(roi1.img));
roi1_new(roi1.img==1) = 2;
roi1_new(roi1.img==2) = 1;
roi1_new(roi1.img==3) = 3;
roi1_new(roi1.img==4) = 4;
roi1_new(roi1.img==5) = 6;
roi1_new(roi1.img==6) = 5;
roi1_new(roi1.img==7) = 7;
roi1 = load_nii(roi_pnfn1add);
roi1.img(isnan(roi1.img)) = 0;
roi1.img(isinf(roi1.img)) = 0;
roi1_new2 = zeros(size(roi1.img));
roi1_new2(roi1.img==14) = 1;
roi1_new2(roi1.img==15) = 2;
roi1_new2(roi1.img==16) = 3;
roi1_new2(roi1.img==17) = 4;

% WM data [Stiernman et al 2021, PNAS]
roi_pnfn2 = 'Conjunction_BOLD_CMRGlu_WorkingMemory_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img = double(roi2.img);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new2(:))
    o1n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% Tetris data
roi_pnfn2 = 'Conjunction_BOLD_CMRGlu_Tetris_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
for ind = 1:max(roi1_new2(:))
    o2n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% visual/motor task data [Hahn et al 2018, BSAF]
roi_pnfn2 = 'CMRGlu_Visual_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new2(:))
    o3n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

roi_pnfn2 = 'CMRGlu_Finger_neg.nii';
roi2 = load_nii(roi_pnfn2);
roi2.img(isnan(roi2.img)) = 0;
roi2.img(isinf(roi2.img)) = 0;
roi2.img(roi2.img~=0) = 1;
roi2.img(:,:,1:10) = [];
for ind = 1:max(roi1_new2(:))
    o4n(ind) = nnz((roi1_new2==ind).*roi2.img)/nnz(roi1_new.*roi2.img);
end

% create figure
figure, bar([[o3n; o4n; o2n; o1n; -abs(o1n-o2n)]'; NaN(3,5)]), ylim([-0.5 0.5])
legend('eye','rft','tetris','wm','diff')
title('Overlap task deactivations normalized')
ylabel('% of voxels')
xlabel('DTD         DTH         DM         DTV                                         ')


