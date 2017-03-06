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
    
    @IBOutlet weak var authenticateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func authenticateButtonTapped(_ sender: UIButton) {
        
        PDKClient.sharedInstance().authenticate(withPermissions:
            [PDKClientReadPublicPermissions,
             PDKClientWritePublicPermissions,
             PDKClientReadRelationshipsPermissions,
             PDKClientWriteRelationshipsPermissions], from: self, withSuccess: { (result) in
                //
                if ((result?.user().firstName!) != nil) {
                    let name = result?.user().firstName!
                    self.authenticateLabel.text = name! + (" is signed in to Pinterest")
                } else {
                    
                    print(result?.user().firstName! ?? "User does not have first name")
                    
                }
                
        }) { (error) in
            //
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

