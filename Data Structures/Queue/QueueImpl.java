//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
import java.io.PrintStream;
import java.util.NoSuchElementException;

public class QueueImpl<T> implements Queue<T> {
	
	Node<T> head,tail;
	int size;
	
	//constructor
	public QueueImpl() {
		tail= head= null;
		size=0;
	}
	
	//returns true if the queue is empty
	public boolean isEmpty() {
		return (head==null);
	}
	
	//inserts an item to the queue
	public void put(T t) {
		if(isEmpty()) {
			head=tail=new Node<T>(t,null);
		}else {
			Node<T> tail2 =new Node<T>(t,null);
			tail.setNext(tail2);
			tail=tail2;
		}
		size++;
	}
	
	/*removes and returns the oldest item of the queue
	 *throws NoSuchElementException if the queue is empty*/
	public T get() {
		Node<T> r=null;
		try {
			r=head;
			head= head.getNext();
			size--;
		}catch( NoSuchElementException e) {
			System.err.println("The queue is empty");
		}
		return r.getItem();
		
	}
	
	/*returns the oldest item of the queue without removing it
	 *throws NoSuchElementException if the queue is empty*/
	public T peek() {
		Node<T> r=null;
		try {
			r=head;
		}catch( NoSuchElementException e) {
			System.err.println("The queue is empty");
		}
		return r.getItem();
		
	}
	
	/*prints the elements of the queue, starting from the oldest 
     *item, to the print stream given as an argument. For example, to 
     *print the elements to the standard output,pass System.out as parameter.
	 *E.g., printQueue(System.out);*/
	public void printQueue(PrintStream stream) {
		Node<T> temp=head;
		while(temp!=null) {
			stream.println(temp);
			temp=temp.getNext();
		}
	}
	
	//returns the size of the queue
	public int size() {
		return size;
	}
	
}