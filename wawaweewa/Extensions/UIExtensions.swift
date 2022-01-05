//
//  UIExtensions.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import UIKit

extension UITextField {
    
    func setUnderLine(colour: UIColor) {
        let border = CALayer()
        let width = CGFloat(0.5)
        border.borderColor = colour.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
    
}

extension UIButton {
    
    func RoundedViewWithShadow(cornerRadius: Int) {
        layer.cornerRadius = CGFloat(cornerRadius)
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 7
        layer.shadowOpacity = 0.6
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.darkGray.cgColor
    }
    
    func setButtonWithBorder(borderColour: UIColor, radius: Int, backgroundColour: UIColor) {
         layer.backgroundColor = backgroundColour.cgColor
         layer.cornerRadius = CGFloat(radius)
         layer.borderWidth = 1
         layer.borderColor = borderColour.cgColor
     }
}

extension UIView {
    func setViewShadow(radius: Int) {
        layer.cornerRadius = CGFloat(radius)
        clipsToBounds = true
        layer.masksToBounds = false
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 5)
        layer.shadowColor = UIColor.lightGray.cgColor
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
            let maskPath = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius))

            let shape = CAShapeLayer()
            shape.path = maskPath.cgPath
            layer.mask = shape
        }
}

extension UITableViewCell {
    func shadowDecorate(radius: CGFloat = 8,
                           shadowColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3),
                           shadowOffset: CGSize = CGSize(width: 0, height: 1.0),
                           shadowRadius: CGFloat = 3,
                           shadowOpacity: Float = 1) {
           contentView.layer.cornerRadius = radius
           contentView.layer.borderWidth = 1
           contentView.layer.borderColor = UIColor.clear.cgColor
           contentView.layer.masksToBounds = true

           layer.shadowColor = shadowColor.cgColor
           layer.shadowOffset = shadowOffset
           layer.shadowRadius = shadowRadius
           layer.shadowOpacity = shadowOpacity
           layer.masksToBounds = false
           layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: radius).cgPath
           layer.cornerRadius = radius
       }
   }
