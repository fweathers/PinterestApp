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


    override func viewDidLoad() {
        super.viewDidLoad()

//        pinImage.image = newImage
//        print(pinDetailText)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
