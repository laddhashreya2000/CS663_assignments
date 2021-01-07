function [train, test]=read_orl(dir)
    train=[];
    test=[];

    for index=1:32
        im_folder = strcat(dir, 's',num2str(index),'/');

        for i=1:6
            im_path = strcat(im_folder, num2str(i),'.pgm');
            im=imread(im_path);
            im=reshape(im, [], 1);
            train=[train, im(:)];
        end

        for i=7:10
            im_path = strcat(im_folder, num2str(i),'.pgm');
            im=imread(im_path);
            im=reshape(im, [], 1);
            test=[test, im(:)];
        end
        
        % images of ith person: columns (i-1)*6+1:(i-1)*6+6
    end
    