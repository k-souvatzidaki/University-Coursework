//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Scanner;

public class Check {

	public static void main( String args[] ) {
		System.out.println("1) Find first and last position of an element x in a sorted array");
		System.out.println();
		bin();
		System.out.println();
		System.out.println("2) Sort an array using 3-way partition QuickSort");
		quick();
	}

	private static void bin() {			
		Scanner in = new Scanner(System.in);
		ArrayList<Integer> numbers = null;
		
		System.out.print("Give an x: ");
		int x = Integer.parseInt(in.nextLine());
		System.out.println();
		
		try {
			numbers= (ArrayList<Integer>)Utilities.convertFileSequenceToList(new File("sorted.txt"));
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		BinarySearch.findFirstLastPos(numbers,x);	
	}

	public static void quick() {
		ArrayList<Integer> numbers = null;
		
		try {
			numbers= (ArrayList<Integer>)Utilities.convertFileSequenceToList(new File("unsorted.txt"));
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		System.out.println("ArrayList unsorted: ");
		for(int i : numbers) System.out.print(i + " ");
		System.out.println();
		
		ArraylistQuicksort.QuickSort(numbers);
		
		System.out.println("ArrayList sorted: ");
		for(int i : numbers) System.out.print(i + " ");
	}

}