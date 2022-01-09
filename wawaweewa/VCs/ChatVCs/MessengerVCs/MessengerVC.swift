//
//  MessengerVC.swift
//  wawaweewa
//
//  Created by Karl McGeough on 09/01/2022.
//

import UIKit

class MessengerVC: UIViewController {

    //Outlets
    @IBOutlet weak var messageTxtView: UITextView!
    @IBOutlet weak var messageSendBtn: UIButton!
    @IBOutlet weak var messagesTableView: UITableView!
    
    //Vars
    var vm = MessengerVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //Actions
    @IBAction func messageSendAction(_ sender: Any) {
    }
    
    //Methods
    private func setupView() {
        
    }
    
}

//Table view methods
extension MessengerVC {
    
}
