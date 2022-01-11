//
//  MainChatVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit
import Firebase
import BottomSheetController

class MainChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var chatNameTV: UITableView!
    
    let createChatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createChatVC") as? CreateNewChatVC
    var chatArray: [Chat] = []
    var vm = MainChatVM()
    let refreshControl = UIRefreshControl()
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatNameTV.delegate = self
        chatNameTV.dataSource = self
        setupRefreshControl()
        
        vm.getCurrentUser { user in
            self.currentUser = user
            let currentUserId = self.currentUser.id
            let pushManager = PushNotificationManager(userID: currentUserId)
            pushManager.registerForPushNotifications(currentToken: self.currentUser.fcmToken)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        vm.getChatsFromFirebase { chats in
            self.chatArray = chats
            self.chatNameTV.reloadData()
        }
    }
    
    @IBAction func newChatAction(_ sender: Any) {
        present(createChatVC!, animated: true, completion: nil)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        vm.logOutUser { error in
            if error == nil {
                if let storyboard = self.storyboard {
                    let loginVC = storyboard.instantiateViewController(withIdentifier: "loginVC")
                    self.view.window?.rootViewController = loginVC
                    self.view.window?.makeKeyAndVisible()
                }
            }else {
                print("Error logging user out")
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        vm.getChatsFromFirebase { chats in
            self.chatArray = chats
            self.chatNameTV.reloadData()
        }
        refreshControl.endRefreshing()
    }
    
    func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        chatNameTV.addSubview(refreshControl)
    }
}

//MARK: Table view methods
extension MainChatVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatNameTV.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath) as! chatCell
        
        cell.chatNameLbl.text = chatArray[indexPath.row].chatName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        showChatView(chatArray[indexPath.row])
    }
    
    private func showChatView(_ chat: Chat){
        let messengerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "messengerVC") as! MessengerVC
        
        messengerVC.chat = chat
        self.navigationController!.pushViewController(messengerVC, animated: true)
    }
}
