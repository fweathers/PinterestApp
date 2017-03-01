//
//  ViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 2/28/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
                
        PDKClient.sharedInstance().authenticate(withPermissions: [PDKClientReadPublicPermissions,
                                                                  PDKClientWritePublicPermissions,
                                                                  PDKClientReadRelationshipsPermissions,
                                                                  PDKClientWriteRelationshipsPermissions], from: self, withSuccess: { (result) in
            //
            
            print(result?.user().firstName!)
                       
        }) { (error) in
            //
            print("error ---")
            print(error)
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

