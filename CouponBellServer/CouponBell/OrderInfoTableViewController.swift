//
//  OrderInfoTableViewController.swift
//  CouponBell
//
//  Created by NEXT on 2017. 2. 8..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit
import RealmSwift

class OrderInfoTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    var orderInfos: Results<OrderInfo>?
    
    override func viewWillAppear(_ animated: Bool) {
//        addToOrderInfoList(count: 1, type: "Coffee", menu: "Americano", price: 2000, isCompleted:false)
//        addToOrderInfoList(count: 2, type: "Coffee", menu: "Espresso", price: 1500, isCompleted: false)
//        addToOrderInfoList(count: 3, type: "Tea", menu: "BlackTea", price: 2000, isCompleted: false)
//        addToOrderInfoList(count: 4, type: "Tea", menu: "GreenTea", price: 2500, isCompleted: false)

        
        orderInfos = getFromOrderInfoList(identifier: self.restorationIdentifier!)
        for orderInfo in orderInfos!{
            print(orderInfo.menu)
        }
        tableView.reloadData()//전체 데이터 다 다시읽기
    }
    
    // MARK: 테이블뷰 설정
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if orderInfos == nil{
            return 0
        }
        print(orderInfos!.count)
        return self.orderInfos!.count
    }
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderInfoTableViewCell", for: indexPath) as! OrderInfoTableViewCell
        
        let item = self.orderInfos?[(indexPath as NSIndexPath).row]
        
        cell.userMenuLabel.text = item!.menu
        cell.userStateLabel.text = String(describing: item!.isCompleted)
        cell.userOrderDateLabel.text = String(describing: item!.orderedDate)
        cell.userOrderNumberLabel.text = String(describing: item!.count)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            print("delete")
        } else if editingStyle == .insert{
            print("insert")
        } else if editingStyle == .none {
            print("none")
        }
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        var shareAction = UITableViewRowAction(style: .normal, title: "완료"){ (action: UITableViewRowAction!, indexPath: NSIndexPath) -> Void in
//
////            let firstActivityItem = self.p
//            let activityViewController = UIActivityViewController(activityItems: firstActivityItem, applicationActivities:  nil)
//            
//            self.present(activityViewController, animated: true, completion: nil)
//            
//        }
//        
//        shareAction.backgroundColor = UIColor.blue
//    }
    
    func addToOrderInfoList(count: Int, type: String, menu: String, price: Int, isCompleted: Bool){
        let realm = try! Realm()
        let orderInfo = OrderInfo()
        orderInfo.count = count
        orderInfo.type = type
        orderInfo.menu = menu
        orderInfo.orderedDate = NSDate()
        orderInfo.isCompleted = false
        try! realm.write{
            realm.add(orderInfo)
            print("add succeed")
        }
    }
    
    func getFromOrderInfoList(identifier: String) -> Results<OrderInfo>{
        let realm = try! Realm()
        
        let allLists = realm.objects(OrderInfo)
        if identifier == "preparing" {
            return allLists.filter("isCompleted == false")
        }else{
            return allLists.filter("isCompleted == true")
        }
    }
}







//        addToOrderInfoList(count: 1, type: "Coffee", menu: "Americano", price: 2000, isCompleted: false)
//        addToOrderInfoList(count: 2, type: "Coffee", menu: "Espresso", price: 1500, isCompleted: false)
//        addToOrderInfoList(count: 3, type: "Tea", menu: "BlackTea", price: 2000, isCompleted: false)
//        addToOrderInfoList(count: 4, type: "Tea", menu: "GreenTea", price: 2500, isCompleted: false)
