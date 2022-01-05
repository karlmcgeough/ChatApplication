//
//  MainChatVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit
import Firebase

class MainChatVC: UIViewController {
    
    let createChatVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createChatVC") as? CreateNewChatVC
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func newChatAction(_ sender: Any) {
        present(createChatVC!, animated: true, completion: nil)
    }
    
    @IBAction func profileAction(_ sender: Any) {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
    }
}
