//
//  LoginVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!
    
    //MARK: Vars
    let createAccountVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createAccountVC") as? RegisterVC
    var vm = LoginVM()
    var email: String?
    var password: String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
                self.performSegue(withIdentifier: "login2HomeSW", sender: self)
        }
    }
    
    //MARK: Actions
    @IBAction func loginAction(_ sender: Any) {
        if textFieldsNotEmpty() {
            self.vm.loginUser(email: email!, password: password!, view: self.view) { isLoggedIn in
                if isLoggedIn {
                    self.performSegue(withIdentifier: "login2HomeSW", sender: self)
                } else {
                    UIHelpers.errorAlert(message: "Please ensure all details have been entered", delay: 1.5, view: self.view)
                }
            }
        }
    }
    
    @IBAction func createAccountAction(_ sender: Any) {
        self.present(createAccountVC!, animated: true, completion: nil)
    }
    
    //MARK: Functions
    
    private func setupView(){
        emailTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        emailTxt.keyboardType = .emailAddress
        passwordTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        passwordTxt.isSecureTextEntry = true
        loginBtn.setViewShadow(radius: 10)
        createAccountBtn.setButtonWithBorder(borderColour: UIColor(named: "tealBlueColour")!, radius: 10, backgroundColour: .clear)
    }
    
    private func textFieldsNotEmpty() -> Bool {
        self.email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        return (email != "" && password != "")
        
    }
}
