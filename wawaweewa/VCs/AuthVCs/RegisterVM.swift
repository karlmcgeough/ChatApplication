//
//  registerVM.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Firebase
import UIKit

final class RegisterVM {
    
    func registerUser(email: String, password: String, username: String, selectedImage: UIImage, view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if err == nil {
                
                let userId = result?.user.uid
                var imageUrl: String!
                let storage = Storage.storage()
                let storageRef = storage.reference()
                let mediaFolder = storageRef.child("ProfileImages")
                
                if let data = selectedImage.jpegData(compressionQuality: 0.5) {
                    let imageReference = mediaFolder.child("\(userId).jpg")
                    imageReference.putData(data, metadata: nil) { (metadata, error) in
                        if error != nil {
                            print(error?.localizedDescription as Any)
                        } else {
                            imageReference.downloadURL { url, err in
                                if err == nil {
                                    let imgUrl = url?.absoluteString
                                    imageUrl = imgUrl
                                    
                                    let userDetails = User.init(id: userId!, username: username, email: email, fcmToken: "", profileImageUrl: imageUrl)
                                    self.saveUserDetails(user: userDetails)
                                    UIHelpers.successAlert(message: "Account Created Successfully!", delay: 1.5, view: view)
                                    completion(true)
                                }
                            }
                        }
                    }
                } else {
                    UIHelpers.errorAlert(message: err!.localizedDescription, delay: 1.5, view: view)
                }
            }
        }
    }
    
    func saveUserDetails(user: User) {
        let data = User.modelToData(user: user)
        
        FirebaseReference(.User).document(user.id).setData(data) { error in
            if error != nil {
                print("Error saving user \(error?.localizedDescription)")
            } else {
                print("User saved")
            }
        }
    }
    
}
