//
//  InOutStream.swift
//  NetServiceTest
//
//  Created by NEXT on 2017. 2. 13..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

struct InOutStream{
    
    // Mark: - input and output stream
    var inputStream: InputStream?
    var outputStream: OutputStream?
    var clientName: String!
    var socket: Socket?
    let server: NetService!
    // MARK: init
    
    init(service: NetService){
        socket = Socket()
        self.server = service
    }
}
