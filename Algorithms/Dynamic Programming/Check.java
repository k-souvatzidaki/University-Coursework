//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.io.File;
import java.util.List;

public class Check {

	public static void main(String args[]) {
		System.out.println("1) Find shortest path of leaves");
		System.out.println();
		path();
		System.out.println();
		System.out.println("2) Find the menu of 330 or less calories with the minimum amount of fats");
		System.out.println();
		knapsack();
	}

	public static void path() {
		int[] data = turnListIntoTable("dag.txt");
		ShortestPath p = new ShortestPath(data);
		p.printInput();
		p.findPath();
		p.printPath();		
	}

	public static void knapsack() {
		int[][] data = turnListsInto2Dtable("knapsack.txt");
		CaloriesFatsMenu c = new CaloriesFatsMenu(data, 330);
		c.printInput();
		c.findMenu();
		c.printMenu();		
	}
	
/* ---------------------------------------------------------------------------------------------------------------------------------*/
	
	//methods to read array data from files
	public static int[] turnListIntoTable( String fileName )
	{
		List<Integer> list = null;
		int[] data = null;

		try
		{
			File file = new File(fileName); 
			list = (List)Utilities.convertFileSequenceToList(file); // retrieve data, create Lists. 
			data = new int[list.size()]; // create 2-d table  
 			for( int i=0; i<data.length; i++ )
				data[i] = list.get(i);	
		}
		catch( Exception e )
		{
			System.out.println("- Problem with file-reading.");
		}	

		return data;
	}

	public static int[][] turnListsInto2Dtable( String fileName )
	{
		File file = new File(fileName);		
		List<List<Integer>> list = null;
		int [][] data = null;

		try
		{
			list = (List)Utilities.convertFileMatrixToListOfLists(file); // retrieve data, create Lists. 
			int rows = list.size(); // get the rows
			int columns = ((List<Integer>)list.get(0)).size(); // get the columns
			data = new int[rows][columns]; // create 2-d table  
 
			for( int i=0; i<rows; i++ )
			{
				List<Integer> rowList =  (List<Integer>)list.get(i);
				for( int j=0; j<columns; j++ )
					data[i][j] = rowList.get(j);	
			}

		}
		catch( Exception e )
		{
			System.out.println("- Problem with file-reading.");
		}	

		return data;
	}
}