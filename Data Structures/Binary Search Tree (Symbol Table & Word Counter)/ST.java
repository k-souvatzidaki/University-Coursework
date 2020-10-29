//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Comparator;
import java.util.Scanner;

//a symbol table for WordFreq items, using a binary search tree

public class ST {

	private TreeNode head;
	private GenericList<String> stopwords;
	private int totalWords;
	private WordFreq maxFreq;
	private Comparator<WordFreq> c;
	
	//default constructor
	public ST() {
		head=null;
		stopwords= new GenericList<String>();
		totalWords=0;
		maxFreq=null;
		c =new Comparator<WordFreq>() {
			@Override
			public int compare(WordFreq w1, WordFreq w2) {
				return w1.key().toUpperCase().compareTo(w2.key().toUpperCase()); //default comparator -> compare by words
			}
		};
	}
	
	//constructor with a custom comparator
	public ST(Comparator<WordFreq> c) {
		head=null;
		stopwords= new GenericList<String>();
		totalWords=0;
		maxFreq=null;
		this.c = c;
	}
	
	public TreeNode getHead() {
		return head;
	}
	
	public void setHead(TreeNode head) {
		this.head=head;
	}
	
	public void setNumOfWords(int i) {
		totalWords=i;
		
	}
	
	 /*******************************************/
    /* s y m b o l  t a b l e  m e t h o d s   */
   /*******************************************/
	
	//O(N)
	public void insert(WordFreq item) {
		head = insertR(head,item);
		totalWords++;
	}
	
	//O(N)
	public void update(String w) {
		if(head==null) {
			insert(new WordFreq(w));
			maxFreq=head.getItem();
		}
		else {
			TreeNode r = searchR(head,w);
			if(r!=null) {
				totalWords++;
				r.getItem().incrFreq();
				if(r.getItem().freq() > maxFreq.freq() || (r.getItem().freq()==maxFreq.freq() && c.compare(r.getItem(),maxFreq) < 0))
					maxFreq=r.getItem();
			}else {
				insert(new WordFreq(w));
			}
		}
	}
	
	//O(N)
	public WordFreq search(String w) {
		TreeNode key = searchR(head,w);
		if(key!=null) return key.getItem();
		System.out.println("Word "+w+" doesn't exist");
		return null;
	}
	
	//O(N)
	public void remove(String w) {
		int temp = totalWords;
		head = deleteR(head,w);
		if(totalWords==temp) System.out.println("Word "+w + " doesn't exist.");
		else System.out.println("Word "+w + " deleted successfully.");
		if(maxFreq==null && head!=null) {
			maxFreq = head.getItem();
			findNewMaxFreq(head);
		}
	}
	
	//O(N^2)
	public void load(String filename) {
		
		System.out.println("Loading file " + filename + ". . . ");
		Scanner in = null;
		
		try {
			in = new Scanner(new File(filename));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		
		String word;
		while(in.hasNext()) {
			word=in.next();
			int i=0;
			while(i < word.length()) {
				if(Character.isDigit(word.charAt(i))) {
					word=null;
					break;
				}
				if(!Character.isLetter(word.charAt(i))) {
					if(!(i < word.length()-1 && word.charAt(i)==39)){
						word = word.substring(0,i) + word.substring(i+1);
					}else {
						i++;
					}
				}else {
					i++;
				}
			}
			
			if(word!=null && !stopwords.contains(word.toUpperCase())) update(word);
		}
		
		System.out.println("File "+ filename+" loaded successfully! ");
		
	}
	
	//O(1)
	public int getTotalWords() {
		return totalWords;
	}
	
	//O(1)
	public int getDistinctWords() {
		if(head==null) return 0;
		return head.getSize() + 1;
	} 
	
	//O(N)
	public int getFrequency(String w) {
		WordFreq r = search(w);
		if(r==null) return 0;
		return r.freq();
	}
	
	//O(1)
	public WordFreq getMaximumFrequency() {
		return maxFreq;
	}
	
	//O(1)
	public double getMeanFrequency() {
		return (double)totalWords / (head.getSize()+1);
	}
	
	//O(stopwords.size)
	public void addStopWord(String w) {
		if(!stopwords.contains(w.toUpperCase())) {
			stopwords.add(w.toUpperCase());
			System.out.println("Added stopword "+w);
		}else {
			System.out.println("Stopword "+w+" already exists.");
		}	
	}
	
	//O(stopwords.size)
	public void removeStopWord(String w) {
		stopwords.remove(w.toUpperCase());
	}
	
	//using in-order traversal 
	//O(N)
	public void printAlphabetically(PrintStream out) {
		inorder(head,out);
	}
	
	//O(N^2)
	public void printByFrequency(PrintStream out) {
		if(head==null) return;
		
		//creating a new BST that compares the words by their frequency
		ST temp = new ST(new Comparator<WordFreq>() {
			@Override
			public int compare(WordFreq w1, WordFreq w2) { //compare by frequencies
				if(w1.freq() < w2.freq()) return 1; 
				if(w1.freq() > w2.freq()) return -1;
				return 0;
			}
		});
		
		insertToNewTree(head,temp);
		
		temp.printAlphabetically(out);
	}
	
	
	 /*******************************************/
	/*    p r i v a t e     m e t h o d s      */
   /*******************************************/
	

	 /* !- binary search tree recursive node insertion -! 
	  * complexity: O(N) */
	 private TreeNode insertR(TreeNode head , WordFreq item) {

		if(head==null) return new TreeNode(item);
		
		//increase the size of the node
		head.setSize(getSize(head)+1);

		//insert the node as a leaf
		//Binary Search Tree insertion recursive algorithm
		if(c.compare(item, head.getItem()) <0) { 
			head.setLeft(insertR(head.getLeft(),item));
		}
		else {
			head.setRight(insertR(head.getRight(),item));
		}
		
		return head;
		
	}
	
	/* !- binary search tree recursive node deletion -! 
	 * complexity: O(N) */
	 private TreeNode deleteR(TreeNode head, String key) {
		 
		 if(head==null) return head;
		 
		 //Binary Search Tree deletion algorithm
		 if(key.toUpperCase().compareTo(head.getItem().key().toUpperCase()) < 0) {
			head.setLeft(deleteR(head.getLeft(),key));
		 } 
		 else if(key.toUpperCase().compareTo(head.getItem().key().toUpperCase()) > 0) {
			 head.setRight(deleteR(head.getRight(),key));
		 }
		 else {
			
			 //reducing the total words
			 totalWords-=head.getItem().freq();
			 //if the node is the maximum frequency node
			 //set the maxFreq to null
			 if(head.getItem() == maxFreq) maxFreq=null;
			 
			 //performing standard binary search tree deletion 
			 //case 1: a node with only one or no children
			 if(head.getLeft()==null) return head.getRight();
			 if(head.getRight() == null) return head.getLeft();
			
			 //case 2: a node with two children
			 //replace the node with the largest leaf in it's subtree
			 //and set the leaf to null
			 TreeNode newhead = max(head.getLeft());
			 head.setItem(newhead.getItem());
			 newhead.getItem().setFreq(0);
			 
			 head.setLeft(deleteR(head.getLeft(),newhead.getItem().key()));

		 }
		
		 //decrease the node's size
		 head.setSize(head.getSize()-1);
		
		 return head;
	 }
	 
	 
	 /* !- binary search tree recursive search algorithm -! 
	  * !- if the node is found and it's word's frequency is greater than 
	  * the average frequency of all words in this tree, rotations are performed 
	  * and the node becomes the tree's root (rotation complexity: O(1)) -!
	  * 
	  * complexity: O(N) */
	 private TreeNode searchR(TreeNode head, String key) {
		 
		 //if the node is found
		 if (head==null || head.getItem().key().toUpperCase().equals(key.toUpperCase())) {
			 return head; 
		 }
		  
		 TreeNode result=null;
		 
		 if(key.toUpperCase().compareTo(head.getItem().key().toUpperCase()) < 0) {
			//search in the left subtree
			result = searchR(head.getLeft(),key);
			//check if the item that was found was a frequency greater than the average frequency
			//always checking current node's grand children
			//perform rotations to bring the found node on the root
			if(result!=null)
			if(result.getItem().freq()>getMeanFrequency()) {
				if(head.getLeft()!=null) {
					//if the left grand child is the found node, rotate right the left child ( the found node's parent )
					if(head.getLeft().getLeft()==result) head.setLeft(rotateR(head.getLeft())); 
					//if the right grand child is the found node, rotate left the left child ( the found node's parent )
					else if(head.getLeft().getRight()==result) head.setLeft(rotateL(head.getLeft()));
					//if the found node is a child of the tree's head, rotate the head right
					if(head==this.head && head.getLeft()==result) this.head= rotateR(this.head);
				}
			}
		 } 
		 else if(key.toUpperCase().compareTo(head.getItem().key().toUpperCase()) > 0) {
			//search in the right subtree
			result = searchR(head.getRight(),key);
			//check if the item that was found was a frequency greater than the average frequency
			//always checking current node's grand children
			//perform rotations to bring the found node on the root
			if(result!=null)
			if(result.getItem().freq()>getMeanFrequency()) {
				if(head.getRight()!=null) {
					//if the right grand child is the found node, rotate left the right child ( the found node's parent )
					if(head.getRight().getRight()==result) head.setRight(rotateL(head.getRight()));
					//if the left grand child is the found node, rotate right the right child ( the found node's parent )
					else if(head.getRight().getLeft()==result) head.setRight(rotateR(head.getRight()));
					//if the found node is a child of the tree's head, rotate the head left
					if(head==this.head && head.getRight()==result) this.head= rotateL(this.head);
				}
			}	
		}
		return result;
	}
	 
	 
	 /* !- in-order traversal -!
	  * complexity: O(N) */
	 private void inorder(TreeNode head, PrintStream out) {
		if(head==null) return;
		inorder(head.getLeft(),out);
		out.println(head.getItem());
		inorder(head.getRight(),out);
	 }

	/* !- rotations -!
	 * complexity: O(1) */
	private TreeNode rotateR(TreeNode head) { //left rotation
		//size
		int temp =head.getSize();
		if(head.getRight()!=null && head.getLeft()!=null) {
			head.setSize(getSize(head.getRight()) + getSize(head.getLeft().getRight()) + 1 + (head.getLeft().getRight()==null ? 0 : 1) );
		}else if(head.getLeft()!=null && head.getRight()==null) {
			head.setSize(getSize(head.getLeft().getRight()) + (head.getLeft().getRight()==null ? 0 : 1) );
		}else {
			head.setSize(0);
		}
		if(head.getLeft() !=null) head.getLeft().setSize(temp);
		//performing the rotation
		TreeNode x= head.getLeft();
		head.setLeft(x.getRight());
		x.setRight(head);
		return x;
	}
		
	private TreeNode rotateL(TreeNode head) { //right rotation
		//size
		int temp =head.getSize();
		if(head.getLeft()!=null && head.getRight()!=null) {
			head.setSize(getSize(head.getLeft()) + getSize(head.getRight().getLeft()) + 1 + (head.getRight().getLeft()==null ? 0 : 1) );
		}else if(head.getLeft()==null && head.getRight()!=null) {
			head.setSize(getSize(head.getRight().getLeft()) + (head.getRight().getLeft()==null ? 0 : 1) );
		}else {
			head.setSize(0);
		}
		if(head.getRight() !=null) head.getRight().setSize(temp);	
		//performing the rotation
		TreeNode x= head.getRight();
		head.setRight(x.getLeft());
		x.setLeft(head);
		return x;
	}
	
	
	/* copies all the elements of this tree to a new one
	 * complexity: O(N^2) */
	private void insertToNewTree(TreeNode head, ST newTree) {
		newTree.insert(head.getItem());
		if(head.getRight()!=null) insertToNewTree(head.getRight(),newTree);
		if(head.getLeft()!=null) insertToNewTree(head.getLeft(),newTree);
	}

	/*returns the greatest node of a subtree
	 *complexity : O(N) */
	private TreeNode max(TreeNode root) {
	
		while (root.getRight() != null) {
			root = root.getRight(); 
		} 
		return root; 
	} 	
	
	
	/*finds the node with the maximum frequency inside this tree
	 * complexity: O(N) */
	 private void findNewMaxFreq(TreeNode head) {
		 if(head.getItem().freq() > maxFreq.freq() || (head.getItem().freq()==maxFreq.freq() && head.getItem().key().toUpperCase().compareTo(maxFreq.key().toUpperCase())<0)) {
			maxFreq=head.getItem();
		 }
		 if(head.getLeft()!=null) findNewMaxFreq(head.getLeft());
		 if(head.getRight()!=null) findNewMaxFreq(head.getRight());
	 }
	
	/*returns the size of a node
	 *(used to avoid NullPointerExceptions) */
	private int getSize(TreeNode head) {
		if(head==null) return 0;
		return head.getSize();
	}

	
	
}