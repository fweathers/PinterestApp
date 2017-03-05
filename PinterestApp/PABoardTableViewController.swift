//
//  PABoardsTableViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class PABoardsTableViewController: UITableViewController {
    
    var data: NSMutableArray = []
    var selectedIndex = -1
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: ["id", "image", "description", "name", "privacy"], success: {
            (result) in
            guard let json = result?.parsedJSONDictionary["data"] as? [[String: Any]] else {
                return
            }
            for event in json {
                self.data.add(event)
            }
            self.tableView.reloadData()
        }
            , andFailure: nil
        )
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentData = data[indexPath.row] as! [String: Any]
        
        
        
//        print(currentData)
        
        // Trying to reuse a cell
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = currentData["name"] as? String

//        print(currentData["id"] as? String)
       
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        // call the segue
        self.performSegue(withIdentifier: "BoardPinsSegue", sender: indexPath);

    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

     // Pass the selected object to the new view controller.

        var selectedData = data[selectedIndex]
        print(data.count)
        print(selectedIndex)
        
        if (segue.identifier == "BoardPinsSegue") {
            if let destinationVC = segue.destination as? PAPinsTableViewController {
               destinationVC.passedData = selectedData as! NSDictionary
            }
        }
//     if(segue.identifier == "SegueHome") {
//     let yourNextViewController = (segue.destination as! CUSTOMVIEWCONTROLLERCLASSS)
//     yourNextViewController.passedJsonData = selctedData
//     }
     }   
}
