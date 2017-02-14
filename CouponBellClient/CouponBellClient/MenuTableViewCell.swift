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
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var showDetails = false{
        didSet{
            secondViewHeightConstraint.priority = showDetails ? 250 : 999
        }
    }


}

