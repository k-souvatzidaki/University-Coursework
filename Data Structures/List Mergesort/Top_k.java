//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

import java.io.*;
import java.util.*;

//INPUT: an integer(k) and a .txt file including Song data: song id (int), likes (int), title (String)
//OUTPUT: The top k songs with the most likes. Found by sorting the songs with the MergeSort algorithm.

class Top_k {

	public static void main(String[] args) {
		
		//reading file name/ path and k
		//if they aren's given as arguments
		Scanner in= new Scanner(System.in);
		int k=-1;
		String filename=null;
		if(args.length==0) {
			while(filename==null) {
				System.err.println("Please insert file name");
				System.err.println("Must be a .txt file including Song data");
				filename=in.nextLine();
			}
		}else {
			filename=args[0];
		}
		if(args.length<=1) {
			while(k<0) {
				System.err.println("Please insert k");
				System.err.println("k must be >0");
				k=in.nextInt();
			}	
		}else {
			k=Integer.parseInt(args[1]);
		}
		
		BufferedReader r = null;
		//opening file and creating a reading stream
		try {
			r= new BufferedReader(new FileReader(new File(filename)));
		}catch(FileNotFoundException e) {
			e.printStackTrace();
		}catch(NullPointerException e) {
			e.printStackTrace();
		}catch(ArrayIndexOutOfBoundsException e) {
			e.printStackTrace();
		}
		
		
		//reading song data and storing them in a list
		GenericList<Song> songList = new GenericList<Song>();
		String line;
		StringTokenizer tok;
		int id,likes; String title;
		try {
			line=r.readLine();
			while(line!=null) {
				if(!line.isEmpty()) {
				tok=new StringTokenizer(line);
				int i=tok.countTokens();
				id=Integer.parseInt(tok.nextToken());//the id
				title=new String();
				for(int j=1; j<i-1; j++) { //the title
					title+=tok.nextToken()+" ";
				}
				likes=Integer.parseInt(tok.nextToken()); //the number of likes
				songList.add(new Song(id,likes,title)); //adding the song to the list
				line=r.readLine(); //next line
			}else {
				line=r.readLine();
			}
			}
		}catch(IOException e) {
			e.printStackTrace();
		}
		
		//sorting the list using the merge sort algorithm
		songList.setHead(mergesort(songList.getHead()));
		
		//print k best songs
		//checks if k is less than the size of the list
		//if not, the user is asked to insert k again
		while(true) {
			if(k<=songList.getSize()) {
				System.out.println("Top "+ k +" songs: ");
				int i=0;
				while(i<k) {
					System.out.println("Song #"+(i+1));
					System.out.println(songList.getNode(i)+"\n");
					i++;
				}
				break;
			}else {
				System.out.println("The list doesn't have "+k+" songs.");
				System.out.println("Whould you like to insert a smaller number? \nYes? 1 \nNo? 0");
				int ans= in.nextInt();
				if(ans==0) {
					System.out.println("Exiting the app");
					break;
				}else if(ans==1) {
					System.out.println("Insert k <="+ songList.getSize());
					k=in.nextInt();
				}else {
					ans=in.nextInt();
				}
			}
		}
	}
	
	//mergesort algorithm
	private static Node<Song> mergesort(Node<Song> head){
		Node<Song> a=head;
		Node<Song> b=head.getNext();
		if(a==null ||b==null) return head;
		while(b!=null && b.getNext()!=null) {
			head=head.getNext();
			b=b.getNext().getNext();
		}
		b=head.getNext(); 
		head.setNext(null);
		return merge(mergesort(a),mergesort(b));
		
	}
	
	private static Node<Song> merge(Node<Song> a, Node<Song> b) {
		Node<Song> head=new Node<Song>(null,null);;
		Node<Song> c=head;
		while(a!=null && b!=null) {
			if(a.getItem().compareTo(b.getItem())>0) {
				c.setNext(a);
				c=a;
				a=a.getNext();
			}else {
				c.setNext(b);
				c=b;
				b=b.getNext();
			}
		}
		c.setNext((a==null) ? b:a); //if a==null next=b else next=a
		return head.getNext();
	}

}
