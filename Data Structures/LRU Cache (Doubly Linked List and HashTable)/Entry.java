//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

//a hash table entry, also a doubly linked list node

public class Entry<K ,V>{
	
	K key;
	V value;
	Entry<K, V> prev,next;
		
	public Entry(K key, V value) {
		this.key=key; this.value=value;
		prev=null; next=null;
	}
	
	//toString method
	public String toString() {
		return "Key = " + key + " Value = " + value +".";
	}
	
}