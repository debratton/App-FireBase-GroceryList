//
//  ShoppingListVC.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

class ShoppingListVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var shoppinglist = [ShoppingList]()
    var editMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func editBtnPressed(_ sender: UIBarButtonItem) {
        if editMode == false {
            tableView.isEditing = true
            editMode = true
        } else {
            tableView.isEditing = false
            editMode = false
        }
    }
    
}

extension ShoppingListVC: UITableViewDelegate, UITableViewDataSource, AddShoppingListVCDelegate {
    func addShoppingList(item: ShoppingList) {
        shoppinglist.append(item)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        //tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppinglist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShoppingListCell", for: indexPath)
        cell.textLabel?.text = shoppinglist[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //shoppingListDetails
        performSegue(withIdentifier: "shoppingListDetails", sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            shoppinglist.remove(at: indexPath.row)
        }
        //Without reload it crashes
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let tempItem = shoppinglist[sourceIndexPath.row]
        shoppinglist.remove(at: sourceIndexPath.row)
        shoppinglist.insert(tempItem, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addShoppingList" {
            let destinationVC = segue.destination as! AddShoppingListVC
            //Passing as a delegate
            destinationVC.delegate = self
        }
        
        if segue.identifier == "shoppingListDetails" {
            let destinationVC = segue.destination as! ShoppingListDetailsVC
            if let indexPath = tableView.indexPathForSelectedRow {
                //Passing value of row object to details
                destinationVC.passedList = shoppinglist[indexPath.row]
            }
        }
    }
}
