//
//  ShoppingListDetailsVC.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

class ShoppingListDetailsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var passedList: ShoppingList!
    var itemList = [GroceryItem]()
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        if let title = passedList?.title {
            self.title = title
        }
    }
    
    @IBAction func editModeBtnPressed(_ sender: UIBarButtonItem) {
        if editMode == false {
            tableView.isEditing = true
            editMode = true
        } else {
            tableView.isEditing = false
            editMode = false
        }
    }
}

extension ShoppingListDetailsVC: UITableViewDelegate, UITableViewDataSource, AddShoppingListItemVCDelegate {
    func addShoppingListItem(item: GroceryItem) {
        //itemList.append(item)
        passedList.groceryItems.append(item)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return itemList.count
        return passedList.groceryItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemListCell", for: indexPath)
        //cell.textLabel?.text = itemList[indexPath.row].title
        cell.textLabel?.text = passedList.groceryItems[indexPath.row].title
        if passedList.groceryItems[indexPath.row].checked == false {
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if cell.accessoryType == .checkmark {
                cell.accessoryType = .none
                passedList.groceryItems[indexPath.row].checked = false
            } else {
                cell.accessoryType = .checkmark
                passedList.groceryItems[indexPath.row].checked = true
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addShoppingItemList" {
            let destinationVC = segue.destination as! AddShoppingListItemVC
            destinationVC.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //let itemToDelete = passedList.groceryItems[indexPath.row]
            passedList.groceryItems.remove(at: indexPath.row)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempItem = passedList.groceryItems[sourceIndexPath.row]
        passedList.groceryItems.remove(at: sourceIndexPath.row)
        passedList.groceryItems.insert(tempItem, at: destinationIndexPath.row)
    }
    
    
}
