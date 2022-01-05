//
//  RegisterVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit
import SwiftUI

class RegisterVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    //MARK: Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var selectProfileImageBtn: UIButton!
    @IBOutlet weak var usernameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    @IBOutlet weak var confirmPasswordTxt: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    //MARK: Vars
    var email: String?
    var password: String?
    var confirmPassword: String?
    var selectedImage: UIImage?
    var vm = RegisterVM()
    let appdelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
   
    @IBAction func selectProfileImageAction(_ sender: Any) {
        uploadImageTappedFunc()
    }
 
    @IBAction func registerAction(_ sender: Any) {
        UIHelpers.showLoadingAlert(view: view)
        if textFieldsPopulated() {
            self.vm.registerUser(email: email!, password: password!, username: usernameTxt.text!, selectedImage: selectedImage!, view: view) { regSuccess in
                if regSuccess {
                    UIHelpers.hideLoadingAlert()
                    Helpers.performAfter(2.0){
                        self.dismiss(animated: true, completion: nil)
                    }
                } else {
                    print("Error registering user")
                }
            }
        } else {
            UIHelpers.errorAlert(message: "Ensure all fields are complete & profile image selected", delay: 1.5, view: view)
        }
    }
    
    @IBAction func closeAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: functions
    
    private func setupView() {
        registerBtn.isEnabled = false
        selectProfileImageBtn.layer.cornerRadius = 40
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.setViewShadow(radius: 10)
        usernameTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        emailTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        passwordTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        confirmPasswordTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        registerBtn.setViewShadow(radius: 10)
    }
    
    private func textFieldsPopulated() -> Bool {
        self.email = emailTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.password = passwordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.confirmPassword = confirmPasswordTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        return (email != "" && password != "" && confirmPassword != "" && usernameTxt.text != "" && selectedImage != nil)
    }
}

extension RegisterVC {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var chosenImage: UIImage?
        picker.allowsEditing = true
        if let editedImage = info[.editedImage] as? UIImage {
            chosenImage = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            chosenImage = originalImage
        }
        if let finalImage = chosenImage {
            chosenImage = finalImage
            
        }
        dismiss(animated: true, completion: nil)
        selectedImage = chosenImage
        selectProfileImageBtn.imageView?.image = selectedImage
        selectProfileImageBtn.setBackgroundImage(selectedImage, for: .normal)
        selectProfileImageBtn.setTitle("", for: .normal)
        selectProfileImageBtn.layer.cornerRadius = 40
        selectProfileImageBtn.layer.masksToBounds = true
        registerBtn.isEnabled = true
    }
    
    func uploadImageTappedFunc() {
        // Image editing needs to go in
        let imgPickerController = UIImagePickerController()
        imgPickerController.delegate = self
        present(imgPickerController, animated: true, completion: nil)
    }
}
