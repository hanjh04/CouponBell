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
    var allMenus: Results<Menu>?
    
    
    override func viewWillAppear(_ animated: Bool) {
        allMenus = getFromMenuList()//어울리지 않는 위치. viewwillappear쪽으로 바꿔보는게...
        tableView.reloadData()//전체 데이터 다 다시읽기
        
    }
    
    override func viewDidLoad(){
        ///////////////////////////////////////////////////////////////////////////////////////////////////
//         self.addToMenuList(type: "Coffee", product: "Americano", price: 2000, numberClientOrdered: 0) //
//         self.addToMenuList(type: "Tea", product: "GreenTea", price: 1500, numberClientOrdered: 0)     //
//         self.addToMenuList(type: "Bread", product: "Bagle", price: 2500, numberClientOrdered: 0)      //
        ///////////////////////////////////////////////////////////////////////////////////////////////////
        print(NSHomeDirectory())
        
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allMenus == nil{
            return 0
        }else{
            return allMenus!.count
        }
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        
        let menu = allMenus?[indexPath.row]
        
        
        //cell에 현재 선택된 인덱스값 넘겨줌!
        cell.productName = menu?.product
        cell.count = menu!.numberClientOrdered
        cell.countLabel.text = String(menu!.numberClientOrdered)
        cell.totalPriceLabel.text = String(menu!.numberClientOrdered * menu!.price)
        // 셀 초기값 표시를 위한 설정
        cell.firstViewProductNameLabel.text = menu?.product
        cell.firstViewPriceLabel.text = String(describing: menu!.price)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath.row {
            return 140
        }else{
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPaths = [IndexPath]()
        
        if selectedIndex != -1 {
            indexPaths.append(IndexPath(row:selectedIndex, section: 0))
        }
        indexPaths.append(indexPath)
        
        if selectedIndex == indexPath.row {
            selectedIndex = -1
        }else{
            selectedIndex = indexPath.row
        }
        self.tableView.reloadRows(at: indexPaths, with: UITableViewRowAnimation.automatic)//data 바뀌었을 때..
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
