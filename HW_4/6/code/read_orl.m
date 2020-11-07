function [train, test_unknown, test_known]=read_orl(dir)
    train=[];
    test_unknown=[];
    test_known = [];

    for index=1:32
        im_folder = strcat(dir, 's',num2str(index),'/');

        for i=1:6
            im_path = strcat(im_folder, num2str(i),'.pgm');
            im=imread(im_path);
            im=reshape(im, [], 1);
            train=[train, im(:)];
        end
    end
    for index=33:40
        for i=1:10
            im_path = strcat(im_folder, num2str(i),'.pgm');
            im=imread(im_path);
            im=reshape(im, [], 1);
            test_unknown=[test_unknown, im(:)];
        end
        
        % images of ith person: columns (i-1)*6+1:(i-1)*6+6
    end
    for index=1:32
        for i=7:10
            im_path = strcat(im_folder, num2str(i),'.pgm');
            im=imread(im_path);
            im=reshape(im, [], 1);
            test_known=[test_known, im(:)];
        end
        
        % images of ith person: columns (i-1)*6+1:(i-1)*6+6
    end
end
    