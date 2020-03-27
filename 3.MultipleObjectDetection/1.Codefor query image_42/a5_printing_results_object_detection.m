%% object detection result printing

matrix = datastore({'/home/cse/DB_5K_Final'},'Type','keyvalue','FileExtensions',{'.mat'});

db_size = 5000;

actual_sum = zeros(2,db_size);
results_sum = zeros(4,db_size);

while hasdata(matrix)
    T = read(matrix);
    img_no = T.Key;
    rank_vector = cell2mat(T.Value);
    for j=1:size(rank_vector,2)
        if rank_vector(1,j) == 2
            size(rank_vector)
            img_no
            j
        end
        results_sum(rank_vector(1,j),img_no) = results_sum(rank_vector(1,j),img_no) + 1;
    end
end

counts_ = count_of_shapes_16L(db_size);

unique(results_sum);

for i=1:42
    row_ = mod(i,7);
    col_ = ceil(i/7);
    if( row_ == 0)
        row_ = 7;
    end
    actual_sum(2,i) = counts_(row_,col_); % find_occurences_db_24(i);
    actual_sum(1,i) = db_size - counts_(row_,col_);%find_non_occurences_db_24(i);
end

percentage_ = zeros(42,4);

for i=1:42
    for j=1:4
        percentage_(i,j) = (results_sum(j,i))/(actual_sum(mod(j,2)+1,i));
    end
end

A = percentage_;

A = A( ~any( isnan( A ) | isinf( A ), 2 ),: );

final_results = zeros(1,4);

for i=1:size(A,2)
    final_results(1,i) = sum(A(:,i))/ size(A,1)*100;
end

final_results
