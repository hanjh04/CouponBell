//
//  MyNetwork.swift
//  CouponBellClient
//
//  Created by NEXT on 2017. 2. 18..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import Foundation
import UIKit



class MyNetwork: NSObject, NetServiceDelegate, NetServiceBrowserDelegate, StreamDelegate{

    var myOrderList = [MyOrderList]()
    var browser: NetServiceBrowser!
    var server: NetService!
    var client: NetService!
    let socket: Socket? = Socket()
    
    
    // MARK: for singleton design - start
    struct StaticInstance{
        static var instance: MyNetwork?
    }
    
    class func sharedInstance() -> MyNetwork{
        if !(StaticInstance.instance != nil){
            StaticInstance.instance = MyNetwork()
        }
        return StaticInstance.instance!
    }
    // Mark : for singleton design - end

    func publishService(){
        //publish service for client
        client = NetService.init(domain: "local", type: "_test._tcp", name: "JanghoHan", port: 3000)
        client.includesPeerToPeer = true
        client.schedule(in: RunLoop.current, forMode: RunLoopMode.commonModes)
        client.delegate = self
        client.publish(options: .listenForConnections)
    }
    
    func searchService(){
        self.browser = NetServiceBrowser()
        self.browser.includesPeerToPeer = true
        browser.delegate = self
        browser.searchForServices(ofType: "_test._tcp", inDomain: "local")
    }
    
    func removeServer(){
        server.stop()
    }
    
    // MARK: NetService Delegate
    
    func netServiceWillPublish(_ sender: NetService) {
        print("netServiceWillPublish \(sender)")
    }
    
    func netServiceDidPublish(_ sender: NetService) {
        print("netServiceDidPublish \(sender)")
    }
    
    func netService(_ sender: NetService, didNotPublish errorDict: [String : NSNumber]) {
        print("netService : \(sender) didNotPublish Error : \(errorDict)")
    }
    
    func netServiceWillResolve(_ sender: NetService) {
        print("netServiceWillResolve \(sender)")
        updateInterface()
    }
    
    func netServiceDidResolveAddress(_ sender: NetService) {
        //델리게이트 메소드는 서비스에 대해 각 주소를 해석할 때마다 호출됨.
        print("netServiceDidResolveAddress service name \(sender.name) of type \(sender.type)," +
            "port \(sender.port), addresses \(sender.addresses)")
        
        self.initSocket(self.getIPV4StringfromAddress(server.addresses!) as CFString , port: UInt32(server.port))
        print(server.addresses!)
    }
    
    func netService(_ sender: NetService, didAcceptConnectionWith inputStream: InputStream, outputStream: OutputStream){
        print("netService : \(sender) didAcceptConnectionWith Input Stream : \(inputStream) , Output Stream : \(outputStream)")
        
        inputStream.delegate = self
        outputStream.delegate = self
        inputStream.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        outputStream.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        inputStream.open()
        outputStream.open()
    }
    
    func netServiceDidStop(_ sender: NetService) {
        print("netServiceDidStop : \(sender)")
    }
    
    
    // MARK : NetServiceBrowser Delegate
    
    func netServiceBrowserWillSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserWillSearch")
    }
    
    func netServiceBrowserDidStopSearch(_ browser: NetServiceBrowser) {
        print("netServiceBrowserDidStopSearch")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFind service: NetService, moreComing: Bool){
        print("netservicebrowser didfind service")
        if service.name == "CouponBellServer"{
            server = service
            updateInterface()
        }
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemove service: NetService, moreComing: Bool) {
        print("\(service) was removed")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didNotSearch errorDict: [String : NSNumber]) {
        print("netServiceBrowser didNotSearch Error \(errorDict)")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didFindDomain domainString: String, moreComing: Bool) {
        print("netServiceBrowser didFindDomain Domain : \(domainString)")
    }
    
    func netServiceBrowser(_ browser: NetServiceBrowser, didRemoveDomain domainString: String, moreComing: Bool) {
        print("netServiceBrowser didRemoveDomain Domain : \(domainString)")
    }
    
    
    // get IP Adress
    
    func updateInterface () {
        if server.port == -1 {
            print("\(server.name)" + " Not yet resolved")
            server.delegate = self
            server.resolve(withTimeout: 10)
        }
    }
    
    func getIPV4StringfromAddress(_ address: [Data] ) -> String{
        
        if  address.count == 0{
            return "0.0.0.0"
        }
        
        let data = address.first! as NSData
        
        var ip1 = UInt8(0)
        data.getBytes(&ip1, range: NSMakeRange(4, 1))
        
        var ip2 = UInt8(0)
        data.getBytes(&ip2, range: NSMakeRange(5, 1))
        
        var ip3 = UInt8(0)
        data.getBytes(&ip3, range: NSMakeRange(6, 1))
        
        var ip4 = UInt8(0)
        data.getBytes(&ip4, range: NSMakeRange(7, 1))
        
        let ipStr = String(format: "%d.%d.%d.%d",ip1,ip2,ip3,ip4)
        
        return ipStr
    }
    
    
    //init socket
    
    func initSocket( _ ipString :CFString , port : UInt32 ){
        socket?.initSocketCommunication(ipString, port: port)
        print("HOST \(ipString) and the port : \(port)" )
        socket?.setStreamDelegate(self)
    }
    

    // send jsonmessage
    func sendJSONMessage(type: String = "order", orderListDic: Dictionary<String, Int>? = ["menu" : 0]) -> Bool{

        do {
            let cName: String
            if type == "Menu"{
                cName = "client"
            }else{
                cName = UserDefaults.standard.string(forKey: "ClientName")!
            }
            
            let clientName     : [String : String]    = [ "ClientName" : cName]
            let type           : [String : String]    = [ "Type" : type]
            let orderListDicDic: [String : AnyObject] = [ "OrderList" : orderListDic as AnyObject]
            let temp = NSMutableDictionary(dictionary: clientName)
            
            temp.addEntries(from: clientName)
            temp.addEntries(from: type)
            temp.addEntries(from: orderListDicDic)
            
            let jsonData = try JSONSerialization.data(withJSONObject: temp)
            
            print(jsonData)
            
            let data = jsonData as Data?
            print("\(socket?.outputStream) ==> Pass JSON Data : \(temp)")
            
            socket?.outputStream?.open()
            
            let result = data?.withUnsafeBytes {socket?.outputStream?.write($0, maxLength: (data?.count)!) }
            
            if result == 0 {
                print("Stream at capacity")
            } else if result == -1 {
                print("Operation failed: \(socket?.outputStream?.streamError)")
            } else {
                print("The number of bytes written is \(result)")
                for myOrder in myOrderList {
                    myOrder.quantity = 0
                }
                return true
            }
        }catch let error as NSError {
            print(error)
        }
        return false
    }
    
    func stream(_ aStream: Stream, handle eventCode: Stream.Event){
        switch eventCode{
        case Stream.Event.errorOccurred:
            print("ErrorOccurred")
        case Stream.Event.openCompleted:
            print("stream opened")
        case Stream.Event.hasBytesAvailable:
            print("HasBytesAvailable")
            let inputStream = aStream as? InputStream
            
            //통신타입 - 메뉴요청 혹은 주문. 각각 해당하는 컨트롤러
            while ((inputStream?.hasBytesAvailable) != false){
                do{
                    let parsedData = try JSONSerialization.jsonObject(with: inputStream!, options: []) as![String:Any]
                }catch let error{
                    print(error)
                }
            }
        case Stream.Event.hasSpaceAvailable:
            print("HasSpaceAvailable")
        default:
            break
        }
    }
}
