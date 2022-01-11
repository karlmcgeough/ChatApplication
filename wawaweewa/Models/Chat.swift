//
//  Chat.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation

class Chat {
    var id: String
    var users: [String]
    var chatName: String
    var passcode: String
    var ownerId: String
    
    init(id: String = "", users: [String] = [], chatName: String = "", passcode: String = "", ownerId: String = "") {
        self.id = id
        self.users = users
        self.chatName = chatName
        self.passcode = passcode
        self.ownerId = ownerId
    }
    
    init(data: [String:Any]) {
        self.id = data["id"] as? String ?? ""
        self.users = data["users"] as? [String] ?? []
        self.chatName = data["chatName"] as? String ?? ""
        self.passcode = data["passcode"] as? String ?? ""
        self.ownerId = data["ownerId"] as? String ?? ""
    }
    
    static func modelToData(chat: Chat) -> [String:Any] {
        let data : [String: Any] = [
            "id" : chat.id,
            "users" : chat.users,
            "chatName" : chat.chatName,
            "passcode" : chat.passcode,
            "ownerId" : chat.ownerId
        ]
        return data
    }
}
