//
//  PushNotificationManager.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 11/01/2022.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseMessaging
import UIKit
import UserNotifications

class PushNotificationManager: NSObject, MessagingDelegate, UNUserNotificationCenterDelegate {
    let userID: String
    init(userID: String) {
        self.userID = userID
        super.init()
    }
    func registerForPushNotifications(currentToken: String) {
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            // For iOS 10 data message (sent via FCM)
            Messaging.messaging().delegate = self
        } else {
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
        }
        UIApplication.shared.registerForRemoteNotifications()
        updateFirestorePushTokenIfNeeded(currentUserToken: currentToken)
    }
    func updateFirestorePushTokenIfNeeded(currentUserToken: String) {
        let token = Messaging.messaging().fcmToken
        if token == currentUserToken{
            print("token match")
        }else {
            let currentUser = Auth.auth().currentUser?.uid
            let usersRef = FirebaseReference(.User).document(currentUser!)
            usersRef.updateData(["fcmToken": token])
        }
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingDelegate) {
        //print(remoteMessage.appData)
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        updateFirestorePushTokenIfNeeded(currentUserToken: fcmToken!)
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response)
    }
}
