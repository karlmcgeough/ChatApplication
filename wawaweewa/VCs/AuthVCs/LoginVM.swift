//
//  LoginVM.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import Firebase
import UIKit
import SwiftUI

class LoginVM {
    
    //Vars
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    //MARK: Firebase methods
    func loginUser(email: String, password: String, view: UIView, _ completion: @escaping ((Bool)-> Void)) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, err in
            if err != nil {
                UIHelpers.errorAlert(message: err!.localizedDescription, delay: 1.5, view: view)
            } else {
                self.appDelegate.userDefault.set(true, forKey: "userSignedIn")
                completion(true)
            }
        }
    }
}
