//
//  Items.swift
//  CouponBell
//
//  Created by NEXT on 2017. 2. 7..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation
import UIKit
// Mark: - Items

enum Group{
    case Coffee
    case Tea
    case Bread
}

struct Item{
    
    //Mark: Properties
    
    let type: String
    let menu: String
    let price: Int
    
    static let TypeKey = "TypeKey"
    static let MenuKey = "MenuKey"
    static let PriceKey = "PriceKey"
    
    init(dictionary: [String: String]){
        self.type = dictionary[Item.TypeKey]!
        self.menu = dictionary[Item.MenuKey]!
        self.price = Int(dictionary[Item.PriceKey]!)!
    }
}

extension Item{
    
    static var allItems: [Item]{
        var itemArray = [Item]()
        
        for d in Item.localItemData(){
            itemArray.append(Item(dictionary: d))
        }
        return itemArray
    }
    
    static func localItemData() -> [[String : String]]{
        return[[Item.TypeKey : "Coffee", Item.MenuKey : "Americano", Item.PriceKey : "2000"],
        [Item.TypeKey : "Tea", Item.MenuKey : "GreenTea", Item.PriceKey : "1500"],
        [Item.TypeKey : "Bread", Item.MenuKey : "Bagle", Item.PriceKey : "2500"]]
    }
}
