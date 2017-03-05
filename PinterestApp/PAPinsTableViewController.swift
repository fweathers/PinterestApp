//
//  PAPinsTableViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK


class PAPinsTableViewController: UITableViewController {
    
    var data: NSMutableArray = []
    var passedData: NSDictionary!
    var selectedPinId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let id = passedData.object(forKey: "id") as! String
        PDKClient.sharedInstance().getBoardPins(id, fields: ["id", "link", "note", "creator", "image"], withSuccess: { (response) in
            guard let json = response?.parsedJSONDictionary["data"] as? [[String: Any]] else {
                return
            }
            for event in json {
                self.data.add(event)
            }
            self.tableView.reloadData()
        }) { (error) in
            print(error)
            //
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentData = data[indexPath.row] as! [String: Any]
        
        let cellIdentifier = "pinCustomCellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PinCustomCell
        
        if let description = currentData["note"] {
            cell.pinDescriptionText.text = description as! String
        }
        
        let imageObject = currentData["image"] as! NSDictionary
        let original = imageObject.object(forKey: "original") as! NSDictionary
        
        if let url =  URL(string: original["url"] as! String) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: url) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
                DispatchQueue.main.async {
                    cell.pinImageView.image = UIImage(data: data!)
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedData = data[indexPath.row] as! [String: Any]
        
        selectedPinId = selectedData["id"] as! String!
    }
}
