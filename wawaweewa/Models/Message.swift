//
//  Message.swift
//  wawaweewa
//
//  Created by Karl McGeough on 09/01/2022.
//

import Foundation
import Firebase

class Message {
    
    var id: String
    var chatId: String
    var sentById: String
    var sentByName: String
    var messageText: String
    var timeStamp: Timestamp
    //var readBy: [String]
    
    init(id: String = "", chatId: String = "", sentById: String = "", sentByName: String = "", messageText: String = "", timestamp: Timestamp = Timestamp()) {
        self.id = id
        self.chatId = chatId
        self.sentById = sentById
        self.sentByName = sentByName
        self.messageText = messageText
        self.timeStamp = timestamp
    }
    
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.chatId = data["chatId"] as? String ?? ""
        self.sentById = data["sentById"] as? String ?? ""
        self.sentByName = data["sentByName"] as? String ?? ""
        self.messageText = data["messageText"] as? String ?? ""
        self.timeStamp = data["timeStamp"] as? Timestamp ?? Timestamp()
    }
    
    static func modelToData(message: Message) -> [String:Any] {
        let data : [String: Any] = [
            "id" : message.id,
            "chatId" : message.chatId,
            "sentById" : message.sentById,
            "sentByName" : message.sentByName,
            "messageText" : message.messageText,
            "timeStamp" : message.timeStamp
        ]
        return data
    }
}
