function reduceCountWords(intermkey, intermValIter, outKVStore)

results = getnext(intermValIter);

add(outKVStore,intermkey,results);

end