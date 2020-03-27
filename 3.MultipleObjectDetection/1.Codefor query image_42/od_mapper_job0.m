function identityMapper(data,info,intermKVStore)

    start_ = find(info.Filename == '/',1,'last');
	end_ = find(info.Filename == '.',1,'last');
	key = info.Filename(start_+1:end_-1);
	add(intermKVStore,str2num(key),data);

end