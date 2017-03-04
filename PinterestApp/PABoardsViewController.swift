//
//  PABoardsViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/2/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class PABoardsViewController: ViewController, UITableViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
                PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: ["id", "image", "description", "name", "privacy"], success: {
                    (result) in
        
                    guard let json = result?.parsedJSONDictionary["data"] as? [[String: Any]] else {
        
                        return
                    }
                    print(json[0]["name"]!)
//                    print(json)
                }
                    , andFailure: nil
                )
        
        
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
