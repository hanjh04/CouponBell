//
//  MenuTableViewController.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class MenuTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedIndex = -1
    var nowShowingCellIndex = -1
    var prevIndexPath: IndexPath?
    var isOpened = false
    var initial = true
    var tableNum = -1
//    let allMenus = Menu.allMenus
    var allMenus: Results<Menu>?
    
 
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()//전체 데이터 다 다시읽기
        
    }
    
    override func viewDidLoad(){
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        ///self.addToMenuList(type: "Coffee", product: "Americano", price: 2000, numberClientOrdered: 0) //
        ///self.addToMenuList(type: "Tea", product: "GreenTea", price: 1500, numberClientOrdered: 0)     //
        ///self.addToMenuList(type: "Bread", product: "Bagle", price: 2500, numberClientOrdered: 0)      //
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allMenus = getFromMenuList()
        return allMenus!.count
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let menu = allMenus?[indexPath.row]
        
        
        //cell에 현재 선택된 인덱스값 넘겨줌!
        cell.index = (indexPath as NSIndexPath).row
        cell.productName = menu?.product
        cell.count = menu!.numberClientOrdered
        // 셀 초기값 표시를 위한 설정
        cell.firstViewProductNameLabel.text = menu?.product
        cell.firstViewPriceLabel.text = String(describing: menu!.price)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            return 140
        }else{
//            return 140
            return 60
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("SelectRowAt")
//        print((indexPath as NSIndexPath).row)
//        let menuInSelectedCell = menus[(indexPath as NSIndexPath).row]
//        let selectedCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
//        let prevCell: MenuTableViewCell
//        
//        if nowShowingCellIndex == -1 {
//            prevIndexPath = indexPath
//        } else if nowShowingCellIndex == indexPath.row && isOpened == true{
//            prevIndexPath = nil
//            isOpened = false
//        } else {
//            selectedCell.menu = menuInSelectedCell
//        }
//
//        selectedCell.totalPriceLabel.text = String(menuInSelectedCell.numberClientOrdered * menuInSelectedCell.price)
//        selectedCell.countLabel.text = String(menuInSelectedCell.numberClientOrdered)
        
        
        print(indexPath.row)
        let selectedCell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        if selectedCell.isSelected {
            ()
            selectedCell.isSelected = false
            print("cell이 닫혔습니다.")
        } else {
            selectedCell.isSelected = true
            print("cell이 열렸습니다.")
        }
        selectedCell.index = indexPath.row
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        }else{
            selectedIndex = indexPath.row
        }
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        self.tableView.endUpdates()
    }
    
    func addToMenuList(type: String, product: String, price: Int, numberClientOrdered: Int){
        let realm = try! Realm()
        let menu = Menu()
        menu.type = type
        menu.product = product
        menu.price = price
        menu.numberClientOrdered = numberClientOrdered
        try! realm.write{
            realm.add(menu)
            print("add succeed")
        }
    }
    
    func getFromMenuList() -> Results<Menu>{
        let realm = try! Realm()
        return realm.objects(Menu)
    }


}
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        print("diddeselectrowat")
//    }
//    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        print("didhighlightrowat")
//    }
//    
//    func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?) {
//        print("didendeditingrowat")
//    }
//    
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        print("didunhighlightrowat")
//    }
//    
//    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
//        print("willbegineditingrowat")
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
//        print("willdisplayfooterview")
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        print("willdisplayheaderview")
//    }
//    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("willdisplay")
//    }
//    
//    func tableView(_ tableView: UITableView, didUpdateFocusIn context: UITableViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
//        print("didupdatefocusin")
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        print("didenddisplaying")
//    }
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        print("moverowat")
//    }
//    
//    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
//        print("performaction")
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        print("edityingstyle")
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplayingFooterView view: UIView, forSection section: Int) {
//        print("didenddisplayingfooterview")
//    }
//    
//    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int) {
//        print("didenddisplayingheaderview")
//    }
