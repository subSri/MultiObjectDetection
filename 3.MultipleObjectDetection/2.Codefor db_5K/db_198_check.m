function result = db_198_check(img_no,shape_no)

    img_no = mod(img_no,33)+1;
    result = 0;
    
    if( shape_no == 1)
        result = 1;
    elseif (shape_no == 2)
        if( img_no > 1)
            result = 1;
        end
    elseif (shape_no == 3)
        if( img_no > 3)
            result = 1;
        end
    elseif (shape_no == 4)
        if( img_no > 9)
            result = 1;
        end
    end
    
end