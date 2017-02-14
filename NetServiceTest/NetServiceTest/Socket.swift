//
//  Socket.swift
//  NetServiceTest
//
//  Created by NEXT on 2017. 2. 11..
//  Copyright © 2017년 BoostCamp. All rights reserved.
//

import UIKit

enum SocketState : Int {
    case Init = 0
    case connect = 1
    case disconnect = 2
    case errorOccurred = 3
    
}
class Socket: NSObject {
    
    var inputStream  : InputStream?
    var outputStream : OutputStream?
    var runloop      : RunLoop?
    var status : Int = -1
    var timeout      : Float = 5.0;
    weak var mStreamDelegate:StreamDelegate?
    
    func initSockerCommunication( _ host:CFString , port : UInt32 ){
        print()
        print("initSockerCommunication is called")
        DispatchQueue.global().async {
            
            var readstream : Unmanaged<CFReadStream>?
            var writestream : Unmanaged<CFWriteStream>?
            
            CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host, port, &readstream, &writestream)
            
            self.inputStream = readstream!.takeRetainedValue()
            self.outputStream = writestream!.takeRetainedValue()
            
            self.inputStream?.delegate = self
            self.outputStream?.delegate = self
            
            self.inputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
            self.outputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
            self.inputStream?.open()
            self.outputStream?.open()
        }
    }
    
    
    func setInOutStream(inputStream: InputStream, outputStream: OutputStream){
        self.inputStream = inputStream
        self.outputStream = outputStream
        
        self.inputStream?.delegate = self
        self.outputStream?.delegate = self
        
        self.inputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        self.outputStream?.schedule(in: RunLoop.current, forMode: RunLoopMode.defaultRunLoopMode)
        self.inputStream?.open()
        self.outputStream?.open()
    }
    
    func initSockerCommunicationForServer(host:CFString , port : UInt32 , inputStream : InputStream , outputStream : OutputStream ){
//        print()
//        print("initSockerCommunicationForServer is called")
//        DispatchQueue.global().async {
//            var readstream : Unmanaged<CFReadStream>?
//            var writestream : Unmanaged<CFWriteStream>?
//            CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, host, port, &inputStream, &writestream)
//            func CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, string, port, &readStream, &writestream)
//        }
    }
    
    func setStreamDelegate(_ delegete:StreamDelegate){
        print()
        print("setStreamDelegate is called")
        mStreamDelegate = delegete
    }
    
    func getInputStream() -> InputStream{
        print("getInputStream is called")
        return self.inputStream!
    }
    
    func getOutputStream() -> OutputStream {
        print("getoutputstream is called")
        return self.outputStream!
    }
}

extension Socket : StreamDelegate{
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch (eventCode){
            
        case Stream.Event.openCompleted:
            self.status = SocketState.connect.rawValue
            break
            
        case Stream.Event.hasBytesAvailable:
            break
            
        case Stream.Event.errorOccurred:
            break
            
        case Stream.Event.endEncountered:
            self.status = SocketState.errorOccurred.rawValue
            break
            
        default:
            print("")
        }
        mStreamDelegate?.stream?(aStream, handle: eventCode)
    }
}
