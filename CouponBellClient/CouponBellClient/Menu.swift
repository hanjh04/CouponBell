//
//  Menu.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//
import Foundation
import UIKit
// Mark: - Items
//
//enum Group{
//    case Coffee
//    case Tea
//    case Bread
//}

struct Menu{
    
    //Mark: Properties
    
    let type: String
    let product: String
    let price: Int
    
    static let TypeKey = "TypeKey"
    static let ProductKey = "MenuKey"
    static let PriceKey = "PriceKey"
    
    init(dictionary: [String: String]){
        self.type = dictionary[Menu.TypeKey]!
        self.product = dictionary[Menu.ProductKey]!
        self.price = Int(dictionary[Menu.PriceKey]!)!
    }
}

extension Menu{
    
    static var allMenus: [Menu]{
        var menuArray = [Menu]()
        
        for d in Menu.localMenuData(){
            menuArray.append(Menu(dictionary: d))
        }
        return menuArray
    }
    
    static func localMenuData() -> [[String : String]]{
        return[[Menu.TypeKey : "Coffee", Menu.ProductKey : "Americano", Menu.PriceKey : "2000"],
               [Menu.TypeKey : "Tea", Menu.ProductKey : "GreenTea", Menu.PriceKey : "1500"],
               [Menu.TypeKey : "Bread", Menu.ProductKey : "Bagle", Menu.PriceKey : "2500"]]
    }
}
