function result = db_24_check(img_no,shape_no)

    img_no = mod(img_no,4);
    result = 0;
    
    if( shape_no == 1)
        result = 1;
    elseif (shape_no == 2)
        if( img_no > 1 || img_no == 0)
            result = 1;
        end
    elseif (shape_no == 3)
        if( img_no > 2 || img_no == 0)
            result = 1;
        end
    elseif (shape_no == 4)
        if( img_no > 3 || img_no == 0)
            result = 1;
        end
    end
    
end