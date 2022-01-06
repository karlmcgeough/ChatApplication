//
//  MainChatVM.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import UIKit
import Firebase

class MainChatVM {
    
    var chats = [Chat]()
    
    func getChatsFromFirebase(completion: @escaping (_ chats: [Chat]) -> Void) {
        var chatArray: [Chat] = []
        FirebaseReference(.Chat).getDocuments { snapshot, err in
            if let error = err {
                debugPrint(error.localizedDescription)
                return
            }
            if !snapshot!.isEmpty {
                for c in snapshot!.documents {
                    let data = c.data()
                    let chat = Chat.init(data: data)
                    chatArray.append(chat)
                }
                completion(chatArray)
            }
        }
    }
}

//Create New Chat methods
extension MainChatVM {
    
    func createNewChat(chatName: String, view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        let chatId = UUID().uuidString
        let userId = Auth.auth().currentUser?.uid
        var userIds : [String] = []
        userIds.append(userId!)
        let chatDetails = Chat.init(id: chatId, users: userIds , chatName: chatName)
        
        self.saveNewChat(chat: chatDetails, view: view) { postSuccess in
            if postSuccess {
                completion(true)
            }else {
                print("Error posting chat")
            }
        }
    }
    
    private func saveNewChat(chat: Chat, view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        let data = Chat.modelToData(chat: chat)
        
        FirebaseReference(.Chat).document(chat.id).setData(data) { err in
            if err != nil {
                UIHelpers.errorAlert(message: "Error creating chat", delay: 1.5, view: view)
            }else {
                UIHelpers.successAlert(message: "Chat Created", delay: 1.5, view: view)
                completion(true)
            }
        }
    }
}
