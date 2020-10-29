//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
import java.util.Comparator;

//a priority queue of Song objects implemented using a max heap
public class PQ {
	
	Song[] heap; //the heap using an array
	Song[] songsById = new Song[10000]; //storing songs based on their id
	private int maxsize; //maximum size (size of the array)
	private int size; //current elements in queue
	protected Comparator<Song> c; //a comparator for Song objects

	//default constructor
	public PQ() { 
		size=0; 
		maxsize=5;
		heap= new Song[maxsize];
		c=new Comparator<Song>() {
			@Override
			public int compare(Song t1, Song t2) { //reverse comparator
				return ((Comparable<Song>)t1).compareTo(t2);
			}
		}; 
	}
	
	//constructor with maxsize parameter
	public PQ(int maxsize) {
		size=0;
		this.maxsize=maxsize;
		heap= new Song[maxsize];
		c=new Comparator<Song>() {
			@Override
			public int compare(Song t1, Song t2) { //reverse comparator
				return ((Comparable<Song>)t1).compareTo(t2);
			}
		};
	}
	
	//constructor with maxsize and comparator
	public PQ(int maxsize, Comparator<Song> c) {
		size=0;
		this.maxsize=maxsize;
		heap= new Song[maxsize];
		this.c=c;
	}
	
	
	//isEmpty
	//O(1)
	public boolean isEmpty() {
		return size==0;
	}
	
	//size
	//O(1)
	public int size() {
		return size;
	}
	
	//inserts a new song
	//O(logn)
	public void insert(Song song) {				
		if(size>= (maxsize*75)/100){
			resize();
		}
		heap[++size]=song;
		songsById[song.getId()]=song;
		swim(size);
    }
	
	//return max and removes it
	//O(logn)
	public Song getMax() {
		if(isEmpty()){
			throw new IllegalStateException();
		}else{
			Song temp= heap[1];
			if(size>1) heap[1]=heap[size];
			heap[size--]=null;
			songsById[temp.getId()]=null;
			sink(1);
			return temp;
		}
    }
	
	//returns max without removing it
	//O(1)
	public Song max() {
		if(isEmpty()){
			throw new IllegalStateException();
		}else{
			return heap[1];
		}
	}
	
	//removes song by id
	//O(logn)
	public Song remove(int id) {
		if(isEmpty()){
			throw new IllegalStateException();
		}else {
			Song r= songsById[id];
			//binary search to find the song
			//the max heap is a sorted binary tree
			//O(logn)
			int right=size;
			int left=1; 
			while(right>= left) {
				int m= right+1 /2;
				if(heap[m]==r) {
					//removing the song
					//o(logn) (sink)
					heap[m]=heap[size]; //song in posiition m= last song, last song= song to be removed
					heap[size--]=null; //removing last song
					songsById[id]=null;
					sink(m); //song in position m must find it's place again
					return r;
				}else {
					if(left < m) {
						right=m-1;
					}else { left=m+1; }
				}
			}
		}
		System.out.println("The song with this id doesn't exist");
		return null;
	}
	
	
	//swim method
	//when a new song is inserted
	private void swim(int i) {
		if(i==1) { 
			return;
		}else{
			while(i>1){
				if(c.compare(heap[i],heap[i/2])<=0) return;
					else {swap(i,i/2); i=i/2;}
				}
			}
	    }
	
	//sink
	//when a song is removed
	 private void sink(int i) {
	        while (2*i <= size) {
	            int j = 2*i;
	            if (j < size && c.compare(heap[j], heap[j+1])<0) j++;
	            if (c.compare(heap[i], heap[j])>0) break;
	            swap(i, j);
	            i = j;
	        }
	    }
	 
	//swap method
	private void swap(int i, int j) {
		Song tmp = heap[i];
        heap[i] = heap[j];
        heap[j] = tmp;
    }
	
	//resize method
	private void resize() {
		maxsize*=2;
		Song[] temp= new Song[maxsize];
		for(int i=1;i<=size;i++) {
			temp[i]=heap[i];
		}
		heap=temp;
	}
	
}