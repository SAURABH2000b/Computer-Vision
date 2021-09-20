train_data = ["image004.jpg" "proper_label" ; "image026.jpg" "missing_label"; "image029.jpg" "white_label"; "image047.jpg" "missing_bottle"];

image_proper_label=im2bw(imread("image004.jpg"));
image_missing_label=im2bw(imread("image026.jpg"));
image_white_label=im2bw(imread("image029.jpg"));
image_missing_bottle=im2bw(imread("image047.jpg"));

cc_proper_label=bwconncomp(image_proper_label);
cc_missing_label=bwconncomp(image_missing_label);
cc_white_label=bwconncomp(image_white_label);
cc_missing_bottle=bwconncomp(image_missing_bottle);

% components computation (no use in our application)
components_proper_label=cc_proper_label.NumObjects;
components_missing_label=cc_missing_label.NumObjects;
components_white_label=cc_white_label.NumObjects;
components_missing_bottle=cc_missing_bottle.NumObjects;

components = [components_proper_label components_missing_label components_white_label components_missing_bottle];

%finding area of white pixels in each training image
component_area_proper_label=findArea(image_proper_label);
component_area_missing_label=findArea(image_missing_label);
component_area_white_label=findArea(image_white_label);
component_area_missing_bottle=findArea(image_missing_bottle);

%dataset parsing
fileinfo = dir("coke_bottle_images");
file_names={fileinfo.name};
computed_labels=zeros(size(file_names));

label_counters = zeros(1,4);

%proper_label -> 1
%missing_label -> 2
%white_label -> 3
%missing_bottle -> 4

%code for classification of images
size1=size(computed_labels);
number_of_images=uint8(size1(2));
train_vec=[component_area_proper_label component_area_missing_label component_area_white_label component_area_missing_bottle];
for i=1:number_of_images
    current_file_name=string(file_names{i});
    image_path=strcat("coke_bottle_images/",current_file_name);
    current_image=im2bw(imread(image_path));
    current_area=findArea(current_image);
    temp1=int32(ones(1,4))*int32(current_area);
    temp2=int32(train_vec)-temp1;
    temp2=uint32(abs(temp2));
    temp3=min((temp2));
    temp4=find(temp2==temp3);
    temp5=temp4(1);
    label_counters(temp5)=label_counters(temp5)+1;
    computed_labels(i,1)=temp5;
end

%keeping images of each class in their respective folders
mkdir proper_label;
mkdir missing_label;
mkdir white_label;
mkdir missing_bottle;


for p=1:number_of_images
    name_of_file=string(file_names(p));
    label=computed_labels(p);
    if label==1
  
        copyfile(strcat("coke_bottle_images/",name_of_file),"proper_label/");
    end
    if label==2
        
       copyfile(strcat("coke_bottle_images/",name_of_file),"missing_label/");
    end
    if label==3
        
       copyfile(strcat("coke_bottle_images/",name_of_file),"white_label/");
    end
    if label==4
        
        copyfile(strcat("coke_bottle_images/",name_of_file),"missing_bottle/");
    end
   
end

%changing the names as asked in problem statement
file_info_in_proper_label=dir(fullfile("proper_label/",'*.jpg'));
file_info_in_missing_label=dir(fullfile("missing_label/",'*.jpg'));
file_info_in_white_label=dir(fullfile("white_label/",'*.jpg'));
file_info_in_missing_bottle=dir(fullfile("missing_bottle/",'*.jpg'));

files_in_proper_label={file_info_in_proper_label.name};
files_in_missing_label={file_info_in_missing_label.name};
files_in_white_label={file_info_in_white_label.name};
files_in_missing_bottle={file_info_in_missing_bottle.name};

for a=1:label_counters(1)
    oldname=fullfile("proper_label/",files_in_proper_label{a});
    newname=fullfile("proper_label/",strcat('PL', string(a), '.jpg'));
    movefile(oldname,newname);
end
for b=1:label_counters(2)
    oldname=fullfile("missing_label/",files_in_missing_label{b});
    newname=fullfile("missing_label/",strcat('ML', string(b), '.jpg'));
    movefile(oldname,newname);
end
for c=1:label_counters(3)
    oldname=fullfile("white_label/",files_in_white_label{c});
    newname=fullfile("white_label/",strcat('WL', string(c), '.jpg'));
    movefile(oldname,newname);
end
for d=1:label_counters(4)
    oldname=fullfile("missing_bottle/",files_in_missing_bottle{d});
    newname=fullfile("missing_bottle/",strcat('MB', string(d), '.jpg'));
    movefile(oldname,newname);
end

%function to compute area of components
function area=findArea(image)
[white_pixels_row white_pixels_column] = find(image);
size1=uint32(size(white_pixels_row));
area=size1(1);
end
