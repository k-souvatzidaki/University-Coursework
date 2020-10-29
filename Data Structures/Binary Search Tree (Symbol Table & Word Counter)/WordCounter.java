//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

import java.util.Scanner;

public class WordCounter {

	public static void main(String[] args) {
		
		Scanner in = new Scanner(System.in);
		String file;
		ST tree;
		int ans;
		String sans;
		boolean again = false;
		
		while(true) {
			
			again = false; 
			
			System.out.println("- - - - Welcome to the Word Counter - - - -");
			System.out.println("-------------------------------------------");
		
			if(args.length==0) {
				System.out.println("Insert a file to load: ");
				file = in.nextLine();
			} else file=args[0];
		
			tree = new ST();
		
			System.out.println("Do you wish to add some stopwords before reading the file?");
			System.out.println("1) Yes \t 0) No ");
			sans= in.nextLine();
			if(sans.equals("1")) {
				System.out.println("Insert some stopwords. Press 0 to stop. ");
				sans = in.nextLine();
				while(!sans.equals("0")) {
					tree.addStopWord(sans);
					sans=in.nextLine();
				}
			}
			
			tree.load(file);
		
			System.out.println("-------------------------------------------");
			System.out.println("1 ) Print words alphabetically.");
			System.out.println("2 ) Print words by frequency.");
			System.out.println("3 ) Get frequency of a word.");
			System.out.println("4 ) Add stopword.");
			System.out.println("5 ) Remove stopword.");
			System.out.println("6 ) Remove a word.");
			System.out.println("7 ) Get total number of words.");
			System.out.println("8 ) Get most frequent word.");
			System.out.println("9 ) Read file again / Read a new file.");
			System.out.println("-------------------------------------------");
			System.out.println("0 ) Exit");
		
			ans = 999;
		
			while(ans!=0) {
			
				System.out.println("What to do next? ");
				sans = in.nextLine();
				ans=Integer.parseInt(sans);
				
				switch(ans) {
				case 1: 
					tree.printAlphabetically(System.out);
					break;
					
				case 2:
					tree.printByFrequency(System.out);
					break;
				
				case 3:
					System.out.print("Get frequency of: ");
					sans=in.nextLine();
					System.out.println(sans +" appears " + tree.getFrequency(sans) + " times.");
					break;
				
				case 4:
					System.out.println("Note: if you add a stop word, reload file to delete any possible occurencies of it");
					System.out.print("Insert stopword: ");
					sans=in.nextLine();
					tree.addStopWord(sans);
					break;
					
				case 5:
					System.out.println("Note: if you remove a stop word, reload file to restore any possible occurencies of it");
					System.out.print("Remove stopword: ");
					sans=in.nextLine();
					tree.removeStopWord(sans);
					break;
				case 6:
					System.out.print("Remove word: ");
					sans=in.nextLine();
					tree.remove(sans);
					break;
				case 7:
					System.out.println("Total number of words is: "+ tree.getTotalWords());
					System.out.println("Number of distinct words is: "+ tree.getDistinctWords());
					break;
			
				case 8:
					System.out.println("Most frequent word is: "+ tree.getMaximumFrequency());
					break;
					
				case 9:
					System.out.println("Press 0 to read file again(stop words will remain unchanged) \t Press any key to restart and load new file. . .");
					sans = in.nextLine();
					if(sans.equals("0")) {
						tree.setHead(null);
						tree.setNumOfWords(0);
						tree.load(file);
					}else {
						ans=0;
						again=true;
					}
					break;
					
				case 0:
					break;
					
				}	
				
			}
			
		
			if(args.length==1 ) args[0]=null;
			if(!again==true) break;
			
			System.out.println("Restarting app. . . ");
		
		}
	}

}
