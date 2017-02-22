//
//  GuestUserNameViewController.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 21..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//


import Foundation
import UIKit

class GetUserNameViewController: UIViewController{
    
    @IBOutlet weak var getUserNameTextField: UITextField!
    var myNetwork: MyNetwork?
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        myNetwork = MyNetwork.sharedInstance()
        if (myNetwork?.sendJSONMessage(type: "Menu"))!{
            print("abcd")
        }
    }
    
       
    @IBAction func getUserNameBtn(_ sender: Any) {
        UserDefaults.standard.set(getUserNameTextField.text, forKey: "ClientName")
        dismiss(animated: true, completion: nil)
    }
}
