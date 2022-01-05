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
    
    init(id: String = "", users: [String] = [], chatName: String = "") {
        self.id = id
        self.users = users
        self.chatName = chatName
    }
    
    init(data: [String:Any]) {
        self.id = data["id"] as? String ?? ""
        self.users = data["users"] as? [String] ?? []
        self.chatName = data["chatName"] as? String ?? ""
    }
    
    static func modelToData(chat: Chat) -> [String:Any] {
        let data : [String: Any] = [
            "id" : chat.id,
            "users" : chat.users,
            "chatName" : chat.chatName
        ]
        return data
    }
}
