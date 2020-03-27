% object detection 2 latest

setenv('HADOOP_HOME','/home/cse/hadoop-2.7.2');
setenv('HADOOP_PREFIX','/home/cse/hadoop-2.7.2');

cluster = parallel.cluster.Hadoop;
%cluster=parallel.cluster.MJS;
cluster.HadoopProperties('mapred.job.tracker') = 'master:9008';
cluster.HadoopProperties('fs.default.name') = 'hdfs://master:9000/';

tic;

% loading configuration
config_fid  = fopen('config.txt');
database_path = fgetl(config_fid);
root_dir = fgetl(config_fid);
output_id = fgetl(config_fid);
fclose(config_fid);

mapreducer(gcp); %gcp

spmd
    setenv HADOOP_HOME /home/cse/hadoop-2.7.2;
    matlab.io.datastore.internal.hadoopLoader();
end


mapreducer(gcp); %gcp
%%
output_folder= '/home/cse/db_5K_Final/';
ds2 = datastore({'hdfs://master:9000/query_db_42_seq/'},'Type','keyvalue','FileExtensions',{'.seq'}); %query imges here
%ds2 = fileDatastore('hdfs://master:9000/sukhdev/seq_files/198_db/', 'ReadFcn', @load);

% JOB 1 finding shapes
system('rm -r /home/cse/db_5K_Final');
ds3 = mapreduce(ds2,@od_mapper_job2,@od_reducer_job2,'OutputFolder',output_folder);

toc;
