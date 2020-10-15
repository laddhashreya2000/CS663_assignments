function out_image = insert_marker(in_image,mark_image)
    pos = zeros(0,2);
    [X,Y] = size(in_image);
    out_image = in_image;
    for j = 2:X-1
        for k = 2:Y-1
            if (mark_image(j,k) == 1)
                pos(end+1,:) = [k j];
            end
        end
    end
    out_image = insertMarker(in_image,pos,'o','color','red','size',3);
end

