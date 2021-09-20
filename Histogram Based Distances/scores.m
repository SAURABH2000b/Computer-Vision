%here we will choose 1 image out of each of the 4 classes, use them as test images,
%while others being the training images, then we will compute the scores/distances
%of each of these images with images of their own class and with images of other class.
%we store these results based on same class distances and different class distances in
%two different text files sameScore.txt and differentScores.txt in the format:
%<test_file_name> <train_file_name> dist1 dist2 dist3 dist4 dist5
%where dist[1:5] are the distances returned from histDist() function.
%this data will be used to compute the accuracy of each of these distance measures.
  
%the program uses the already classified training data of coke bottle images,
%with classes being: proper_label (PL), missing_bottle (MB), missing_label (ML)
%and white_label (WL).
  
%the dataset is created from already available images of coke bottles, using
%component based classification technique shown in comp_based_classify.m program.
  
%checkig histDist() function.
%image1 = imread("coke_bottle_images/WL008.jpg");
%image2 = imread("coke_bottle_images/WL009.jpg");
%distances = histDist(image1,image2);

fileinfo = dir("coke_bottle_images");
file_names={fileinfo.name};
number_of_files = size(file_names);

PL= zeros(100,1);
MB= zeros(100,1);
ML= zeros(100,1);
WL= zeros(100,1);
pl_c=0;
mb_c=0;
ml_c=0;
wl_c=0;

for p=1:number_of_files(2)
    if strfind(file_names{1,p},"image")
        pl_c = pl_c+1;
        PL(pl_c,1)=p;
    elseif strfind(file_names{1,p},"MB")
        mb_c = mb_c+1;
        MB(mb_c,1)=p;
    elseif strfind(file_names{1,p},"ML")
        ml_c = ml_c+1;
        ML(ml_c,1)=p;
    elseif strfind(file_names{1,p},"WL")
        wl_c = wl_c+1;
        WL(wl_c,1)=p;
    end
end
PL = PL(1:pl_c,1);
MB = MB(1:mb_c,1);
ML = ML(1:ml_c,1);
WL = WL(1:wl_c,1);

PL_test = PL(randsample(pl_c,1));
MB_test = MB(randsample(mb_c,1));
ML_test = ML(randsample(ml_c,1));
WL_test = WL(randsample(wl_c,1));

test_files = [PL_test, MB_test, ML_test, WL_test];
FileID_1 = fopen("sameScore.txt", "w");
FileID_2 = fopen("differntScores.txt", "w");

fprintf(FileID_1,'test_filename train_filename dist1 dist2 dist3 dist4 dist5\n');
fprintf(FileID_2,'test_filename train_filename dist1 dist2 dist3 dist4 dist5\n');

for i=1:4
    for j=1:pl_c
        if i==1
            if test_files(i) ~= PL(j)
                img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
                img2 = imread(strcat("coke_bottle_images/",file_names{PL(j)}));
                dist = histDist(img1, img2);
                fprintf(FileID_1, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n', file_names{test_files(i)},file_names{PL(j)}, dist);
            end
        else
            img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
            img2 = imread(strcat("coke_bottle_images/",file_names{PL(j)}));
            dist = histDist(img1, img2);
            fprintf(FileID_2, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n',file_names{test_files(i)}, file_names{PL(j)}, dist);
        end
    end
    
    for j=1:mb_c
        if i==2
            if test_files(i) ~= MB(j)
                img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
                img2 = imread(strcat("coke_bottle_images/",file_names{MB(j)}));
                dist = histDist(img1, img2);
                fprintf(FileID_1, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n', file_names{test_files(i)}, file_names{MB(j)}, dist);
            end
        else
            img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
            img2 = imread(strcat("coke_bottle_images/",file_names{MB(j)}));
            dist = histDist(img1, img2);
            fprintf(FileID_2, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n', file_names{test_files(i)}, file_names{MB(j)}, dist);
        end
    end
    
    for j=1:ml_c
        if i==3
            if test_files(i) ~= ML(j)
                img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
                img2 = imread(strcat("coke_bottle_images/",file_names{ML(j)}));
                dist = histDist(img1, img2);
                fprintf(FileID_1, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n',file_names{test_files(i)}, file_names{ML(j)}, dist);
            end
        else
            img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
            img2 = imread(strcat("coke_bottle_images/",file_names{ML(j)}));
            dist = histDist(img1, img2);
            fprintf(FileID_2, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n', file_names{test_files(i)},file_names{ML(j)}, dist);
        end
    end
    for j=1:wl_c
        if i==4
            if test_files(i) ~= WL(j)
                img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
                img2 = imread(strcat("coke_bottle_images/",file_names{WL(j)}));
                dist = histDist(img1, img2);
                fprintf(FileID_1, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n',file_names{test_files(i)}, file_names{WL(j)}, dist);
            end
        else
            img1 = imread(strcat("coke_bottle_images/",file_names{test_files(i)}));
            img2 = imread(strcat("coke_bottle_images/",file_names{WL(j)}));
            dist = histDist(img1, img2);
            fprintf(FileID_2, '%s %s %0.3f %0.3f %0.3f %0.3f %0.3f\n', file_names{test_files(i)},file_names{WL(j)}, dist);
        end
    end
end

fclose(FileID_1);
fclose(FileID_2);
