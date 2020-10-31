//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.util.ArrayList;

public class CaloriesFatsMenu {

	private int[][] foods; // 2D array. First row has the calories. Second row has the fat.
	private int C; // Total calories.
	private ArrayList<Integer> solution; // The selected products.

	public CaloriesFatsMenu( int[][] foods, int C ) {
		this.foods = foods;
		this.C = C;	
	}

	public void findMenu() {
		
		int[][] A = new int[foods[0].length+1][C+1];
		int i,j;
		
		//fill table A
		for(i =1; i<=C; i++) A[0][i]= Integer.MAX_VALUE;
		
		for(i=1; i<=foods[0].length; i++) {
			for(j=1; j<=C; j++) {
				if(j < foods[0][i-1]) { //j < calories_i
					A[i][j]= A[i-1][j];
				}else {
					A[i][j] = Math.min(addCheckForInf(foods[1][i-1] ,A[i-1][j-foods[0][i-1]]), A[i-1][j]);
				}
			}
		}
		
		//calculate result calories if a menu with the exact amount of calories being asked cannot be created
		int result=C;
		if(A[foods[0].length][C] == Integer.MAX_VALUE) {
			j=C;
			while(j>0) {
				if(A[foods[0].length][j] != Integer.MAX_VALUE) {
					result = j; break;
				}
				j--;
			}
		}
		
		//create the solution ArrayList 
		solution = new ArrayList<Integer>();
		solution.add(result);
		i=foods[0].length;
		while(i>0 || result >0 ) {
			if(A[i][result] < A[i-1][result]) {
				solution.add(i-1);
				result-= foods[0][i-1];
			}
			i--;
		}
	}

	public void printMenu() {
		if(solution!=null) {
			System.out.println("Total calories = "+solution.get(0));
			System.out.println("Foods are: ");
			for( int i=1; i<solution.size(); i++ ) {
				System.out.println(i + "] Calories: "+foods[0][solution.get(i)]+", Fats:  " + foods[1][solution.get(i)]);
			}
		}else System.out.print( " Solution for menu is empty." );
				
		System.out.println();
	}
	
	//private methods 
	//to add two integers with overflow checking
	private static int addCheckForInf(int a,int b) {
		if(a==Integer.MAX_VALUE || b== Integer.MAX_VALUE ) return Integer.MAX_VALUE;
		return a+b;
	}
	//and to find the minimum of 2 integers
	private static int min(int a , int b) {
		return a < b ? a : b;
	}


	public void printInput() {
		if( foods !=null ) {
			int rows = foods.length;
			int columns = foods[0].length;
			System.out.println("Table of foods is: ");
			for(int i=0; i<rows; i++ ) {
				for( int j=0; j<columns; j++ ) {
					System.out.print( foods[i][j]+"\t" );
				} System.out.println();
			}
		} 
		else
			System.out.println("Input table is null.");
		System.out.println( "Total calories wanted are: "+C);
	}

}