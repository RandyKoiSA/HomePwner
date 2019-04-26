//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by Randy Le on 4/6/19.
//  Copyright © 2019 Project Koisa. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {
    var itemStore : ItemStore!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        let newItem = itemStore.createItem()
        
        if let index = itemStore.allItems.lastIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        // get the height of the status bar
    
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    
    // MARK: tableview numberOfRowsInSection
    // tell how many rows should be displayed on the view
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    
    // MARK: tableview cellForRowAt
    // display which cell goes in what section and row
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // create an instance of UITableViewCEll, with default appearance
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        /* set the text on the cell with the description of the item
           that is at the nth idex of items, where n = row this cell
           will appear in on the tableview
         */
        let item = itemStore.allItems[indexPath.row]
        
        // set the labels
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
        // Bronze challenge : Cell Colors
        if item.valueInDollars > 50 {
            cell.valueLabel.textColor = UIColor.red
        } else {
            cell.valueLabel.textColor = UIColor.green
        }
        
        return cell
    }
    
    // MARK: tableview delete row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // if the table view is asking to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // set up of alert message
            let title = "Delete \(item.name)"
            let message = "Are you sure you want to delete this item?"
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            // adding action button to alert message
            let cancelAction = UIAlertAction(title: "Remove", style: .cancel, handler: nil)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                // remove item from store
                self.itemStore.removeItem(item)
                
                // also remove that row from the table view with an animation
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            
            // present the alert controller
            present(ac, animated: true, completion: nil)
        }
    }
    
    // MARK: moved item to different row
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    // MARK: showItem segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // if the triggered segue is the "showItem" segue
        switch segue.identifier {
        case "showItem"?:
            //Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
}
