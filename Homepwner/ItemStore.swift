//
//  ItemStore.swift
//  Homepwner
//
//  Created by Randy Le on 4/6/19.
//  Copyright © 2019 Project Koisa. All rights reserved.
//

import UIKit

class ItemStore{
    var allItems = [Item]()
    
    init(){
    }
    
    // removing an item from the store
    func removeItem(_ item: Item){
        if let index = allItems.lastIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    // move items in different order
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        
        // Get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.remove(at: fromIndex)
        
        // insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    }
    
    // create item method
    // @discardableResult means that a caller of this function is free to ignore the result of calling this function.
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        
        return newItem
    }
}
