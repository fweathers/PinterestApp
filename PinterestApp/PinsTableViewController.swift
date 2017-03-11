//
//  PAPinsTableViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class PinsTableViewController: UITableViewController {
        
    var pins: [Pin] = []
    var boardId: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        PinterestClient().getPins(for: boardId) { result in
            switch result {
            case .success(let pins):
                self.pins = pins
                self.tableView.reloadData()
            case .failure(let error): print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pins.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let pin = pins[indexPath.row]
        
        let cellIdentifier = "pinCustomCellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! PinCustomCell
        
        // Set text
        cell.pinDescriptionText.text = pin.note
        
        // Set image
        
        if let image = pin.image {
            cell.pinImageView.image = image
        } else {
            pin.getImage() { [weak self] image in
                guard let strongSelf = self else { return }
    
                if Thread.isMainThread {
                    cell.pinImageView.image = image
                } else {
                    DispatchQueue.main.async {
                        guard let cell = strongSelf.tableView.cellForRow(at: indexPath),
                            strongSelf.tableView.visibleCells.contains(cell) else { return }
                        strongSelf.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pinDetailVC = storyboard?.instantiateViewController(withIdentifier: "PinDetailViewController") as! PinDetailViewController
        pinDetailVC.pin = pins[indexPath.row]
        navigationController?.pushViewController(pinDetailVC, animated: true)
    }
}
