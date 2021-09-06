image1 = imread("image_test.tif"); 
figure, imshow(image1);
dimensions = uint16(size(image1));

current_component=0; %acts as a component counter

global visited_array;
visited_array=zeros(dimensions(1),dimensions(2),2);

for i=1:dimensions(1)
    for j=1:dimensions(2)-1
        if image1(i,j)~=image1(i,j+1)
            visited_array(i,j,1)=1;
        end
    end
end

for i1=1:dimensions(1)-1
    for j1=1:dimensions(2)
        if image1(i1,j1)~=image1(i1+1,j1)
            visited_array(i1,j1,1)=1;
        end
    end
end

rslt= uint8(zeros(dimensions(1), dimensions(2), 3));
rslt(:,:,1)=uint8(visited_array(:,:,1)*255);
figure, imshow(rslt);
sample = rslt(:,:,1)*255;

hold on;

[border_pixels_x, border_pixels_y]=find(visited_array(:,:,1));


number_of_border_pixels=uint16(size(border_pixels_x));

for z=1:number_of_border_pixels(1)
    if visited_array(border_pixels_x(z), border_pixels_y(z),1)==1
        current_component = current_component+1;
        x=border_pixels_x(z);
        y=border_pixels_y(z);
        visited_array(x,y,2)=current_component;
        visited_array(x,y,1)=0;
        neighbor(x,y,current_component, dimensions(1), dimensions(2));
    else
        continue;
    end
end
component_positions =zeros(current_component,2);

for k=1:current_component
    [component_x, component_y]=find(visited_array(:,:,2)==k);
    min_x=uint16(min(component_x));
    max_x=uint16(max(component_x));
    min_y=uint16(min(component_y));
    max_y=uint16(max(component_y));
    x1=min_y;
    y1=min_x;
    w=max_y-min_y;
    h=abs(max_x-min_x);
    rectangle('position',[x1, y1, w, h], 'LineWidth', 1, 'EdgeColor','g');
    component_positions(k,1)=uint16(x1+w/2);
    component_positions(k,2)=uint16(y1+h/2);
end    

sample2=uint8(visited_array(:,:,2));
hold off;


function neighbor(xx,yy,cc,dim1, dim2)
a=[0 -1 0 1 -1 -1 1 1]; %order matters, first priority to 4n-connectivity, then to d-connectivity
b=[-1 0 1 0 -1 1 1 -1];
global visited_array;
flag=0;
current_m=-1;
for m=1:8
    if xx+a(m)>0 && xx+a(m)<=dim1 && yy+b(m)>0 && yy+b(m)<=dim2 && visited_array(xx+a(m),yy+b(m),1)==1
        flag=1;
        current_m=m;
        break;
    end
end
if flag==0
    return;
else
    xx=xx+a(current_m);
    yy=yy+b(current_m);
    visited_array(xx, yy, 1)=0;
    visited_array(xx, yy, 2)=cc;
    neighbor(xx, yy, cc, dim1, dim2);
end
end
