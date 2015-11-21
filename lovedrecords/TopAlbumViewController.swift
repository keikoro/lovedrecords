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
    
    var submittedValue: String = ""
    var lastfmUrl: String = ""
    var lastfmKey: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rounded corners for image
        albumCover.clipsToBounds = true
        albumCover.layer.cornerRadius = 15
        
        let lastfmUrl = buildUrl(submittedValue)
        print("Last.fm API request URL:") // debug
        print(lastfmUrl) // debug
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // build URL for last.fm request
    func buildUrl(searchTerm: String) -> String {
        
        // URL format to get last.fm top album for given artist:
        // http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=Artist+Name&limit=1&autocorrect=1&api_key=KEY&format=json
        
        lastfmKey = (NSBundle.mainBundle().infoDictionary?["Last.fm API Key"])! as! String
        print("Last.fm API Key:") // debug
        print("\(lastfmKey)\n") // debug
            
        // placeholder artist
        let artistInput = searchTerm
        print("Requested artist:") // debug
        print("\(artistInput)\n") // debug

        // replace all spaces in artist name with '+' signs
        let artist = artistInput.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.LiteralSearch, range: nil)
        
        // load last.fm key variable from Info.plist
        if (lastfmKey != "") {
            // build url
            lastfmUrl = "https://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&" +
                "artist=\(artist)" +
                "&limit=1" +
                "&autocorrect=1" +
                "&api_key=\(lastfmKey)" +
                "&format=json"
        }
        return lastfmUrl
    }
}
