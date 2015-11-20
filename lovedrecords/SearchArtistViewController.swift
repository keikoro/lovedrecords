//
//  SearchArtistViewController.swift
//  lovedrecords
//
//  Copyright (c) 2015 K Kollmann.
//  All rights reserved.
//

import UIKit

class SearchArtistViewController: UIViewController {

    // UI elements
    @IBOutlet weak var introText: UILabel!
    @IBOutlet weak var artistSearchField: UITextField!
    @IBOutlet weak var startSearchButton: UIButton!
    @IBOutlet weak var poweredByLastfm: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // segue connecting
    // SearchArtist with TopAlbum
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "mySegue") {
            let searchTerm = segue.destinationViewController as! TopAlbumViewController
            searchTerm.input = self.artistSearchField.text!
        }
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
