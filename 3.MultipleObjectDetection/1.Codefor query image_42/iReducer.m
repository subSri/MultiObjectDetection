function identityReducer(key,intermValIter, outKVStore)

	while hasnext(intermValIter)
		value = getnext(intermValIter);
		add(outKVStore,key,value);
	end

end