//
//  TopAlbumViewController.swift
//  lovedrecords
//
//  Created by Kay on 30/11/15.
//  Copyright © 2015 KK. All rights reserved.
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
        
        // round corners for image
        albumCover.layer.cornerRadius = 30
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
