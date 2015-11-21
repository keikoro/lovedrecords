//
//  TopAlbumViewController.swift
//  lovedrecords
//
//  Copyright (c) 2015 K Kollmann.
//  All rights reserved.
//

import UIKit

class TopAlbumViewController: UIViewController {

    // UI elements
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var albumName: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    @IBOutlet weak var playCountLabel: UILabel!
    @IBOutlet weak var playCount: UILabel!
    
    var searchTerm: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rounded corners for image
        albumCover.clipsToBounds = true
        albumCover.layer.cornerRadius = 15
        
        buildUrl()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let artistInput = searchTerm
        print("Requested artist: \n\(artistInput)\n")    // debug
        
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
}
