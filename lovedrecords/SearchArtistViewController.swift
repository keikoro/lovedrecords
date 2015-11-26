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
    @IBOutlet weak var poweredBy: UIButton!
    
    let artistValue: String = ""
    let lastfmUrl = "http://last.fm/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // round corners for powered by label
        poweredBy.layer.cornerRadius = 4
        self.artistSearchField.delegate = self;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // activate segue only if artist search field is not empty
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        
        if identifier == "showAlbumSegue" {
            
            // check for empty text field (can never be nil, but "")
            guard let artist = artistSearchField.text where artist != "" else {
                print("No artist provided.") // debug
                
                // let the user know they need to provide an artist name
                let alert = UIAlertView()
                alert.title = "Missing artist"
                alert.message = "You forgot to enter an artist!"
                alert.addButtonWithTitle("OK")
                alert.show()
                
                return false
            }
            print("Let's go!") // debug
            
            // hide keyboard
            textFieldShouldReturn(artistSearchField)
        }
        return true
    }
    
    // open last.fm website on 'powered by' button click
    @IBAction func goToLastfm(sender: AnyObject) {
    
        // check for validity + 'openability' of url
        // (it's complicated...)
        // (thus incomplete)
        if let url = NSURL(string: lastfmUrl) {
            print("Valid NSURL.") // debug

            if UIApplication.sharedApplication().canOpenURL(url) {
                print("Opening \(url)") // debug
                UIApplication.sharedApplication().openURL(url)
            } else {
                print("Cannot open URL with default app.") // debug
            }
        } else {
            print("Not a valid URL.") // debug
        }
    }
    
    // segue: hand over data to second view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "showAlbumSegue") {
            let seg = segue.destinationViewController as! TopAlbumViewController
            seg.submittedValue = self.artistSearchField.text!
        }
    }
    
    // hide keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
