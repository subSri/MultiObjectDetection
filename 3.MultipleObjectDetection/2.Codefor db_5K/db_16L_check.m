function result = db_16L_check(img_no,shape_no)

    img_no = mod(img_no,1099);

    if (img_no == 0)
	img_no = 1099;
    end
   
    object_counts = [7 42 210 840];
    objects = 0;
    

    for i=1:4
        objects = objects+1;
        if( img_no > object_counts(1,i))
            img_no = img_no - object_counts(1,i); 
        else
            break;
        end
    end
    
    x = factorial(objects);
    combinations = nchoosek(1:7,objects);
    size(combinations,1);
    row = ceil(img_no/x);
   
    ans_ = ismember(shape_no,combinations(row,:));
    
    if any(ans_ == 1)
        result = 1;
    else
        result = 0;
    end
    
end
