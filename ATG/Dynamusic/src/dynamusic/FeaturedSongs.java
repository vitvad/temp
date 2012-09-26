/* -------------------------------------------
 * FeaturedSongs
 *
 * Sample class for Dynamusic exercises.
 * 
 * Developing ATG Applications, Part I
 *
 * Author: Diana Carroll
 * Last modified: May 29, 2003
 *--------------------------------------------
 */
 
package dynamusic;

public class FeaturedSongs extends atg.nucleus.GenericService {

        //---------------------------------------------
	// Member variables
	private String[] mSongs;
	
	//---------------------------------------------
	// Property methods

	public String[] getSongs () {
	        if (isLoggingDebug()) {
	            logDebug("getSongs called, returning " + mSongs);
	        }
		return mSongs;
	}
	
	public void setSongs(String[] pSongs) {
	        if (isLoggingDebug()) {
	            logDebug("setSongs called with " + pSongs);
	        }
		mSongs = pSongs;
	}

        //------------------------------------------------------	
	// Constructors
	
	public FeaturedSongs () {
                if (isLoggingDebug()) {
	            logDebug("FeaturedSongs constructor called");
	        }
	}

}
