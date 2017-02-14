//
//  MenuTableViewController.swift
//  CouponBell
//
//  Created by NEXT on 2017. 2. 7..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit
import Foundation

class MenuTableViewController: UITableViewController{
    @IBOutlet var tView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let allItems = Item.allItems
    
    
    override func viewWillAppear(_ animated: Bool) {
        tView.reloadData()//전체 데이터 다 다시읽기
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    // MARK: 테이블뷰 설정
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        let items = self.appDelegate.items
//        print(items.count)
//        return items.count
        
        return self.allItems.count
    }
    
    //재사용가능한 셀 있는 지 살펴보고 없으면 새로운 셀 만든다.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let item = self.allItems[(indexPath as NSIndexPath).row]//self.appDelegate.items[indexPath.row]
        cell.groupLabel.text = item.type
        cell.beverageLabel.text = item.menu
        cell.priceLabel.text = String(item.price)
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MenuDetailViewController") as! MeenuDetailViewController
//        detailViewController.meme = appDelegate.memes[(indexPath as NSIndexPath).row]
//        self.navigationController!.pushViewController(detailViewController, animated: true)
//    }
}
