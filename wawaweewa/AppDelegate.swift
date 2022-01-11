//
//  AppDelegate.swift
//  wawaweewa
//
//  Created by Karl McGeough on 05/01/2022.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let userDefault = UserDefaults.standard
    let loggedIn = UserDefaults.standard.bool(forKey: "userSignedIn")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //UNUserNotificationCenter.current().delegate = self
        IQKeyboardManager.shared.enable = true
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        let userInfo = response.notification.request.content.userInfo
//        if let chatID = userInfo["user"] as? String {
//            // here you can instantiate / select the viewController and present it
//            print(chatID)
//            guard let window = UIApplication.shared.keyWindow else {return}
//
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//
//            let chatVC = storyboard.instantiateViewController(withIdentifier: "messengerVC") as! MessengerVC
//            chatVC.chatId = chatID
//            let navigationController = UINavigationController(rootViewController: chatVC)
//            navigationController.modalPresentationStyle = .fullScreen
//
//            window.rootViewController = navigationController
//            window.makeKeyAndVisible()
//        }
//        completionHandler()
//    }

}
