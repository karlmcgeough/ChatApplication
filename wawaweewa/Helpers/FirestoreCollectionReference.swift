//
//  FirestoreCollectionReference.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import Foundation
import FirebaseFirestore

//List of collections within firebase for app
enum fCollectionReference: String {
    case User
    case Chat
    case Messages
}
//MARK: Firebase reference
func FirebaseReference(_ collectionReference: fCollectionReference) ->
CollectionReference{
    
    return Firestore.firestore().collection(collectionReference.rawValue)
}
