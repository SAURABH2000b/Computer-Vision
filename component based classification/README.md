here the four images image004.jpg, image026.jpg, image029.jpg and image047.jpg are the training images and each image represents
a class out of Proper_Label (PL), Missing_Bottle (MB), Missing_Label (ML) and White_Label (WL). using these images the classifying
function computes the approximate component count of each of these classes, and then it classify each of the images in folder
coke_bottle_images (the folder is not present in the repository, it can be easily accessed from MATLAB free CV assets). it has been
observed that for binary images, the number of components is proportional to the area of component of one color (white or black), as explicit
component computation is complex task (its program is present in this repository itself), we can just use the component area instead, and get
reasonable results.
