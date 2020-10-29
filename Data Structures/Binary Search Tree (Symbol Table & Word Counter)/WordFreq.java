//Konstantina Souvatzidaki, p3170149 , Department of Informatics, AUEB

public class WordFreq {
	
	private String word;
	private int freq;
	
	//constructor
	public WordFreq(String word) {
		this.word=word;
		this.freq=1;
	}
	
	//getters
	public String key() {
		return word;
	}
	
	public int freq() {
		return freq;
	}
	
	//setters
	public void setKey(String key) {
		this.word=key;
	}
	
	public void setFreq(int freq) {
		this.freq=freq;
	}
	
	
	//increases the word's frequency by 1
	public void incrFreq() {
		freq++;
	}
	
	//toString method
	@Override
	public String toString() {
		return word+" : frequency = "+freq;
	}
	
}
