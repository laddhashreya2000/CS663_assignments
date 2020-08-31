function out_img = myBiHistogramEqualization(img)
  flatimg = reshape(img, 1, []);
  medn = double(median(flatimg));
  
  lowelm_img = img > medn;
  highelm_img = img <= medn;
  
  high_img = img;
  high_img(highelm_img)=0;
  
  low_img = img;
  low_img(lowelm_img)=0;
  
  [~, lowMap] = histeq(low_img,medn);
  [~, highMap] = histeq(high_img,256-medn);
  lookupTable = uint8([medn*lowMap(1:medn), 256*highMap(medn+1:end)]);
  out_img = intlut(img, lookupTable);
  imwrite(out_img,'outt.png');