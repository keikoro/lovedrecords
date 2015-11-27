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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // rounded corners for image
        albumCover.clipsToBounds = true
        albumCover.layer.cornerRadius = 15
        
        // build the URL
        let lastfmUrl = buildUrl(submittedValue)
        print("-----") // debug        
        print("Last.fm API request URL:") // debug
        print("\(lastfmUrl)") // debug
        
        parseJson(lastfmUrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // request JSON from last.fm URL – done outside the main thread
    func parseJson(lastfmUrl: String) {
        print("-----") // debug
        
        // parse JSON outside the main thread
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {

            // session for web request
            let session = NSURLSession.sharedSession()
            let url = NSURL(string: lastfmUrl)!
            let task = session.dataTaskWithURL(url, completionHandler: {(data, reponse, error) in
                if error != nil {
                    print("Couldn't make the web request.")
                    print(error!.localizedDescription)
                }
                
                do {
                    // get all the JSON in the form of a dictionary
                    if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary {
                        
                        // evaluate JSON with SwiftyJSON
                        let json = JSON(jsonResult)

                        let artistNameResult = json["topalbums"]["@attr"]["artist"].string
                        let albumNameResult = json["topalbums"]["album"][0]["name"].string
                        let playCountResult = json["topalbums"]["album"][0]["playcount"].number
                        // 'large' album cover, 174px
                        let albumCoverImageUrl = json["topalbums"]["album"][0]["image"][2]["#text"].string
                        
                        // debug
                        print("Aaaaall the JSON:")
                        print("Artist: \(artistNameResult!)")
                        print("Album: \(albumNameResult!)")
                        print("Play count: \(playCountResult!)")
                        print("URL to image: \(albumCoverImageUrl!)\n")
                        
                        // update UI in main thread
                        dispatch_async(dispatch_get_main_queue(), {
                            self.artistName.text = artistNameResult
                            self.albumName.text = albumNameResult
                            self.playCount.text = String(playCountResult!)
                        })
                        
                        // start function for album cover download
                        self.downloadImage(albumCoverImageUrl!)
                    }
                } catch {
                    print("There was an error getting the JSON.")
                }
            })
            task.resume()
        })
    }
    
    // download images
    func downloadImage(albumCoverImageUrl: String) {
        
    }
    
    
    // build URL for last.fm request
    func buildUrl(searchTerm: String) -> String {
        
        // URL format to get last.fm top album for given artist:
        // http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=Artist+Name&limit=1&autocorrect=1&api_key=KEY&format=json

        var lastfmUrl: String = ""

        let lastfmKey = (NSBundle.mainBundle().infoDictionary?["Last.fm API Key"])! as! String
        print("-----") // debug
        print("Last.fm API Key:") // debug
        print("\(lastfmKey)") // debug
            
        // placeholder artist
        let artistInput = searchTerm
        print("Requested artist:") // debug
        print("\(artistInput)") // debug

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
        
        // TODO:
        // check URL encoding
        
        return lastfmUrl
    }
}
