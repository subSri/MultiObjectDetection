function shape_no = db_42_check(img_no)

    img_no
    if(img_no <= 7)
        shape_no = img_no;
    else
        shape_no = mod(img_no,7);
    end
    if( shape_no == 0)
        shape_no = 7;
    end
    shape_no
end