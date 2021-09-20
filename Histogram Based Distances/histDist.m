function distances = histDist(image1, image2)

%distances are L-2 norm, Normalized Euclidean Distance, Cosine Distance,
%Bhattacharyya Distance and Histogram Intersection. 

distances = zeros(5,1);
img1_dim = size(image1);
img2_dim = size(image2);
img1 = double(image1);
img2 = double(image2);

%rescaling the intensities of the input images to range [0, 8]
for r=1:img1_dim(1)
    for c=1:img1_dim(2)
        for ch=1:3
            img1(r,c,ch) = round(img1(r,c,ch)*7/255);
        end
    end
end
for r=1:img2_dim(1)
    for c=1:img2_dim(2)
        for ch=1:3
            img2(r,c,ch) = round(img2(r,c,ch)*7/255);
        end
    end
end

hist_img1 = zeros(8, 8, 8);
hist_img2 = zeros(8, 8, 8);

for r=1:img1_dim(1)
    for c=1:img1_dim(2)
       hist_img1(img1(r,c,1)+1, img1(r,c,2)+1, img1(r,c,3)+1) =  hist_img1(img1(r,c,1)+1, img1(r,c,2)+1, img1(r,c,3)+1) + 1;
    end
end
for r=1:img2_dim(1)
    for c=1:img2_dim(2)
        hist_img2(img2(r,c,1)+1, img2(r,c,2)+1, img2(r,c,3)+1) =  hist_img2(img2(r,c,1)+1, img2(r,c,2)+1, img2(r,c,3)+1) + 1;
    end
end

hist_img1 = reshape(hist_img1, 512, 1);
hist_img2 = reshape(hist_img2, 512, 1);

%L-2 norm
L_2_norm = hist_img1-hist_img2;
L_2_norm = L_2_norm.*L_2_norm;
L_2_norm = sum(L_2_norm);
L_2_norm = sqrt(L_2_norm);

%Normalized Euclidian Distance
%%---WE NEED THE WHOLE TRAINING DATASET TO COMPUTE THE NORMALIZED VALUES OF
%%EACH FEATURES (BINS) IN THE HISTOGRAM, BUT AS PER THE PROBLEM STATEMENT,
%%THE HISTDIST FUNCTION TAKES ONLY TWO IMAGES AS ITS PARAMETERS, HENCE WE
%%CANNOT COMPUTE THE MEAN AND VARIANCE FOR EACH DIMENSION (AS TOLD IN
%%LECTURE), SO FOR NOW I'AM ASSUMING NORMALIZED EUCLIDEAN DISTANCE IS SAME
%%AS L-2 NORM. ONE WAY TO TACKLE THIS ISSUE IS TO CALL THIS HISTDIST
%%FUNCTION TWICE FIRST WITH NON NORMALIZED IMAGE INPUTS AND THEN WITH
%%NORMALIZED IMAGE INPUTS.
NED = L_2_norm;

%cosine distance
dot_product = hist_img1.*hist_img2;
len_hist_img1 = sqrt(sum(hist_img1.*hist_img1));
len_hist_img2 = sqrt(sum(hist_img2.*hist_img2));
cosine_dist = sum(dot_product/(len_hist_img1*len_hist_img2));

%bhattacharyya distance
pd_img1 = hist_img1./(img1_dim(1)*img1_dim(2));
pd_img2 = hist_img2./(img2_dim(1)*img2_dim(2));
sqr_pd_img1 = sqrt(pd_img1);
sqr_pd_img2 = sqrt(pd_img2);
bc = sum(sqr_pd_img1.*sqr_pd_img2);
bhattacharyya_distance = -log(bc);

%histogram intersetion
intersection = min(pd_img1, pd_img2);
hist_intersection = sum(intersection);

distances(1,1)=L_2_norm;
distances(2,1)=NED;
distances(3,1)=cosine_dist;
distances(4,1)=bhattacharyya_distance;
distances(5,1)=hist_intersection;
end
