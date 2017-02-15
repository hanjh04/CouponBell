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

enum KeyType{
    case TypeKey, ProductKey, PriceKey, NumberClientOrderedKey
}

class Menu{
    
    //Mark: Properties
    
    var type: String
    var product: String
    var price: Int
    var numberClientOrdered: Int
    
    static let TypeKey = "TypeKey"
    static let ProductKey = "MenuKey"
    static let PriceKey = "PriceKey"
    static let NumberClientOrderedKey = "NumberClientOrderedKey"
    
    
    init(type: String, product: String, price: Int, numberClientOrdered: Int){
        self.type = type
        self.product = product
        self.price = price
        self.numberClientOrdered = numberClientOrdered
    }
    
    func set(keyType: KeyType, changeValue: String) -> Bool{
        if let intValue = Int(changeValue){
            switch(keyType){
            case .PriceKey:
                self.price = intValue
            case .NumberClientOrderedKey:
                self.numberClientOrdered = intValue
            default:
                return false
            }
        }else{
            switch(keyType){
            case .TypeKey:
                self.type = changeValue
            case .ProductKey:
                self.product = changeValue
            default:
                return false
            }
        }
        return true
    }
}

//extension Menu{
//    
//    static var allMenus: [Menu]{
//        var menuArray = [Menu]()
//        
//        for d in Menu.localMenuData(){
//            menuArray.append(Menu(dictionary: d))
//        }
//        return menuArray
//    }
//    
//    static func localMenuData() -> [[String : String]]{
//        return[[Menu.TypeKey : "Coffee", Menu.ProductKey : "Americano", Menu.PriceKey : "2000", Menu.NumberClientOrderedKey : "0"],
//               [Menu.TypeKey : "Tea", Menu.ProductKey : "GreenTea", Menu.PriceKey : "1500", Menu.NumberClientOrderedKey : "0"],
//               [Menu.TypeKey : "Bread", Menu.ProductKey : "Bagle", Menu.PriceKey : "2500", Menu.NumberClientOrderedKey : "0"]]
//    }
//}
