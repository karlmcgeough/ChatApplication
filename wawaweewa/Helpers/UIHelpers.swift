//
//  UIHelpers.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import JGProgressHUD
import UIKit

class UIHelpers {
    
    static func errorAlert(message: String, delay: Double, view: UIView) {
        let hud = JGProgressHUD(automaticStyle: ())
        
        hud.textLabel.text = message
        hud.indicatorView = JGProgressHUDErrorIndicatorView()
        hud.show(in: view)
        hud.dismiss(afterDelay: delay)
    }
    
    static func successAlert(message: String, delay: Double, view: UIView) {
        let hud = JGProgressHUD(automaticStyle: ())
        
        hud.textLabel.text = message
        hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        hud.show(in: view)
        hud.dismiss(afterDelay: delay)
    }
    
    static func showLoadingAlert(view: UIView) {
        let hud = JGProgressHUD(style: .dark)
        hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        hud.textLabel.text = "Loading"
        hud.show(in: view)
    }
    
    static func hideLoadingAlert() {
        DispatchQueue.main.async {
            let hud = JGProgressHUD(automaticStyle: ())
            hud.removeFromSuperview()
            hud.dismiss()
        }
    }
    
}
