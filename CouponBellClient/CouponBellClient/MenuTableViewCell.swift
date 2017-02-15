//
//  MenuTableViewCell.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//


import Foundation
import UIKit

class MenuTableViewCell: UITableViewCell{
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    @IBOutlet weak var firstViewPriceLabel: UILabel!
    @IBOutlet weak var firstViewProductNameLabel: UILabel!
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    var isFirstSelected = true
    var count = 0
    var index: Int?
    var menu: Menu?
    
    @IBAction func plusBtn(_ sender: Any) {

        count = count + 1
        countLabel.text = String(count)
        
        updateTotalPrice()
        
        menu?.set(keyType: KeyType.NumberClientOrderedKey, changeValue: countLabel.text!)

    }
    @IBAction func minusBtn(_ sender: Any) {

        if count > 1 {
            count = count - 1
            countLabel.text = String(count)
            updateTotalPrice()
            menu?.set(keyType: KeyType.NumberClientOrderedKey, changeValue: countLabel.text!)

            //            menus[index!].set(keyType: KeyType.NumberClientOrderedKey, changeValue: countLabel.text!)
        }
    }
    
    func updateTotalPrice(){
        totalPriceLabel.text = String(count * Int(firstViewPriceLabel.text!)!)
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

