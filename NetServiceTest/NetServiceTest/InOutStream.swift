//
//  InOutStreams.swift
//  NetServiceTest
//
//  Created by NEXT on 2017. 2. 12..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

struct InOutStream{
    
    // Mark: - input and output stream
    var inputStream: InputStream!
    var outputStream: OutputStream!
    var clientName: String!
    
    // MARK: init
    
    init(inputStream: InputStream!, outputStream: OutputStream!, clientName: String!){
        self.inputStream = inputStream
        self.outputStream = outputStream
        self.clientName = clientName
    }
}
