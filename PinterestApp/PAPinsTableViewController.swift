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
        
        /*
 PDKClient.sharedInstance().getPinWithIdentifier("", fields: [], withSuccess: { (response) in
 //
 }) { (error) in
 //
 }
 */
 
 
        let id = passedData.object(forKey: "id") as! String
        PDKClient.sharedInstance().getBoardPins(id, fields: ["id", "link", "note"], withSuccess: { (response) in
            self.data = response?.pins() as! NSMutableArray
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

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return data.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var currentData = data[indexPath.row] as! PDKPin
        
        let cellIdentifier = "pinCustomCellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PinCustomCell
        
        if let description = currentData.descriptionText {
            cell.pinDescriptionText.text = description
        }
        
        if let image = currentData.image {
            print(image)
        }
        
        //print(currentData.identifier)
        
        //if let id = currentData.
        
        
//        if let url = currentData.url {
//            currentData.ima
//        }
        

        return cell
    }
 
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var selectedData = data[indexPath.row] as! PDKPin
        
        selectedPinId = selectedData.identifier
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}
