//
//  paymentTableViewController.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit
import RealmSwift

class paymentTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var allMenus: Results<Menu>?
    var totalPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.isOpaque = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let realm = try! Realm()
//        allMenus = realm.objects(Menu.self).filter("numberClientOrdered != 0")
//        tableView.reloadData()
//        if(allMenus?.count != 0){
//            for menu in allMenus! {
//                totalPrice = totalPrice + (menu.price * menu.numberClientOrdered)
//            }
//            totalPriceLabel.text = String(totalPrice)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBackBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if allMenus == nil{
            return 0
        }
        return allMenus!.count
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaymentTableViewCell", for: indexPath) as! paymentTableViewCell
//        var menu = Menu()
//        if allMenus?.count != 0{
//            menu = (allMenus?[indexPath.row])!
//            cell.quantityLabel.text = String(menu.numberClientOrdered)
//            cell.productNameLabel.text = menu.product
//            cell.priceLabel.text = String(menu.numberClientOrdered * menu.price)
//        }
        return cell
    }
}
