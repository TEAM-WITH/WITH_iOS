//
//  SocketIOManager.swift
//  With
//
//  Created by 남수김 on 2019/12/24.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shared = SocketIOManager()
    private static let socketURL = URL(string: BaseAPI.socketURL)
    var manager = SocketManager(socketURL: socketURL!, config: [.log(true), .compress])
    var socket: SocketIOClient!
    override init() {
        super.init()
        //        socket = self.manager.socket(forNamespace: "/test")
        socket = self.manager.defaultSocket
    }
    func establishConnection(room: String, completion: @escaping () -> Void) {
        socket = self.manager.socket(forNamespace: "/"+room)
        socket.connect()
        completion()
    }
    func closeConnection() {
        socket.disconnect()
    }
    // 메시지 보내기
    func sendMessage(message: String, senderNickname nickname: String) {
        socket.emit("messagedetection", [
            "senderNickname": nickname,
            "message": message
        ])
    }
    // 유저 입장
    func receiveUserJoinedChat() {
        socket.on("userjoinedthechat") { dataArray, ack in
            dataArray[0] as? NSDictionary
            
            
        }
    }
    
}
