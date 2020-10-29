//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

import java.util.NoSuchElementException;
import java.io.PrintStream;

public class GenericList<T> {
	
	Node<T> head;
	int size;
	
	//constructor
	public GenericList(){ head=null; size=0;}
	
	//setter
	public void setHead(Node<T> newHead) {
		head=newHead;
	}
	
	//getters
	public Node<T> getHead(){
		return head;
	}
	
	public int getSize() {
		return size;
	}
	
	
	//add method
	//O(1)
	public void add(T t) {
		Node<T> newNode= new Node<T>(t,null);
		if(isEmpty()) {
			head=newNode;
		}else {
			getNode(size-1).setNext(newNode);
		}
		size++;
	}
	
	//returns true if the list contains the item s
	//O(N)
	public boolean contains(T s) {
		Node<T> temp=null;
		try {
			temp = head;
			while(temp!=null) {
				if(temp.getItem().equals(s)) return true;
				temp = temp.getNext();
			}
		}catch( NoSuchElementException e) {
			System.err.println("The list is empty");
		}
		
		return false;
	}
	
	//get node #i (ith item)
	//O(N)
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
	
	//remove item 
	//O(N)
	public Node<T> remove(T item){
		Node<T> prev = null;
		Node<T> temp;
		try {
			temp=head;
			while(temp!=null) {
		         if(temp.getItem().equals(item)) {
		        	 if(prev!=null) {
		        		 prev.setNext(temp.getNext());
		        	 }else {
		        		 head=temp.getNext();
		        	 }
		        	 return temp;
		         }
		         prev=temp;
		         temp=temp.getNext();
			}
		}catch( NoSuchElementException e) {
			System.err.println("The list is empty");
		}
		System.out.println(item + " doesn't exist in the list.");
		return null;
	}
	
	//print the list
	//O(N)
	public void print(PrintStream out) {
		Node<T> temp=head;
		while(temp!=null) {
			out.println(temp);
			temp=temp.getNext();
		}
	}
	
	//isEmpty method
	//O(1)
	public boolean isEmpty() {
		return head==null;
	}

}
