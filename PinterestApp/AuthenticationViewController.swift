//
//  ViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 2/28/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class AuthenticationViewController: UIViewController {
    
    @IBOutlet weak var viewBoardsButton: UIButton!
    @IBOutlet weak var authenticateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewBoardsButton.isHidden = true
    }
    
    @IBAction func authenticateButtonTapped(_ sender: UIButton) {
        PinterestClient().authenticate(presentor: self) { result in
            switch result {
            case .success(let user):
                if let user = user,
                    let name = user.firstName {
                    self.authenticateLabel.text = name + " is signed in to Pinterest"
                }
            case .failure(let error):
                print(error)
            }
        }
        viewBoardsButton.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

