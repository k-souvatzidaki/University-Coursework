//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

//a linear probing hash table of doubly linked list nodes with unique keys
//quick average case search (È(1)) , quick to find the least recently used Entry (O(1))

public class DLLHashTable<K, V> {

	Entry<K,V>[] entries;
	int max, size;
	Entry<K, V> last,first;

	//constructor
	public DLLHashTable(int maxSize) {
		max = maxSize; size = 0;
		entries = new Entry[max];
		last=null; first=null;
	}
	
	//add a new entry
	public void put(K key, V value) {
		int hash = hash(key);
		Entry<K,V> newEntry = new Entry<K,V>(key,value);
		//if the hash table is full
		if(isFull()) {
			int i = remove(last.key);
			last=last.prev;
			last.next=null;
			if(hash<i && hash(entries[hash].key)>i) { //to reduce collisions if possible
				entries[i]=entries[hash];
				entries[hash]=newEntry;
			}
			else entries[i]= newEntry;
		//else
		}else {
			while(entries[hash]!=null) {
				if(entries[hash].key.equals(key)) break; //no duplicate keys allowed, replace if existing key
				hash++;
				if(hash== max) hash=0;
			}
			entries[hash] = newEntry;	
			
		}
		//make the new entry first
		if(first==null) first=newEntry;
		else if(last==null) {
			last=first;
			first=newEntry;
			last.prev=first;
			last.next=null;
			first.next=last;
			first.prev=null;
		}
		else {
			first.prev= newEntry;
			newEntry.next=first;
			first=newEntry;
		}
		size++;
	}
	
	//find an existing entry. returns null if the entry doesn't exist
	//NOTE: each key is unique
	public Entry<K, V> get(K key) {
		int hash = hash(key);
		int i =0;
		while(i < max && entries[hash]!=null) {
			if(entries[hash].key.equals(key)) {
				Entry<K,V> result = entries[hash];
				//making the node first
				if(result!=first) {
					if(result==last) {
						last=result.prev; last.next=null;
					}else {
						result.prev.next=result.next;
						result.next.prev=result.prev;
					}
					first.prev=result;
					result.next=first;
					first=result; first.prev=null;
				}
				return entries[hash];
			}
			if(hash == max-1) hash=0;
			else hash++;
			i++;
		}
		return null;
	}
	
	//remove the entry with key K and return it's position in the hash table
	//return -1 if the key doesn't exist
	//NOTE: each key is unique
	public int remove(K key) {
		int hash = hash(key);
		int ret=-1;
		int i =0;
		while(i < max && entries[hash]!=null) {
			if(entries[hash].key.equals(key)) {
				entries[hash]=null; ret=hash; size--;
			}
			else{
				if(hash == max-1) hash=0; else hash++;
			}
			i++;
		}
		return ret;
	}
	
	//size methods
	public int size() {
		return size;
	}
	
	public boolean isEmpty() {
		return size==0;
	}
	
	public boolean isFull() {
		return size==max;
	}
	
	//a simple print method
	public void print() {
		System.out.println("First = "+first+" Last = "+ last);
		for(int i = 0; i < max; i++) {
			if(entries[i]!=null) {
				System.out.println(entries[i]);
			}
		}
	}
	
	//the hashing function, using the key's hashCode function
	//returns an integer in range [0.max-1]
	private int hash(K key) {
		return Math.abs(key.hashCode() % (max-1));
	}
	
}