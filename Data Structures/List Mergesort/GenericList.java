//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

import java.io.PrintStream;
import java.util.NoSuchElementException;

public class GenericList<T> {
	
	Node<T> head;
	int size;
	
	public GenericList(){ head=null; size=0;}
	
	public boolean isEmpty() {
		return head==null;
	}
	
	public void setHead(Node<T> newHead) {
		head=newHead;
	}
	
	public Node<T> getHead(){
		return head;
	}
	
	public int getSize() {
		return size;
	}
	
	public void add(T t) {
		Node<T> newNode= new Node<T>(t,null);
		if(isEmpty()) {
			head=newNode;
		}else {
			getNode(size-1).setNext(newNode);
		}
		size++;
	}
	
	public Node<T> getNode(int i) {
		Node<T> temp=null;
		try {
			temp = head;
			int cnt=0;
			if(i<size) {
				while(cnt<i) {
					temp=temp.getNext();
					cnt++;
				}
			}else {
				System.out.println("The list doesn't have "+ i+" elements.");
			}
		}catch( NoSuchElementException e) {
			System.err.println("The list is empty");
		}
		return temp;
	}

}
