//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

//a cache memory with LRU removal, using a DLLHashTable

public class CacheImpl<K, V> implements Cache<K, V> {
	
	DLLHashTable<K,V> cache;
	long hits, misses, lookups;
	
	//constructors
	public CacheImpl(int max) {
		cache = new DLLHashTable<K,V>(max);
		hits=0; misses=0; lookups=0;
	}
	
	
	//cache interface methods
	
	public V lookUp(K key) {
		V result = null; 
		Entry<K,V> entry = cache.get(key);
		if(entry==null) misses++; else {
			hits++; result=entry.value;
		}
		lookups++;
		return result;
	}

	public void store(K key, V value) {
		cache.put(key,value);
	}

	public double getHitRatio() {
		return (double)hits/lookups;
	}

	public long getHits() {
		return hits;
	}

	public long getMisses() {
		return misses;
	}

	public long getNumberOfLookUps() {
		return lookups;
	}

}
