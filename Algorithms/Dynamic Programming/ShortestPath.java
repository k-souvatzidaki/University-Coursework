//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB

public class ShortestPath {

	//array to store the leaves
	private int[] leaves;
	//arrays to store subproblem solutions (number of leaves and previous leaves)
	private int[] sub,prev;
	//array to store final solution
	private int[] solution;

	public ShortestPath( int[] leaves ) {
		this.leaves = leaves;
		sub = new int[leaves.length];
		prev = new int[leaves.length];
	}

	public void findPath() {
		if(leaves!=null) {
			sub[0]=1; prev[0]=1;
			int min,i;
			for(i = 1; i<leaves.length; i++) {
				min= Integer.MAX_VALUE;
				for(int j = 0; j < i; j++)
					if(i-j <= leaves[j])
						if(sub[j] < min) { 
							min=sub[j];
							prev[i]=j+1;
						}
				sub[i]=min+1;
			}

			//create the solution
			solution = new int[sub[leaves.length-1]+1];
			solution[0] = sub[leaves.length-1];
			solution[solution.length-1]= leaves.length; 
			for(i = solution.length-2; i > 1; i--) {
				solution[i]=prev[solution[i+1]-1];
			}
			solution[1]=1;
			
		}else {
			System.out.println("Input leaves array is not initialized.");
		}
	}

	public void printPath() {
		int i;
		if(solution!=null) {
			System.out.print("Solution = Number of leaves: "+ solution[0] +", leaves are: ");
			System.out.print("{");
			for(i = 1; i< solution.length-1; i++) {
				System.out.print(solution[i]+", ");
			}
			System.out.print(solution[i]+"}");
		}else
			System.out.print( "Solution for shortest path is empty." );
				
		System.out.println();
	}

	public void printInput() {
		if( leaves !=null ){
			System.out.println("List of leaves is: ");
			for( int i=0; i<leaves.length; i++ ) {
				System.out.print( leaves[i]+" " );
			}
			System.out.println();
		} 
		else System.out.println("Input table is null.");
	}

}