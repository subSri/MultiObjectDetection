% reading sequence file from hdfs and converting to hadoop sequence file

setenv('HADOOP_HOME','/home/cse/hadoop-2.7.2');
setenv('HADOOP_PREFIX','/home/cse/hadoop-2.7.2');

cluster = parallel.cluster.Hadoop;
%cluster=parallel.cluster.MJS;
cluster.HadoopProperties('mapred.job.tracker') = 'master:9008';
cluster.HadoopProperties('fs.default.name') = 'hdfs://master:9000/';

tic;

%% hadoop job

% system('hdfs dfs -rm -r hdfs://master:9000/mat_files/job0');
% system('hdfs dfs -mkdir hdfs://master:9000/mat_files/job0');
% system('hdfs dfs -put /home/cse/results/job0/* hdfs://master:9000/mat_files/job0');

mapreducer(cluster);
%system('hdfs dfs -rm -r hdfs://master:9000/DB_16L_hadoop_seq');
%dsx = fileDatastore('hdfs://master:9000/DB_16L_Seq/', 'ReadFcn', @load);
%ds2 = mapreduce(dsx, @my_mapper, @identityReducer, 'OutputFolder', 'hdfs://master:9000/DB_16L_hadoop_seq');

%system('hdfs dfs -rm -r hdfs://master:9000/query_db_42_seq');
system('hdfs dfs -rm -r hdfs://master:9000/db_5K_seq');


dsx = fileDatastore('hdfs://master:9000/db_5K_mat/', 'ReadFcn', @load);
ds2 = mapreduce(dsx, @my_mapper, @iReducer, 'OutputFolder', 'hdfs://master:9000/db_5K_seq/');


toc;