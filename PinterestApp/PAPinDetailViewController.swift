//
//  PAPinDetailViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class PAPinDetailViewController: UIViewController {
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var pinDetailText: UITextView!
    var newImage: UIImage!
    var noteText:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pinDetailText.text = noteText
    }
}
