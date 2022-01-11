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
    var chat: Chat!
    var listener: ListenerRegistration! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getUsers { finished in
            if finished {
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
        self.listener = FirebaseReference(.User).addSnapshotListener({ snap, err in
            if let error = err {
                debugPrint(error.localizedDescription)
                return
            }
            snap?.documentChanges.forEach({ c in
                let data = c.document.data()
                let user = User.init(data: data)
                
                switch c.type {
                case .added:
                    self.onDocumentAdded(change: c, user: user)
                case .modified:
                    self.onDocumentModified(change: c, user: user)
                case .removed:
                    self.onDocumentRemoved(change: c)
                }
            })
        })
    }
    
    //MARK:Functions
        func onDocumentAdded(change: DocumentChange, user: User) {
            let newIndex = Int(change.newIndex)
            members.insert(user, at: newIndex)
            membersCV.insertItems(at:  [IndexPath(item: newIndex, section: 0)])
        }
        
        func onDocumentModified(change: DocumentChange, user: User) {
            if change.newIndex == change.oldIndex {
                
                // Row modified but stayed in same position
                let index = Int(change.newIndex)
                members[index] = user
                membersCV.reloadItems(at:[IndexPath(item: index, section: 0)])
            } else {
                
                // Row changed and moved position
                let oldIndex = Int(change.oldIndex)
                let newIndex = Int(change.newIndex)
                members.remove(at: oldIndex)
                members.insert(user, at: newIndex)
                membersCV.moveItem(at:IndexPath(item: oldIndex, section: 0), to: IndexPath(item: newIndex, section: 0))
            }
        }
        
        func onDocumentRemoved(change: DocumentChange) {
            let oldIndex = Int(change.oldIndex)
            members.remove(at: oldIndex)
            membersCV.deleteItems(at: [IndexPath(item: oldIndex, section: 0)])
        }
     
}

//Table view methods
extension ChatMembersView {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return members.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = membersCV.dequeueReusableCell(withReuseIdentifier: "membersCell", for: indexPath) as! MembersCell
        cell.shadowDecorate()
        cell.configureCell(user: members[indexPath.row])
        cell.blockUserActionBlock = {
            
        }
        
        return cell
    }
    
}
