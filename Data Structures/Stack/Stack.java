//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
import java.io.PrintStream;
import java.util.NoSuchElementException;

//Defines the methods for a generic Stack
public interface Stack<T> {
  
  //returns true if the stack is empty
	public boolean isEmpty();
  
  //Inserts an item to the stack
	public void push(T t);
  
  /*removes and returns the item on the top of the stack
	 *throws a NoSuchElementException if the stack is empty*/
	public T pop() throws NoSuchElementException;
  
  /*returns the item on the top of the stack without removing it
	 *throws a NoSuchElementException if the stack is empty*/
	public T peek() throws NoSuchElementException;
	
  /*prints the elements of the stack, starting from the item on the top,
	 *to the stream given as argument. For example, 
	 *to print to the standard output you need to pass System.out as
	 *an argument. E.g., printStack(System.out); */
	public void printStack(PrintStream stream);
	
  /*returns the number of items currently in the stack*/
	public int size();
  
}
