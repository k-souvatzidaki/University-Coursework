import java.util.*;
import java.util.Map.Entry;

public class VertexCover {

	static HashMap<String,ArrayList<String>> network;
	
	//global variable to help stop the search if the wanted student subset (vertex cover) is found 
    static boolean found = false; //used on the brute force solution
    //array with the names of the students. used to create subsets and sort
	static String[] keys;

    //the solutions
    static ArrayList<String> brute_force_solution = new ArrayList<String>();
    static float brute_force_time=0;
    static ArrayList<String> greedy_solution = new ArrayList<String>();
    static float greedy_time=0;
    
    
	public VertexCover( HashMap<String, ArrayList<String>> network ) {
		this.network = network;
	}
	
	public void findCovers() {
		keys = new String[network.size()];
		int i = 0;
		for(String key : network.keySet()) {
			keys[i]=key;
			i++;
		}
		
		//brute force solution
		create_exhaustive_solution();
		
		//greedy solution
		create_greedy_solution();
	}
	

	//create the exhaustive solution
	static void create_exhaustive_solution() {
		long start = System.currentTimeMillis();
		for(int i =1; i <= keys.length && found == false; i++) {
			String[] subset = new String[i];
	    	find_subset(subset,0,0);
		}
		long end = System.currentTimeMillis();
		brute_force_time = (end - start) / 1000F;
	}
	
	
	//create the greedy solution
	static void create_greedy_solution() {
		long start = System.currentTimeMillis();
		
		HashMap<String,ArrayList<String>> copy = deep_copy(network);
		int nodes = copy.size();
		
		while(nodes > 0) {
			//find the student with the most edges
			String max_student = null;
			int max_edges = 0;
			for(String key: keys) {
				int sum =0;
				for(String v : copy.get(key)) sum++;
				if(sum > max_edges) { max_student = key; max_edges = sum;}
			}
			
			greedy_solution.add(max_student);
			
			for(String key : copy.get(max_student)) {
				if(copy.get(key).contains(max_student)) copy.get(key).remove(max_student);
			}
			copy.get(max_student).clear();
			
			nodes = copy.size();
			for(String key : copy.keySet())
				if(copy.get(key).isEmpty()) nodes--;
			
		}
		long end = System.currentTimeMillis();
		
		greedy_time = (end - start) / 1000F; 
	}
	
	
	
	
	/* find all the student subsets of size i 
	 * divide and conquer algorithm */
	static void find_subset(String[] subset,int index, int i) {
		//subset created!
		if (index == subset.length) {
    		if(isVertexCover(subset)) {
    			for (int j = 0; j < subset.length; j++) {
    				brute_force_solution.add(subset[j]);
    			}
    			found = true;
    		}
    		
            return; 
        }
    	
        if (i >= keys.length) 
            return; 
        
        
        subset[index] = keys[i]; 
        find_subset(subset,index+1,i+1);
        
        if(found == true) return;
       
        find_subset(subset,index,i+1);
        
        if(found == true) return;
	}
	
	//check if a subset is a vertex cover - if its students cover all edges
	static boolean isVertexCover(String[] subset) {
		//create a deep copy of the original network
		HashMap<String,ArrayList<String>> copy = deep_copy(network);
		
		for(String s : subset) {
			for(String key : copy.get(s)) {
				if(copy.get(key).contains(s)) copy.get(key).remove(s);
			}
			copy.get(s).clear();
		}
		
		int nodes = copy.size();
		for(String key : copy.keySet())
			if(copy.get(key).isEmpty()) nodes--;
		
		return nodes==0;
	}
	
	static HashMap<String,ArrayList<String>> deep_copy(HashMap<String,ArrayList<String>> map){
		HashMap<String, ArrayList<String>> copy = new HashMap<String,ArrayList<String>>();
		for (Entry<String, ArrayList<String>> entry : map.entrySet()) {
	        copy.put(entry.getKey(), new ArrayList<String>(entry.getValue()));
	    }
		return copy;
	}
	
	/********** print methods ***********/

	public void printCovers() {
		if(brute_force_solution.size()!=0) {
			System.out.print("Brute force solution: ");
			for( int i=0; i<brute_force_solution.size(); i++ ) {
				System.out.print(brute_force_solution.get(i)+" " );
			}
			System.out.println( " "+brute_force_time+" seconds" );
		}
		
		if(greedy_solution.size()!=0) {
			System.out.print("Greedy solution: ");
			for( int i=0; i<greedy_solution.size(); i++ ) {
				System.out.print(greedy_solution.get(i)+" " );
			}
			System.out.println( " "+greedy_time+" seconds" );
		}
	}
	
	
	public void printInput() {
		if( network !=null ) {
			System.out.println( "Size of Adjacency-List: "+network.size() );
			for (String key   : network.keySet()) {
				System.out.print( "-Node "+key+" has neighbors: "); 
			    for(String value : network.get(key))  System.out.print(value+", ");
			    System.out.println();
			}
		} else System.out.println("Input table is null.");
	}
	
}