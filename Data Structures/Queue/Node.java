//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB
public class Node<T> {
	
	private T item; //the item stored in this Node
	private Node<T> next; //the next Node
	
	//constructor
	public Node(T item, Node<T> next) {
		this.item=item;
		this.next=next;
	}
	
	//returns the item stored in this Node
	public T getItem() {
		return this.item;
	}
	
	//returns the next node
	public Node<T> getNext(){
		return this.next;
	}
	
	//changes the next node
	public void setNext( Node<T> newNext) {
		this.next= newNext;
	}
	
	//toString method
	public String toString() {
		return ""+this.getItem();
	}

}
