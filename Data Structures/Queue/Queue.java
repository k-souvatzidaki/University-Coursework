//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
import java.io.PrintStream;
import java.util.NoSuchElementException; 

//Defines the methods for a generic FIFO queue
public interface Queue<T> {
  
	//returns true if the queue is empty
	public boolean isEmpty();
  
	//inserts an item to the queue
	public void put(T t);
  
	/*removes and returns the oldest item of the queue
	 *throws NoSuchElementException if the queue is empty*/
	public T get() throws NoSuchElementException;
  
	/*returns the oldest item of the queue without removing it
	 *throws NoSuchElementException if the queue is empty*/
	public T peek() throws NoSuchElementException;
  
	/*prints the elements of the queue, starting from the oldest 
     *item, to the print stream given as an argument. For example, to 
     *print the elements to the standard output,pass System.out as parameter.
	 *E.g., printQueue(System.out);*/
	public void printQueue(PrintStream stream);
  
	//returns the size of the queue
	public int size();
  
}
