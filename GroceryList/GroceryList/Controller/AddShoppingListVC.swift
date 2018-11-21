//
//  AddShoppingListVC.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

// Pass back to GroceryListVC
protocol AddShoppingListVCDelegate {
    func addShoppingList(item: ShoppingList)
    
}

class AddShoppingListVC: UIViewController {

    @IBOutlet weak var shoppingItemText: UITextField!
    
    var delegate: AddShoppingListVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addShoppingItemPressed(_ sender: UIBarButtonItem) {
        if let title = shoppingItemText.text {
            let newItem = ShoppingList(_title: title)
            delegate.addShoppingList(item: newItem)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
