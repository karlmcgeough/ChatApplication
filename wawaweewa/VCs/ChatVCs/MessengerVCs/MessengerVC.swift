//
//  MessengerVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 09/01/2022.
//

import UIKit
import Firebase

class MessengerVC: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {

    //Outlets
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var messageSendBtn: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    
    //Vars
    var listener: ListenerRegistration! = nil
    var vm = MessengerVM()
    var chat: Chat!
    var messageArray: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getMessages()
    }
    
    //Actions
    @IBAction func messageSendAction(_ sender: Any) {
        if messageTxtView.text != "" {
            vm.createMessage(messageText: messageTxtView.text, chatId: chat.id, view: view) { success in
                if success {
                    self.messageTxtView.text = "Write something here.."
                    self.messageTxtView.textColor = UIColor.lightGray
                    self.messageSendBtn.isEnabled = false
                    print("posted")
                }else {
                    print("Error")
                }
            }
        }
    }
    
    //Methods
    private func setupView() {
        messagesTableView.delegate = self
        messagesTableView.dataSource = self
        self.navigationItem.title = chat.chatName
        messageTxtView.layer.borderColor = UIColor(named: "tealBlueColour")?.cgColor
        messageTxtView.layer.borderWidth = 1.0
        messageTxtView.layer.cornerRadius = 10
        messageTxtView.delegate = self
        messageTxtView.text = "Write something here.."
        messageTxtView.textColor = UIColor.lightGray
        messageSendBtn.isEnabled = false
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {

        if messageTxtView.textColor == UIColor.lightGray {
            messageTxtView.text = ""
            messageSendBtn.isEnabled = true
            messageTxtView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {

        if messageTxtView.text == "" {
            messageSendBtn.isEnabled = false
            messageTxtView.text = "Write something here.."
            messageTxtView.textColor = UIColor.lightGray
        }
    }
}

//Table view methods
extension MessengerVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let youCell = messagesTableView.dequeueReusableCell(withIdentifier: "youCell", for: indexPath) as? YouCell
        let recievedCell = messagesTableView.dequeueReusableCell(withIdentifier: "recievedCell", for: indexPath) as? RecievedCell
        
        if messageArray[indexPath.row].sentById == Auth.auth().currentUser?.uid {
            youCell!.bubbleView.roundDifferentCorners([.bottomRight, .topLeft, .topRight], radius: 5)
            youCell?.messageTextLbl.text = messageArray[indexPath.row].messageText
            return youCell!
        }else {
            recievedCell?.bubbleView.roundDifferentCorners([.bottomLeft, .topLeft, .topRight], radius: 5)
            recievedCell!.messageTextLbl.text = messageArray[indexPath.row].messageText
            recievedCell?.sendByLbl.text = messageArray[indexPath.row].sentByName
            return recievedCell!
        }

    }
}

//Snapshot for messages
extension MessengerVC {
    
    func getMessages() {
        let chatId = chat.id
        
        self.listener = FirebaseReference(.Messages).whereField("chatId", isEqualTo: chatId).order(by: "timeStamp", descending: false).addSnapshotListener({ snapshot, err in
            if let error = err {
                debugPrint(error.localizedDescription)
                return
            }
            
            snapshot?.documentChanges.forEach({ (change) in
                let data = change.document.data()
                let message = Message.init(data: data)
                
                switch change.type {
                case .added:
                    self.onDocumentAdded(change: change, message: message)
                case .modified:
                    self.onDocumentModified(change: change, message: message)
                case .removed:
                    self.onDocumentRemoved(change: change)
                }
            })
        })
    }

        //MARK:Functions
        func onDocumentAdded(change: DocumentChange, message: Message) {
            let newIndex = Int(change.newIndex)
            messageArray.insert(message, at: newIndex)
            messagesTableView.insertRows(at: [IndexPath(item: newIndex, section: 0)], with: .automatic)
        }
        
        func onDocumentModified(change: DocumentChange, message: Message) {
            if change.newIndex == change.oldIndex {
                
                // Row modified but stayed in same position
                let index = Int(change.newIndex)
                messageArray[index] = message
                //setupDetails()
                messagesTableView.reloadRows(at: [IndexPath(item: index, section: 0)], with: .automatic)
            } else {
                
                // Row changed and moved position
                let oldIndex = Int(change.oldIndex)
                let newIndex = Int(change.newIndex)
                messageArray.remove(at: oldIndex)
                messageArray.insert(message, at: newIndex)
                messagesTableView.moveRow(at: IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
            }
        }
        
        func onDocumentRemoved(change: DocumentChange) {
            let oldIndex = Int(change.oldIndex)
            messageArray.remove(at: oldIndex)
            messagesTableView.deleteRows(at: [IndexPath(item: oldIndex, section: 0)], with: .automatic)
        }
}
