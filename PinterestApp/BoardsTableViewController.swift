//
//  PABoardsTableViewController.swift
//  PinterestApp
//
//  Created by Felicia Weathers on 3/4/17.
//  Copyright © 2017 Felicia Weathers. All rights reserved.
//

import UIKit
import PinterestSDK

class BoardsTableViewController: UITableViewController {
    
    fileprivate var boards: [Board] = []
    fileprivate var selectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Boards"
        
        PinterestClient().getBoards() { result in
            switch result {
            case .success(let boards):
                self.boards = boards
                self.tableView.reloadData()
            case .failure(let error): print(error)
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let board = boards[indexPath.row]
        let cellIdentifier = "BoardCustomCellID"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! BoardsCustomCell
        //        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        //            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
        //        cell.textLabel?.text = board.name
        
        // Set text
        cell.boardsLabel.text = board.name
        
        // Set image
        if let image = board.image {
            cell.boardsImageView.image = image
        } else {
            board.getImage() { [weak self] image in
                guard self != nil else { return }
                
                if Thread.isMainThread {
                    cell.boardsImageView.image = image
                } else {
                    DispatchQueue.main.async {
                        guard let cell = self?.tableView.cellForRow(at: indexPath),
                            (self?.tableView.visibleCells.contains(cell))! else { return }
                        self?.tableView.reloadRows(at: [indexPath], with: .automatic)
                    }
                }

            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        
        self.performSegue(withIdentifier: "BoardPinsSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedIndex = selectedIndex else { return }
        
        let board = boards[selectedIndex]
        
        if (segue.identifier == "BoardPinsSegue") {
            if let destinationVC = segue.destination as? PinsTableViewController {
                destinationVC.boardId = board.id
                destinationVC.title = board.name
            }
        }
    }   
}
