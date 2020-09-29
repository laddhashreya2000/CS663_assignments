function rmsd = getRMSD(img1, img2)
    N = size(img1, 1) * size(img1, 2);
    sumOfSquares = sum(sum((img1 - img2) .^ 2));
    rmsd = sqrt(sumOfSquares/N);
end
