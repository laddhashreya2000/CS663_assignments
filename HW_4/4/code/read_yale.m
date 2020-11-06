function [train, test]= read_yale(path)
    ppl=dir(path);
    train=[];
    test=[];
    for i=3:size(ppl, 1)
        ppl_path=strcat(path, '/', ppl(i).name);
        ims=dir(ppl_path);

        for j=3:42
            im_path=strcat(ppl_path, '/', ims(j).name);
            train=[train, reshape(imread(im_path),[],1)];
        end

        for j=43:62
            im_path=strcat(ppl_path, '/', ims(j).name);
            test=[test, reshape(imread(im_path), [], 1)];  
        end
    end