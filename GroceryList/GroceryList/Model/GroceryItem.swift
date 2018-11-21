//
//  GroceryItem.swift
//  GroceryList
//
//  Created by David E Bratton on 11/20/18.
//  Copyright © 2018 David Bratton. All rights reserved.
//

import Foundation

class GroceryItem {
    var title: String
    var checked: Bool
    
    init(_title: String, _checked: Bool) {
        self.title = _title
        self.checked = _checked
    }
}
