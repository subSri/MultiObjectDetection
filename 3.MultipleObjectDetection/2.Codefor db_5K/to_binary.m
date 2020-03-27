function img = to_binary(input_img)

img = zeros(size(input_img,1),size(input_img,2));

for i=1:size(input_img,1)
    for j=1:size(input_img,2)
        if ( input_img(i,j,1) ~= 0 && input_img(i,j,2) ~=0 && input_img(i,j,3) ~= 0)
            img(i,j) = 1;
        else
            img(i,j) = 0; 
        end
    end
end
img = logical(img);
end