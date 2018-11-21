//
//  AddShoppingListItemVC.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import UIKit

protocol AddShoppingListItemVCDelegate {
    func addShoppingListItem(item: GroceryItem)
    
}

class AddShoppingListItemVC: UIViewController {

    @IBOutlet weak var shoppingItemText: UITextField!
    
    var delegate: AddShoppingListItemVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        if let title = shoppingItemText.text {
            let newItem = GroceryItem(_title: title, _checked: false)
            delegate.addShoppingListItem(item: newItem)
        }
        navigationController?.popViewController(animated: true)
    }
    
}
