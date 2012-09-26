/* -------------------------------------------
 * SongsManager
 *
 * Sample class for Dynamusic exercises.
 * 
 * Developing ATG Applications, Part I
 *
 * @author Diana Carroll
 * Last modified: May 29, 2003
 *--------------------------------------------
 */
package dynamusic;

import atg.nucleus.GenericService;

import atg.repository.*;
import atg.repository.rql.*;
import javax.transaction.TransactionManager;

public class SongsManager extends GenericService {

  // ----------------------------------------
  // [1] MEMBER VARIABLES
  
  private TransactionManager mTransactionManager = null;
  private Repository mRepository = null;
  private Repository mUserRepository = null;


  // ----------------------------------------
  // [2] PROPERTIES
  
  // -- Property: TransactionManager --
  
  /**
   * Sets the transactionManager property, used to manage transactions 
   * in the handler. 
   **/
  public void setTransactionManager(TransactionManager pTransactionManager) {
    mTransactionManager = pTransactionManager;
  }
  
  /**
   * Returns the transactionManager property, used to manage transactions 
   * in the handler. 
   **/
  public TransactionManager getTransactionManager() {
    return mTransactionManager;
  }

  // -- Property: repository --
  
  /**
   * Sets the repository property, which points to the repository
   * component for the album and songs repository. 
   **/
  public void setRepository(Repository pRepository) {
    mRepository = pRepository;
  }
  
  /**
   * Returns the repository property, which points to the repository
   * component for the album and songs repository. 
   **/
  public Repository getRepository() {
    return mRepository;
  }

  // -- Property: userRepository --
  
  /**
   * Sets the userRepository property, which points to the repository
   * component for users (the profile repository usually) 
   **/
  public void setUserRepository(Repository pUserRepository) {
    mUserRepository = pUserRepository;
  }
  
  /**
   * Returns the userRepository property, which points to the repository
   * component for users (the profile repository usually) 
   **/
  public Repository getUserRepository() {
    return mUserRepository;
  }



  // ----------------------------------------
  // [3] METHODS
  
  /* Given a user from the user repository, return an associated artist.
   * First checks if an existing artist already
   * exists for that user; if not, creates one.
   */
  public String createArtistFromUser(String pUserid) throws RepositoryException {
   
      if (isLoggingDebug()) 
          logDebug("creating new artist from user item " + pUserid);

      MutableRepository mutRepos = (MutableRepository) getRepository();
      Repository userRepos = getUserRepository();
      
      RepositoryItem user = userRepos.getItem(pUserid, "user");
      String username = (String)user.getPropertyValue("firstName") + " " + user.getPropertyValue("lastName");
      String description = (String)user.getPropertyValue("info");
      Boolean shareProfile = (Boolean)user.getPropertyValue("shareProfile");
      RepositoryItem artistItem = null;
      
      /* First, check if an artist has already been created for this user */
      RqlStatement finduserRQL = RqlStatement.parseRqlStatement("name = ?0");
      RepositoryView artistView = mutRepos.getView("artist");
      Object rqlparams[] = new Object[1];
      rqlparams[0] = username;
      RepositoryItem [] artistList = 
            finduserRQL.executeQuery (artistView, rqlparams);
      
      
      if (artistList != null) {
           if (isLoggingDebug()) logDebug("artists found for this user:" + artistList.length + " (using artist: " + artistList[0] + ")");
           artistItem = artistList[0];
      }      
      else {
        try {
         MutableRepositoryItem mutArtistItem = mutRepos.createItem("artist");
         mutArtistItem.setPropertyValue("name", username);
         /* TBD test shareProfile if (shareProfile) */
            mutArtistItem.setPropertyValue("description",description);
         mutRepos.addItem(mutArtistItem);
         artistItem = mutArtistItem;
         if (isLoggingDebug()) 
             logDebug("no artists found for this user, new artist " + mutArtistItem + " created.");

        }
        catch (RepositoryException e) {
         if (isLoggingError()) {
            logError(e);
         }
         throw e;
        }
      }
      return artistItem.getRepositoryId();        
  }

  /* Given a song ID and an artist ID, set the 'artist' property of the song
   * to the artist
   */  
  public void addArtistToSong(String pSongid, String pArtistid) throws RepositoryException {
      if (isLoggingDebug()) 
          logDebug("adding song " + pSongid + " to artist " + pArtistid);

      MutableRepository mutRepos = (MutableRepository)getRepository();
      
      try {
          MutableRepositoryItem mutSongItem = mutRepos.getItemForUpdate(pSongid,"song");  
          RepositoryItem artistItem = mutRepos.getItem(pArtistid,"artist");
          if (isLoggingDebug()) 
              logDebug("adding song " + mutSongItem + " to artist " + artistItem);
          mutSongItem.setPropertyValue("artist",artistItem);
          mutRepos.updateItem(mutSongItem);
          
      }
      catch(RepositoryException e) {
          if (isLoggingError()) {
              logError(e);
          }
          throw e;
      }
  }      
  
   
  /**
   *
   */
   public void deleteAlbumsByArtist(String pArtistId) throws RepositoryException {
   

      if (isLoggingDebug()) 
           logDebug("deleting albums by artist id " + pArtistId);
       
      MutableRepository mutRepos = (MutableRepository)getRepository();

      /* First, find all the albums by this artist */
      RqlStatement findalbumsRQL = RqlStatement.parseRqlStatement("artist.id = ?0");
      RepositoryView albumView = mutRepos.getView("album");
      Object rqlparams[] = new Object[1];
      rqlparams[0] = pArtistId;
      RepositoryItem [] albumList = 
            findalbumsRQL.executeQuery (albumView, rqlparams);
            
      /* loop through the list, and delete the albums */
      if (isLoggingDebug())
          logDebug("found albums for artist: " + albumList);
      if (albumList != null) {
          for (int i = 0; i<albumList.length; i++) {
                if (isLoggingDebug()) 
                     logDebug("deleting album " + albumList[i]);
                mutRepos.removeItem(albumList[i].getRepositoryId(), "album");
          }
      }       
   }
   
  /**
   * Constructor -- doesn't do much for now...
   */
  public SongsManager() {}
}
