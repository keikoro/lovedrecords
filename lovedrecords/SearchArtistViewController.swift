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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // round corners for powered by label
        poweredBy.layer.cornerRadius = 4
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segue connecting SearchArtist with TopAlbum
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "segueToAlbum") {
            let seg = segue.destinationViewController as! TopAlbumViewController
            seg.submittedValue = self.artistSearchField.text!
        }
    }
    
    @IBAction func goToLastfm(sender: AnyObject) {
        if let url = NSURL(string: "https://last.fm") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // hide keyboard
    func hideKeyboard(artistSearchField: UITextField) -> Bool {
        artistSearchField.resignFirstResponder()
        return true
    }
    
    // submit button press
    @IBAction func submitArtist(sender: UIButton) {
        let artistValue = artistSearchField.text
        
        print("Search field input:") // debug

        // only activate the segue on non-empty input
        if (artistValue == "") {
            print("~EMPTY~\n") // debug
        } else {
            print("\(artistValue!)\n") // debug

            hideKeyboard(artistSearchField)
            performSegueWithIdentifier("segueToAlbum", sender: self)
        }
    }
}
