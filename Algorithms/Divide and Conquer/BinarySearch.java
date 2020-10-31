//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.util.ArrayList;

public class BinarySearch {
	
	public static void findFirstLastPos(ArrayList<Integer> list, int x) {
		
		int f,l;
			
		f=findFirstPos(list,0,list.size()-1,x);
		if(f==-1) {
			System.out.println("Element "+x+" doesn't exist in this sequence of numbers.");
			return;
		}
		if(!list.get(f+1).equals(x)) l=f; else l=findLastPos(list,f+1,list.size()-1,x);
		
		System.out.println("First position of element "+x+" is: "+ f+ ".");
		System.out.println("Last position of element "+x+" is: "+ l+ ".");
		
	}
	
	/* PRIVATE METHODS : BINARY SEARCH */

	//binary search to find first position of element x in ArrayList list
	//TIME COMPLEXITY: Ù(1) , È(logN) , O(logN)
	private static int findFirstPos(ArrayList<Integer> list, int low, int high, int value) {
		int m;
		if(low <= high && low < list.size() && high >= 0) {
			m = (int)Math.floor((high+low)/2);
			if(( m==0 || list.get(m-1) < value) && list.get(m).equals(value)) return m; //found!
			else if(value > list.get(m)) return findFirstPos(list,m+1,high,value);
			else return findFirstPos(list,low,m-1,value);
		}
		return -1;
	}
	
	//binary search to find last position of element x in ArrayList list
	//TIME COMPLEXITY: Ù(1) , È(logN) , O(logN)
	private static int findLastPos(ArrayList<Integer> list, int low, int high, int value) {
		int m;
		if(low <= high && low < list.size() && high>=0) {
			m = (int)Math.floor((high+low)/2);
			if(( m==list.size()-1 || list.get(m+1) > value) && list.get(m).equals(value)) return m; //found!
			else if(value >= list.get(m)) return findLastPos(list,m+1,high,value);
			else return findLastPos(list,low,m-1,value);
		}
		return -1;
	}

}
