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
    
    func createMessage(messageText: String, chatId: String,view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        let id = UUID().uuidString
        let postedById = (Auth.auth().currentUser?.uid)!
        let postedByName = User.init().username
        let timestamp = Timestamp()
        let message = messageText
        
        let messageDetails = Message.init(id: id, chatId: chatId, sentById: postedById, sentByName: postedByName, messageText: message, timestamp: timestamp)
        
        self.postMessage(message: messageDetails, view: view) { success in
            if success {
                completion(true)
            }else {
                print("Error posting message")
            }
        }
    }
    
    private func postMessage(message: Message, view: UIView, _ completion: @escaping ((Bool) -> Void)) {
        let data = Message.modelToData(message: message)
        
        FirebaseReference(.Messages).document(message.id).setData(data) { err in
            if err != nil {
                print("error")
            }else {
                print("Posted")
                completion(true)
            }
        }
    }
}
