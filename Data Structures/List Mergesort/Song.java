//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

public class Song implements Comparable<Song> {
	
	private int id;
	private int likes;
	private String title;
	
	//constructor
	public Song(int id, int likes, String title) {
		setId(id);
		setTitle(title);
		setLikes(likes);
	}
	
	//sets the id if it's within range
	public void setId(int id) {
		if(id >= 1 && id <= 9999) {
			this.id=id;
		}else { throw new IllegalArgumentException("Id value out of range"); }
	}
	
	//sets the title if it's within characters' range
	public void setTitle(String title) {
		if(title.length()<=80) {
			this.title=title;
		}else { throw new IllegalArgumentException("Song title is too big"); }
	}
	
	//likes setter
	public void setLikes(int likes) {
		this.likes=likes;
	}
	
	//getters
	public int getLikes() {
		return likes;
	}
	
	public int getId() {
		return id;
	}
	
	public String getTitle() {
		return title;
	}
	
	//toString method
	public String toString() {
		return "Id: "+id+ "\nTitle: "+title+"\nLikes: "+likes;
	}
	
	//compareTo method
	public int compareTo(Song s) {
		if(s.getLikes()>likes) {
			return -1;
		}else if(s.getLikes()==likes) {
			return s.getTitle().toUpperCase().compareTo(title.toUpperCase()); //case insensitivity
		}
		return 1;
	}
	

}

