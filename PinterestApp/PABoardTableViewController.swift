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
        
        self.title = "Boards"
        
        PDKClient.sharedInstance().getAuthenticatedUserBoards(withFields: ["id", "image", "description", "name"], success: {
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
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentData = data[indexPath.row] as! [String: Any]
        
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        cell.textLabel?.text = currentData["name"] as? String
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: "BoardPinsSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedData = data[selectedIndex]
        
        if (segue.identifier == "BoardPinsSegue") {
            if let destinationVC = segue.destination as? PAPinsTableViewController {
                destinationVC.passedData = selectedData as! NSDictionary
                destinationVC.title = (selectedData as! NSDictionary)["name"] as? String
            }
        }
    }   
}
