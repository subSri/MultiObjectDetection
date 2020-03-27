% local sequence file creation 21-4-19


tic;


mapreducer(0);

%database_path = '                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              ';
%output_folder = '/home/cse/cbir/results/Database_1681470/';

database_path = '/home/cse/18-05-2019/db_5K';
output_folder = '/home/cse/18-05-2019/db_5K_mat';

%%

system('rm -r /home/cse/18-05-2019/db_5K_mat');

ds = datastore({database_path},'Type','image','FileExtensions',{'.png'});

% tT = tall(ds);
% 
% [tKeys, tVals] = matlab.tall.transform(@od_mapper_job0, tT);
% tGrps = findgroups(tKeys);
% result = splitapply(@(keys, vals) matlab.tall.reduce(@myReducer, keys,vals), tKeys, tVals, tGrps);
% write('hdfs://master:9000/test_tall_output',result,'FileType','seq');


%JOB 0 creating sequence file for image database
ds1 = mapreduce(ds,@od_mapper_job0, @od_reducer_job0,'OutputFolder',output_folder);

    

toc;