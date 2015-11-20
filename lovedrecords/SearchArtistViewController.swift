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
