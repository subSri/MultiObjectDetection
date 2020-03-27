function iMapper(data,info,intermKVStore)
    
    data.Key
    data.Value{1}
    %if ~isnan(data.Key) && ~isnan(data.Value)
        addmulti(intermKVStore,data.Key,data.Value); %<-- this for temp job before job2
    %end
	%add(intermKVStore,data.Key,cell2mat(data.Value))
end