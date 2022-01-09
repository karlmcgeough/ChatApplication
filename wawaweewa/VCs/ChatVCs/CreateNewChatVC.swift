//
//  CreateNewChatVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit

class CreateNewChatVC: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var chatNameTxt: UITextField!
    @IBOutlet weak var createChatBtn: UIButton!
    @IBOutlet weak var chatPasscode: UITextField!
    
    //MARK: Vars
    var vm = MainChatVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func createChatAction(_ sender: Any) {
        if chatNameTxt.text != "" && chatPasscode.text != "" {
            vm.createNewChat(chatName: chatNameTxt.text!, chatPasscode: chatPasscode.text!, view: view) { postSuccess in
                if postSuccess {
                    Helpers.performAfter(2.0) {
                        self.dismiss(animated: true, completion: nil)
                    }
                    print("New chat posted")
                }else {
                    print("chat not posted")
                }
            }
        }else {
            UIHelpers.errorAlert(message: "Please enter a chat name & Passcode", delay: 1.5, view: self.view)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.setViewShadow(radius: 10)
        chatNameTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        createChatBtn.setViewShadow(radius: 10)
    }
}
