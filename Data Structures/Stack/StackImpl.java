//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
import java.io.PrintStream;
import java.util.NoSuchElementException;

public class StackImpl<T> implements Stack<T>{
	
	int size; //the number of elements stored in this stack
	Node<T> head; //the head of the stack
	
	//constructor
	public StackImpl() {
		this.size= 0;
		this.head= null;
	}
	
	//returns true if the stack is empty
	public boolean isEmpty() {
		return (head==null);
	}
	
	/*Inserts an item to the stack
	 *Increases the size of the stack by one*/
	public void push(T t) {
		head= new Node<T>(t,head);
		size++;
	}
	
	/*removes and returns the item on the top of the stack
	 *throws a NoSuchElementException if the stack is empty*/
	public T pop() {
		Node<T> r=null;
		try {
			r=head;
			head= head.getNext();
			size--;
		}catch( NoSuchElementException e) {
			System.err.println("The stack is empty");
		}
		return r.getItem();
	}
	
	/*returns the item on the top of the stack without removing it
	 *throws a NoSuchElementException if the stack is empty*/
	public T peek() {
		Node<T> r=null;
		try {
			r=head;
		}catch( NoSuchElementException e) {
			System.err.println("The stack is empty");
		}
		return r.getItem();
	}
	
	/*prints the elements of the stack, starting from the item on the top,
	 *to the stream given as argument. For example, 
	 *to print to the standard output you need to pass System.out as
	 *an argument. E.g., printStack(System.out); */
	public void printStack(PrintStream stream) {
		Node<T> temp=head;
		while(temp!=null) {
			stream.println(temp);
			temp=temp.getNext();
		}
	}
	
	/*returns the number of items currently in the stack*/
	public int size() {
		return size;
	}

}
