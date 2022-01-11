//
//  ChatMembersView.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 10/01/2022.
//

import UIKit
import Firebase
import Kingfisher

class ChatMembersView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    //MARK: Outlets
    @IBOutlet weak var membersLbl: UILabel!
    @IBOutlet weak var membersCV: UICollectionView!
    
    //MARK: Vars
    var members: [User] = []
    var filteredMemmbers: [User] = []
    var chat: Chat!
    var listener: ListenerRegistration! = nil
    let currentUserId = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUsers { finished in
            if finished {
                for user in self.members {
                    for id in self.chat.users {
                        if user.id == id && user.id != self.currentUserId{
                            self.filteredMemmbers.append(user)
                        }
                    }
                }
                self.membersCV.reloadData()
                UIHelpers.hideLoadingAlert()
            }
        }
    }

    //MARK: Actions
    
    //MARK: Functions
    private func setupView() {
        membersCV.delegate = self
        membersCV.dataSource = self
        view.backgroundColor = UIColor(named: "backgroundGray")
    }
}

//Firebase methods
extension ChatMembersView {
    
    private func getUsers(_ completion: @escaping ((Bool) -> Void)) {
        
        FirebaseReference(.User).getDocuments { snapshot, error in
            if let error = error {
                debugPrint(error.localizedDescription)
                return
            }
            
            if !snapshot!.isEmpty {
                for u in snapshot!.documents {
                    let data = u.data()
                    let user = User.init(data: data)
                    self.members.append(user)
                }
            }
            completion(true)
        }
    }
}

//Table view methods
extension ChatMembersView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredMemmbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = membersCV.dequeueReusableCell(withReuseIdentifier: "membersCell", for: indexPath) as! MembersCell
        cell.shadowDecorate()
        cell.configureCell(user: filteredMemmbers[indexPath.row])
        cell.blockUserActionBlock = {
            
        }
        
        return cell
    }
    
}
