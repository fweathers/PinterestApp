//
//  PAPinDetailViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class PinDetailViewController: UIViewController {
    @IBOutlet weak var pinImage: UIImageView!
    @IBOutlet weak var pinDetailText: UITextView!
    var pin: Pin!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        pinDetailText.text = pin.note
        
        pin.getImage() { [weak self] image in
            guard !Thread.isMainThread else {
                self?.pinImage.image = image
                return
            }
            
            DispatchQueue.main.async {
                self?.pinImage.image = image
            }
        }

    }
}
