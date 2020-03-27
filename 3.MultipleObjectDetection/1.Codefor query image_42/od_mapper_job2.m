function job1_mapper(data,~,intermKVStore)

    data.Key
    config_fid  = fopen('config.txt');
    database_path = fgetl(config_fid);
    root_dir = fgetl(config_fid)
    output_id = fgetl(config_fid)
    fclose(config_fid);
    
    db_prop = importdata('database_properties.txt');
    
    date = datestr(now,'dd-mm-yyyy');
    
    %all_imgs = datastore({strcat(root_dir,date,output_id,'job0')},'Type','keyvalue','FileExtensions',{'.mat'});
    %all_imgs = datastore({'hdfs://master:9000/results/job0/'},'Type','keyvalue','FileExtensions',{'.seq'});
    all_imgs = datastore({'hdfs://master:9000/db_5K_seq/'},'Type','keyvalue','FileExtensions',{'.seq'});
    %all_imgs = fileDatastore('hdfs://master:9000/sukhdev/mat_files/42_db/', 'ReadFcn', @load);
    
    result = zeros(1,db_prop(1,3));
    
    %% creating structure elements
    se1 = imcomplement( to_binary(data.Value{1}));

%imshow(se1);

min_x = size(se1,1);
max_x = 1;

min_y = size(se1,2);
max_y = 1;

for i=1:size(se1,1)
    for j=1:size(se1,2)
        if( se1(i,j) == 1 )
            if i < min_x
                min_x = i;
            end
            if i > max_x
                max_x = i;
            end
            if j < min_y
                min_y = j;
            end
            if j > max_y
                max_y = j;
            end
        end
    end
end

im2 = se1(min_x:max_x,min_y:max_y);
%imshow(im2);

se2 = imcomplement(im2);
se2 = padarray(se2,1,1,'both');
se2 = padarray(se2',1,1,'both');
se2 = se2';

M = zeros(size(se2));

%figure,imshow(se2);

x = se2;

for i=1:size(se2,1)
    for j=1:size(se2,2)
        if( x(i,j) == 0)
            continue;
        end
        M(i,j) = 1;
        t=x(conv2(M,[1,1,1;1,0,1;1,1,1],'same')>0);
        se2(i,j) = 0;
        if ( size(t(t == 0)) > 0 )
            se2(i,j) = 1;
        end
        M(i,j) = 0;
    end
end
    
    %%
    shapes_count = 7;
    while hasdata(all_imgs)
       T = read(all_imgs);
       class(T.Key);
       query_img_no = T.Key;%cell2mat(T.Key{1});
       query_img = cell2mat(T.Value);
       size(query_img)
       
       img1 = imcomplement( to_binary(query_img));
       r1 = bwhitmiss(img1,im2,se2);        % array r1 given
       [row,column] = find( r1 == 1);
       query_image_color = zeros(1,3);
       if( query_img(row,column,1) ~= 0)
           query_image_color(1,1) = 1;
       end
       if( query_img(row,column,2) ~= 0)
           query_image_color(1,2) = 1;
       end
       if( query_img(row,column,3) ~= 0)
           query_image_color(1,3) = 1;
       end
       
       color2 = db_42_color(data.Key);
       data.Key
       query_img_no
       color_matched = color2 == query_image_color
       
       output = -1;
       shape_no = db_42_check(data.Key);
       if( size( row,1) == 0 ) % true means no point is given by hit or miss
           % no point in output ( predicted = no)
           %if( mod((query_img_no),shapes_count) == mod((data.Key),shapes_count))
           
           if(db_16L_check(query_img_no,shape_no))
               % pred = no, actual = yes
               output = 2;
           else
               % pred = no, actual = no
               output = 4;
           end
           
       else
           % there is an output point (predicted = yes)
           % check color in image also
           %if( mod((query_img_no),shapes_count) == mod((data.Key),shapes_count))
           if( db_16L_check(query_img_no,shape_no))
           %if( db_24_check(query_img_no,shape_no))
               % pred = yes, actual = yes
               if( ~any(color_matched ==0))
                   output=1;
               else
                   output=4;
               end
           else
               % pred = yes, actual = no
               output = 3;
           end
       end
       
       data.Key;
       query_img_no;
       output;
       result(1,query_img_no) = output;
       
       %dist_(1,str2num(query_img_no)) = colour_index_comparison(cell2mat(data.Value{1}),query_img_fvect);
    end
    %%
    
    
    add(intermKVStore,data.Key,result);
end
