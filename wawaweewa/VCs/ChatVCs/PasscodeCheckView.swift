//
//  PasscodeCheckView.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 10/01/2022.
//

import UIKit
import Firebase

class PasscodeCheckView: UIViewController {

    //MARK: Oulets
    @IBOutlet weak var chatNameTxt: UITextField!
    @IBOutlet weak var passcodeTxt: UITextField!
    @IBOutlet weak var joinBtn: UIButton!
    
    //MARK: Vars
    var chat: Chat!
    var callBackClosure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDetails()
    }
    
    //MARK: Actions
    @IBAction func joinAction(_ sender: Any) {
        checkPasscode()
    }
    
    //MARK: Functions
    private func setupView() {
        joinBtn.RoundedViewWithShadow(cornerRadius: 10)
    }
    
    private func setupDetails() {
        chatNameTxt.text = chat.chatName
    }
    
    private func checkPasscode() {
        if passcodeTxt.text == chat.passcode {
            addUserToChat { success in
                if success {
                    self.callBackClosure?()
                    self.dismiss(animated: true, completion: nil)
                }else {
                    print("Error adding user id to chat")
                }
            }
        } else {
            UIHelpers.errorAlert(message: "Incorrect Passcode", delay: 1.5, view: view)
        }
    }
    
    private func addUserToChat(_ completion: @escaping ((Bool) -> Void)) {
        let currentUserId = Auth.auth().currentUser?.uid
        let chatId = chat.id
        let chatRef = FirebaseReference(.Chat).document(chatId)
        
        chatRef.updateData(["users" : FieldValue.arrayUnion([currentUserId!])])
        
        completion(true)
    }
    
    private func showChatView(_ chat: Chat){
        let messengerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "messengerVC") as! MessengerVC
            
        messengerVC.chat = chat
        present(messengerVC, animated: true, completion: nil)
       // self.navigationController!.pushViewController(messengerVC, animated: true)
    }
}
