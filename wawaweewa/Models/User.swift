//
//  User.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import MessengerKit

class User {
    var id: String
    var username: String
    var email: String
    var fcmToken: String
    var profileImageUrl: String
    
    init(id: String = "", username: String = "", email: String = "", fcmToken: String = "", profileImageUrl: String = "") {
        
        self.id = id
        self.username = username
        self.email = email
        self.fcmToken = fcmToken
        self.profileImageUrl = profileImageUrl
    }
    
    init(data: [String:Any]) {
        self.id = data["id"] as? String ?? ""
        self.username = data["username"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.fcmToken = data["fcmToken"] as? String ?? ""
        self.profileImageUrl = data["profileImageUrl"] as? String ?? ""
    }
    
    static func modelToData(user: User) -> [String:Any] {
        let data : [String: Any] = [
            "id" : user.id,
            "username" : user.username,
            "email" : user.email,
            "fcmToken" : user.fcmToken,
            "profileImageUrl" : user.profileImageUrl
        ]
        return data
    }
    
    struct Users: MSGUser {
        var displayName: String
        var avatar: UIImage?
        var avatarUrl: URL?
        var isSender: Bool
    }
}
