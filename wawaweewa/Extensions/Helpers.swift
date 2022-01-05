//
//  Helpers.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation

class Helpers {
    
   static func performAfter(_ delay: Double, completion: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            completion()
        }
    }
}
