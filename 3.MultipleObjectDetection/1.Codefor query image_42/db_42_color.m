function [result] = db_42_color(img_no)
    colours = [[1 0 0]; [ 0 1 0]; [ 0 0 1]; [ 1 1 0]; [ 1 0 1]; [ 0 1 1]];
    
    result = colours( floor((img_no-1)/7)+1,:);
    
end