//
//  MenuTableViewCell.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MenuTableViewCell: UITableViewCell{
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstViewPriceLabel: UILabel!
    @IBOutlet weak var firstViewProductNameLabel: UILabel!
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var isFirstSelected = false
    var count = 0
    var index: Int?
    var productName: String?
    //    var menu: Menu?
    
    @IBAction func plusBtn(_ sender: Any) {
        
        count = count + 1
        countLabel.text = String(count)
        
        updateTotalPrice()
        plusCount(count: count)
    }
    @IBAction func minusBtn(_ sender: Any) {
        
        if count > 1 {
            count = count - 1
            countLabel.text = String(count)
            updateTotalPrice()
            minusCount(count: count)
        }
    }
    
    func updateTotalPrice(){
        totalPriceLabel.text = String(count * Int(firstViewPriceLabel.text!)!)
    }
    
    func plusCount(count: Int){
        let realm = try! Realm()
        let allMenu = realm.objects(Menu.self)
//        let menu = allMenu.filter("product == '\(productName!)'").last
        //        let menu = allMenu.filter("price == '2000'").last
//        try! realm.write {
//            menu?.numberClientOrdered = count
//        }
    }
    
    func minusCount(count: Int){
        let realm = try! Realm()
        let allMenu = realm.objects(Menu.self)
//        let menu = allMenu.filter("product == '\(productName!)'").last
//        try! realm.write {
//            menu?.numberClientOrdered = count
//        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var showDetails = false{
        didSet{
            secondViewHeightConstraint.priority = showDetails ? 250 : 999
        }
    }
}
