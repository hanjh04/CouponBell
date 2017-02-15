//
//  MenuTableViewController.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = -1
    var nowShowingCellIndex = -1
    var prevIndexPath: IndexPath?
    var isOpened = false
    var initial = true
    var tableNum = -1
//    let allMenus = Menu.allMenus
    var menus = (UIApplication.shared.delegate as! AppDelegate).menus
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()//전체 데이터 다 다시읽기
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        menus.append(Menu(type: "Coffee", product: "Americano", price: 2000, numberClientOrdered: 0))
        menus.append(Menu(type: "Tea", product: "GreenTea", price: 1500, numberClientOrdered: 0))
        menus.append(Menu(type: "Bread", product: "Bagle", price: 2500, numberClientOrdered: 0))
        print(menus[0].price)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if initial{
            tableNum = menus.count
            initial = false
        }
        return menus.count
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        print((indexPath as NSIndexPath).row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        cell.index = (indexPath as NSIndexPath).row
        let menu = menus[(indexPath as NSIndexPath).row]//[indexPath.row]
        
        if tableNum >= 0{
            cell.menu = menu
            tableNum = tableNum - 1
        }
        
        cell.firstViewProductNameLabel.text = menu.product
        cell.firstViewPriceLabel.text = String(menu.price)
//        print((indexPath as NSIndexPath).row)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            return 140
        }else{
            return 140
            //return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("SelectRowAt")
        print((indexPath as NSIndexPath).row)
        let menuInSelectedCell = menus[(indexPath as NSIndexPath).row]
        let selectedCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        let prevCell: MenuTableViewCell
        
        if nowShowingCellIndex == -1 {
            prevIndexPath = indexPath
        } else if nowShowingCellIndex == indexPath.row && isOpened == true{
            prevIndexPath = nil
            isOpened = false
        } else {
            selectedCell.menu = menuInSelectedCell
        }

        selectedCell.totalPriceLabel.text = String(menuInSelectedCell.numberClientOrdered * menuInSelectedCell.price)
        selectedCell.countLabel.text = String(menuInSelectedCell.numberClientOrdered)
        
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        }else{
            selectedIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print("diddeselectrowat")
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        print("didhighlightrowat")
    }
    
    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
        print("didendeditingrowat")
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        print("didunhighlightrowat")
    }
        
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("willbegineditingrowat")
    }

    
}


