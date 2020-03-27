function identityReducer(key,intermValIter, outKVStore)

    key

	while hasnext(intermValIter)
		value = getnext(intermValIter);
        class(key);
		add(outKVStore,key,value);
        %write("hdfs://master:9000/test_tall_output/", tall(value));
    end

end