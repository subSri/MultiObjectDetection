database_path = '/home/darth/project/object_database';

root_dir = '/home/darth/project/results/';
date = datestr(now,'dd-mm-yyyy');
output_id = '/1/';

db_prop = importdata('database_properties.txt');

%matrix = datastore({strcat(root_dir,date,output_id,'job2')},'Type','keyvalue','FileExtensions',{'.mat'});
matrix = datastore({'/home/cse/db_5K_Final'},'Type','keyvalue','FileExtensions',{'.mat'});
%matrix = fileDatastore('/home/cse/cbir/results/42_db','Type','keyvalue', 'ReadFcn', @load);

%fid = fopen(strcat(root_dir,date,output_id,'rank_matrix.txt'),'w');

fid = fopen('/home/cse/rank_matrix5K.txt','w');

A = zeros(42,5000)  %added 5000 by me on 07-05-2019 %db_prop(1,3));  
%A = zeros(42,24);

while hasdata(matrix)
       T = read(matrix);
       img_no = T.Key
       %img_no = str2num(img_no{1});
       rank_vector = cell2mat(T.Value)
       A(img_no,:) = rank_vector;
       %fprintf(fid,'%d ',img_no);
       %fprintf(fid,'%g ',rank_vector);
       %fprintf(fid,'\n');
end

for i=1:42   %added 5000 by me on 07-05-2019 %db_prop(1,3)
    %fprintf(fid,'%d\t\t',i);
    fprintf(fid,'%g ',A(i,:));
    fprintf(fid,'\n');
end
