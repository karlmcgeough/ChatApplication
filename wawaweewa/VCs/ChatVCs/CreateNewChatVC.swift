//
//  CreateNewChatVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit

class CreateNewChatVC: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var chatNameTxt: UITextField!
    @IBOutlet weak var createChatBtn: UIButton!
    
    //MARK: Vars
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    @IBAction func createChatAction(_ sender: Any) {
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.setViewShadow(radius: 10)
        chatNameTxt.setUnderLine(colour: UIColor(named: "tealBlueColour")!)
        createChatBtn.setViewShadow(radius: 10)
    }
}
