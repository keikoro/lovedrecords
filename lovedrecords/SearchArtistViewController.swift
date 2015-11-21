//
//  SearchArtistViewController.swift
//  lovedrecords
//
//  Copyright (c) 2015 K Kollmann.
//  All rights reserved.
//

import UIKit

class SearchArtistViewController: UIViewController, UITextFieldDelegate {

    // UI elements
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var artistSearchField: UITextField!
    @IBOutlet weak var startSearchButton: UIButton!
    @IBOutlet weak var poweredBy: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // round corners for powered by label
        poweredBy.clipsToBounds = true
        poweredBy.layer.cornerRadius = 3
        buildUrl()
    }

    @IBAction func lastfmLink(sender: AnyObject) {
        if let url = NSURL(string: "https://last.fm") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // build URL for last.fm request
    func buildUrl() {
        // last.fm get top album from given artist
        // http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=Artist+Name&limit=1&autocorrect=1&api_key=KEY&format=json
        
        // placeholder artist
        // replace all spaces with '+' signs
        let artistInput = "Depeche Mode"
        let artist = artistInput.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // load last.fm key variable from Info.plist
        if let lastfmKey = NSBundle.mainBundle().infoDictionary?["Last.fm API Key"] as? String {
            print("Last.fm API Key: \n\(lastfmKey)\n")    // debug
            let lastfmUrl: String
            
            // build url
            lastfmUrl = "https://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&" +
                "artist=\(artist)" +
                "&limit=1" +
                "&autocorrect=1" +
                "&api_key=\(lastfmKey)" +
                "&format=json"
            print("Full last.fm API request URL: \n\(lastfmUrl)\n")    // debug
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segue connecting
    // SearchArtist with TopAlbum
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueToAlbum") {
            let seg = segue.destinationViewController as! TopAlbumViewController
            seg.searchTerm = self.artistSearchField.text!
        }
    }
    
    func textFieldShouldReturn(artistSearchField: UITextField) -> Bool {
        artistSearchField.resignFirstResponder()
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
