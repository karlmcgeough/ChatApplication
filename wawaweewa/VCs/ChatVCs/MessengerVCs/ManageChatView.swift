//
//  ManageChatView.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 10/01/2022.
//

import UIKit
import Firebase
import BottomSheetController

class ManageChatView: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var chatNameTxt: UITextField!
    @IBOutlet weak var chatPasscodeTxt: UITextField!
    @IBOutlet weak var chatMembersBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    
    //MARK: Vars
    var chat: Chat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
       
    }

    //MARK: Actions
    @IBAction func viewChatMembersBtn(_ sender: Any) {
        showMembersView()
    }
    
    
    @IBAction func saveAction(_ sender: Any) {
        saveUpdatedDetails { success in
            if success {
                UIHelpers.successAlert(message: "Saved!", delay: 1.5, view: self.view)
            }
        }
    }
    
    //MARK: Functions
    private func setupView() {
        chatMembersBtn.RoundedViewWithShadow(cornerRadius: 10)
        saveBtn.RoundedViewWithShadow(cornerRadius: 10)
        chatNameTxt.text = chat.chatName
        chatPasscodeTxt.text = chat.passcode
        if chat.ownerId == Auth.auth().currentUser?.uid {
            chatNameTxt.isEnabled = true
            chatPasscodeTxt.isEnabled = true
        } else {
            chatNameTxt.isEnabled = false
            chatPasscodeTxt.isEnabled = false
            saveBtn.isEnabled = false
        }
    }
    
    func showMembersView() {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateViewController(identifier: "ChatMembersView") as? ChatMembersView else {
            return
        }
        viewController.chat = chat
        let bottomSheetController = BottomSheetController(contentViewController: viewController)
        present(bottomSheetController, animated: true)
    }
}

//firebase functions
extension ManageChatView {
    
  private func saveUpdatedDetails(_ completion: @escaping ((Bool) -> Void)) {
        
      let chatId = chat.id
      
      let chatRef = FirebaseReference(.Chat).document(chatId)
      
      chatRef.updateData(["chatName" : chatNameTxt.text!])
      chatRef.updateData(["passcode" : chatPasscodeTxt.text!])
      completion(true)
    }
}
