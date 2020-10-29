//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

//a node for a tree
public class TreeNode {
	
	private WordFreq item;
	private TreeNode left;
	private TreeNode right;
	private int number;
	
	//constructor
	public TreeNode(WordFreq item) {
		this.item=item;
		left=null; right=null; 
		number=0;
	}

	//setters
	public void setSize(int n) {
		number=n;
	}
	
	public void setLeft(TreeNode left) {
		this.left=left;
	}
	
	public void setRight(TreeNode right) {
		this.right=right;
	}
	
	public void setItem(WordFreq item) {
		this.item=item;
	}
	
	
	//getters
	public int getSize() {
		return number;
	}
	
	public TreeNode getLeft() {
		return left;
	}
	
	public TreeNode getRight() {
		return right;
	}
	
	public WordFreq getItem() {
		return item;
	}
	
	//toString method
	@Override
	public String toString() {
		return item.toString();
	}

}
