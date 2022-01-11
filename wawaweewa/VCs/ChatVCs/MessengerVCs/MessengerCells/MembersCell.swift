//
//  MembersCell.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 10/01/2022.
//

import UIKit
import Kingfisher

class MembersCell: UICollectionViewCell {
    
    
    //MARK: Outlets
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    
    //Var
    var blockUserActionBlock: (() -> Void)?
    
    //Configure cell
    func configureCell(user: User) {
        userNameLbl.text = user.username
        userProfileImage.layer.cornerRadius = 50
        if let url = URL(string: user.profileImageUrl) {
            userProfileImage.kf.setImage(with: url)
        }
    }
    
    @IBAction func blockUser(_ sender: Any) {
       blockUserActionBlock?()
    }
    
}
