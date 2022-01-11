//
//  MessengerVM.swift
//  wawaweewa
//
//  Created by Karl McGeough on 09/01/2022.
//

import Foundation
import Firebase
import UIKit
import SwiftUI

class MessengerVM {
    
    var user = User()
    var chat = Chat()
    var users: [User] = []
    var filtered: [User] = []
    var fcmTokenArray: [String] = []
    
    func createMessage(messageText: String, chatId: String, tokenArray: [String], view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        getCurrentUser { completed in
            if completed {
                let id = UUID().uuidString
                let postedById = (Auth.auth().currentUser?.uid)!
                let postedByName = self.user.username
                let timestamp = Timestamp()
                let message = messageText
                
                let messageDetails = Message.init(id: id, chatId: chatId, sentById: postedById, sentByName: postedByName, messageText: message, timestamp: timestamp)
                
                self.postMessage(message: messageDetails, view: view, postedByName: postedByName, messageText: messageText, tokenArray: tokenArray) { success in
                    if success {
                        completion(true)
                    }else {
                        print("Error posting message")
                    }
                }
            }else {
                print("Cannot get user")
            }
        }
        
    }
    
    private func postMessage(message: Message, view: UIView, postedByName: String, messageText: String,tokenArray: [String], _ completion: @escaping ((Bool) -> Void)) {
        let data = Message.modelToData(message: message)
        
        FirebaseReference(.Messages).document(message.id).setData(data) { err in
            if err != nil {
                print("error")
            }else {
                for token in tokenArray {
                    print("+++++++\(token)")
                    PushNotificationSender().sendPushNotification(to: token, title: "New Message!", body: messageText, sentBy: postedByName)
                }
                print("Posted")
            }
        }
        completion(true)
    }
    
    func getCurrentUser(_ completion: @escaping (Bool) -> Void) {
        let userId = Auth.auth().currentUser?.uid
        FirebaseReference(.User).document(userId!).getDocument { snap, err in
            guard let snapshot = snap else {return}
            
            if snapshot.exists {
                let data = snapshot.data()
                self.user = User.init(data: data!)
                completion(true)
            }else {
                print(err?.localizedDescription)
            }
        }
    }
    
    func getFCMTokenArray(_ completion: @escaping (_ tokenArray: [String]) -> Void) {
        var fcmTokens: [String] = []
        var usersArray: [User] = []
        getUsers { users in
            usersArray = users
        }
        for user in usersArray {
            for id in self.chat.users {
                if user.id == id {
                    fcmTokens.append(user.fcmToken)
                }
            }
        }
        completion(fcmTokens)
    }
    
    private func getUsers(_ completion: @escaping (_ users: [User]) -> Void) {
        var usersArray : [User] = []
        FirebaseReference(.User).getDocuments { snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            if !snapshot!.isEmpty {
                for u in snapshot!.documents {
                    let data = u.data()
                    let user = User.init(data: data)
                    usersArray.append(user)
                }
            }
            completion(usersArray)
        }
    }
    
    func getChat(chatId: String, _ completion: @escaping (_ chats: Chat) -> Void) {
        let chatId = chatId
        
        FirebaseReference(.Chat).document(chatId).getDocument { snap, err in
            guard let snapshot = snap else {return}
            
            if snapshot.exists {
                let data = snapshot.data()
                self.chat = Chat.init(data: data!)
                completion(self.chat)
            }else {
                print(err?.localizedDescription)
            }
        }
    }
}
