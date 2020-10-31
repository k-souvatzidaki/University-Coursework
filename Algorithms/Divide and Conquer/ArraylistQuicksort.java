//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.util.ArrayList;
import java.util.Random;

public class ArraylistQuicksort {

	public static void QuickSort(ArrayList<Integer> list) {
		quickSort(list,0,list.size()-1);
	}
	
	//3-WAY PARTITION QUICKSORT
	//TIME COMPLEXITY: Ù(Í) , È(ÍlogN) , O(N^2)
	private static void quickSort(ArrayList<Integer> list, int low, int high) {
		
		if(high <= low) return;
		
		int pivot = low + (int)(Math.random()*(high-low+1));
		
		int lo = low, hi = high, val = list.get(pivot), i =low;
		
		while(i <= hi) {
			if(list.get(i) < val) {
				exch(list,lo,i);
				lo++; i++;
			}
			else if(list.get(i) > val) {
				exch(list,hi,i);
				hi--;
			}
			else i++;
		}
		    
		quickSort(list,low,lo-1);
		quickSort(list,hi+1,high);
	
	}
	
	private static void exch(ArrayList<Integer> list, int a, int b) {
		int temp= list.get(a);
		list.set(a, list.get(b));
		list.set(b, temp);
	}
	
}
