//
//  ShoppingList.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import Foundation

class ShoppingList {
    var title: String
    var groceryItems: [GroceryItem] = [GroceryItem]()
    
    init(_title: String) {
        self.title = _title
    }
}
