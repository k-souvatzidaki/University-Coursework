//Konstantina Souvatzidaki, p3170149, Department of Informatics AUEB
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Queue;

public class ShortestCycle {

	static HashMap<String, ArrayList<String>> graph;
	//distances
	static HashMap<String,Integer> dist = new HashMap<String,Integer>();
	//previous vertices in shortest path
	static HashMap<String,String> prev = new HashMap<String,String>();
	//the solution
	static ArrayList<String> solution_cycle = new ArrayList<String>();
	
	private String name1;
	private String name2;

	public ShortestCycle( HashMap<String, ArrayList<String>> graph, String name1, String name2 ) {
		this.graph = graph;
		this.name1 = name1;
		this.name2 = name2;
		for(String key: graph.keySet()) { dist.put(key, Integer.MAX_VALUE); prev.put(key, null); }
	}

	public void findCycle() {
		ArrayList<String> temp_cycle = new ArrayList<String>();
		
		//find shortest path from the first philosopher to all philosophers
		BFS(name1);		
		
		String to = name2;
		//find shortest path from start to finish philosopher, if it exists
		int length = dist.get(to);
		
		
		//if a path exists: 
		if(length != Integer.MAX_VALUE) {
			while(prev.get(to)!=null) {
				temp_cycle.add(to);
				//remove the edge that was used
				graph.get(to).remove(prev.get(to));
				graph.get(prev.get(to)).remove(to);
				
				to=prev.get(to);
			}
			temp_cycle.add(name1);
					
			//add this path to the solution
			for(int i = temp_cycle.size()-1; i>=0; i--) solution_cycle.add(temp_cycle.get(i));
			
			temp_cycle.clear();
			
			//find the shortest path from the second philosopher to all philosophers
			BFS(name2);
			
			to = name1;
			//find shortest path from finish to start philosopher
			length = dist.get(to);
			//if a path exists
			if(length != Integer.MAX_VALUE) {
				while(prev.get(to)!=null) {
					temp_cycle.add(to);
					to=prev.get(to);
				}
				
				//add this path to the solution
				for(int i = temp_cycle.size()-1; i>= 0; i--) solution_cycle.add(temp_cycle.get(i));
				
			}else solution_cycle.clear();
		}
	}

	//BFS SEARCH 
	private static void BFS(String from) {
		//set all distances to infinity and all previous nodes to null
		for(String val : graph.keySet()) {
			dist.replace(val, Integer.MAX_VALUE);
			prev.replace(val, null);
		}
		
		Queue<String> queue = new LinkedList<String>();
		queue.add(from);
		dist.replace(from, 0);
		while(!queue.isEmpty()) {
			String u = queue.remove();
			for(String v : graph.get(u)) {
				if(dist.get(v) == Integer.MAX_VALUE) {
					queue.add(v);
					dist.replace(v, dist.get(u)+1);
					prev.replace(v, u);
				}
			}
		}
	}
	
	/********** print methods ***********/
	
	public void printCycle() {
		if(solution_cycle.size()!=0) {
			System.out.println("Number of philosophers in the shortest cycle is: "+ (solution_cycle.size()-1));
			for(int i =0; i< solution_cycle.size() -1; i++) System.out.print(solution_cycle.get(i)+" -> ");
			System.out.print(name1+".");
			System.out.println();
		}else {
			System.out.println("No cycle containing these philosophers exists" );
		}
	}

	
	public void printInput() {
		if( graph !=null ) {
			System.out.println( "Size of Adjacency-List: "+graph.size() );
			for (String key   : graph.keySet()) {
				System.out.print( "-Node "+key+" has neighbors: "); 
			    for(String value : graph.get(key))  System.out.print(value+", ");
			    System.out.println();
			}
		} else System.out.println("Input table is null.");
		System.out.println( "Finding shortest circle with "+this.name1+" and "+this.name2+" inside." );
	}

}
