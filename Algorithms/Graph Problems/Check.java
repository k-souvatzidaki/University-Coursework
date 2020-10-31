import java.io.*;
import java.util.*;

public class Check {

	public static void main(String args[]) throws IOException {
		System.out.println("1) Find the shortest cycle in a philosophers' graph that includes Adam Smith and Karl Popper");
		System.out.println();
		cycle();
		System.out.println();
		System.out.println("2) Find the vertex cover in a students graph, first with a brute force method, and then with a Greedy algorithm");
		System.out.println();
		vertex();
	}

	public static void cycle() throws IOException {
		String name1 = "adam_smith";
		String name2 = "karl_popper";
		ShortestCycle c = new ShortestCycle(create_graph("philosophy_edgelist.txt"), name1, name2);
		c.findCycle();
		c.printCycle();		
	}

	public static void vertex() throws IOException {
		VertexCover v = new VertexCover(create_graph("vertexcovertest10.txt"));
		v.findCovers();
		v.printCovers();
	} 
	

	public static HashMap<String, ArrayList<String>> create_graph( String fileName ) throws IOException {
		
		HashMap<String,ArrayList<String>> graph = new HashMap<String,ArrayList<String>>();
		BufferedReader reader = new BufferedReader(new FileReader(new File(fileName))); String line; String[] line_split;
		
		while((line = reader.readLine()) != null ) {
			line_split = line.split("\t");
			if(!graph.containsKey(line_split[0])) {
				graph.put(line_split[0],new ArrayList<String>(Arrays.asList(line_split[1])));
				
			}
			else {
				if(!graph.get(line_split[0]).contains(line_split[1])) graph.get(line_split[0]).add(line_split[1]);
			}
			if(!graph.containsKey(line_split[1])) {
				graph.put(line_split[1],new ArrayList<String>(Arrays.asList(line_split[0])));
				
			}
			else {
				if(!graph.get(line_split[1]).contains(line_split[0])) graph.get(line_split[1]).add(line_split[0]);
			}
		}
		reader.close();
		
		return graph;
	}


}