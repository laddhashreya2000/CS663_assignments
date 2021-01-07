tic
clear all; close all;
warning('off');
%% Test for genuine cases from 11 to 40 
%comp_im_num = 6; %number of images for comparison per persoon
corr_gen = 0; fal_gen = 0; fal_imp = 0; corr_imp = 0;
return_address = pwd;
BaseName = strcat(pwd,'\CASIA\0');
for j = 11:40
    new_dir1 = BaseName+string(j)+'\1\';
    cd(new_dir1);
    im = imread(strcat('0',string(j),'_1','_1.bmp'));
    im_compare = zeros(280,320,0);
    for k = 2:3
        im_compare(:,:,end+1) = imread(strcat('0',string(j),'_1_',string(k),'.bmp'));
    end
    new_dir2 = BaseName+string(j)+'\2\';
    cd(new_dir2);
    for k = 1:4
        im_compare(:,:,end+1) = imread(strcat('0',string(j),'_2_',string(k),'.bmp'));
    end
    cd(return_address);
    for l = 1:6
        if testing(im,im_compare(:,:,l)) == 1
            corr_gen = corr_gen + 1;
        else
            fal_imp = fal_imp + 1;
        end
    end
    toc        
end 


%% Test for imposter cases from 11 to 40 
for j = 11:40
    new_dir1 = BaseName+string(j)+'\1\';
    cd(new_dir1);
    im = imread(strcat('0',string(j),'_1','_1.bmp'));
    im_compare = zeros(280,320,0);

        new_dir1 = BaseName+string(j+1)+'\1\';
        cd(new_dir1);
        for l = 1:3
            im_compare(:,:,end+1) = imread(strcat('0',string(j+1),'_1_',string(l),'.bmp'));
        end
        new_dir2 = BaseName+string(j+1)+'\2\';
        cd(new_dir2);
        for l = 1:4
            im_compare(:,:,end+1) = imread(strcat('0',string(j+1),'_2_',string(l),'.bmp'));
        end        
        cd(return_address);
        for l = 1:size(im_compare,3)
            if testing(im,im_compare(:,:,l)) == 0
                corr_imp = corr_imp + 1;
            else
                fal_gen = fal_gen + 1;
            end
        end        
   
    toc
end
gen_acc = 100*corr_gen/(corr_gen+fal_imp); %genuine detection accuracy
imp_acc = 100*corr_imp/(corr_imp+fal_gen); %imposter detection accuracy
%code will take almost 420 secs (7 minutes) to run using the set parameters
disp('Genuine detection accuracy = '); disp(string(gen_acc) + '%'); 
disp('Imposter detection accuracy = '); disp(string(imp_acc) + '%');
toc
    