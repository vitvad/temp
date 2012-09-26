/* -------------------------------------------
 * SongList
 *
 * Simple custom class for Dynamusic exercises,
 * 
 * Foundations of ATG Application Development
 *
 * Last modified: July 10, 2010
 *--------------------------------------------
 */

package dynamusic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import atg.nucleus.GenericService;
import atg.repository.Repository;
import atg.repository.RepositoryException;
import atg.repository.RepositoryItem;

public class SongList extends GenericService {
	private Repository repository;
	private String itemDescriptor;
	private int howMany;
	private boolean random;
	private List<String> songs;
	private String[] songIds;
	
	//bean property: repository
	public Repository getRepository() {
		return repository;
	}
	public void setRepository(Repository repository) {
		this.repository = repository;
	}
	//bean property: itemDescriptor
	public String getItemDescriptor() {
		return itemDescriptor;
	}
	public void setItemDescriptor(String itemDescriptor) {
		this.itemDescriptor = itemDescriptor;
	}
	//bean property: howMany
	public int getHowMany() {
		return howMany;
	}
	public void setHowMany(int howMany) {
		if (howMany < 1) {
			howMany = 1;
			if (isLoggingDebug())
				logDebug ("howMany was set too low; resetting it to 1");
		}
		if (howMany > 9) {
			howMany = 9;
			if (isLoggingDebug())
				logDebug ("howMany was set too high; resetting it to 9");
		}

		this.howMany = howMany;
	}
	//bean property: random
	public boolean isRandom() {
		return random;
	}
	public void setRandom(boolean random) {
		this.random = random;
	}
	//bean property: songIds
	public String[] getSongIds() {
		return songIds;
	}
	public void setSongIds(String[] songIds) {
		this.songIds = songIds;
		if (songs==null)
			songs = new ArrayList <String> ();
		if (isLoggingDebug())
			logDebug("setSongIds called -- emptying and reloading featured song titles.");
		songs.clear();
		loadSongs();
	}
	//bean property: songs
	public List<String> getSongs() {
		if (songs==null) {
			if (isLoggingDebug())
				logDebug("getSongs called for first time -- loading featured song titles now.");	
			songs = new ArrayList <String> ();
			loadSongs();
		}
		// if random is true, shuffle the List
		if (random)
			Collections.shuffle(songs);
		
		//copy first howMany of the songs into FeaturedSongs and return them
		List<String> featuredSongs = new ArrayList<String>();
		int numReturned = 0;
		for (int i=0;i < getHowMany() && i < songs.size();i++) {
			featuredSongs.add(i, songs.get(i));	
			numReturned = i+1;
		}
		if (isLoggingDebug())
			logDebug("getSongs called, returning " + numReturned + " song titles.");	
		return featuredSongs;
	}
	public void setSongs(List<String> songs) {
		if (isLoggingDebug())
			logDebug("setSongs called with " + songs);
		this.songs = songs;
	}
	//helper method loadSongs
	public void loadSongs() {
		// Populate the locally stored list of songs.
		// Note this is completely hard-coded to simplify things for
		// this training lab that just introduces Nucleus components.
		// In the real world we would use a slot component but that is
		// beyond the scope of this training course.
		
		// need to get a list of ids, either from the properties file
		// (in property songIds) or else from a default list
		if (songIds==null) {
			String [] defaultSongIds={"200023","200036","200064",
					"205201","208204","204101","200034","205302","200072"};
			songIds = defaultSongIds;
		}
		RepositoryItem currentSong = null;
	try {
		for(int i=0;i<songIds.length;i++) {
			currentSong = getRepository().getItem(songIds[i],"song");
			if (currentSong!=null) {
				songs.add((String) currentSong.getPropertyValue("title"));					
			} else {
				if (isLoggingError())
					logError("couldn't find a song with id: " + songIds[i]);	
			}
		}
		} catch (RepositoryException e) {
			e.printStackTrace();
		}		
	}
	
	// constructor
	public SongList () {
	}
}
