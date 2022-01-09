////
////  ChatMessengerVC.swift
////  wawaweewa
////
////  Created by Karl mcgeough on 06/01/2022.
////
//
//import UIKit
//import MessengerKit
//
//class ChatMessengerVC: MSGMessengerViewController {
//
//    // Users in the chat
//       
//    let karl = User.Users(displayName: "Karl", avatar: UIImage(named: "newProfileImageSvg"), avatarUrl: nil, isSender: true)
//    let tim = User.Users(displayName: "Tim", avatar: UIImage(named: "newProfileImageSvg"), avatarUrl: nil, isSender: false)
//    
//       // Messages
//       
//       lazy var messages: [[MSGMessage]] = {
//           return [
//               [
//                   MSGMessage(id: 1, body: .emoji("🐙💦🔫"), user: tim, sentAt: Date()),
//               ],
//               [
//                   MSGMessage(id: 2, body: .text("wawaweewa"), user: karl, sentAt: Date()),
//                   MSGMessage(id: 3, body: .text("Is a new message app"), user: karl, sentAt: Date())
//               ],
//               [
//                MSGMessage(id: 4, body: .text("for us to use for the craic"), user: tim, sentAt: Date())
//               ]
//           ]
//       }()
//    override var style: MSGMessengerStyle {
//        var style = MessengerKit.Styles.travamigos
//        let colour1 = UIColor(named: "tealBlueColour")!.cgColor
//        let colour2 = UIColor(named: "lighterTealColour")!.cgColor
//        let gradient1 = [colour1, colour2]
//        let gradient2 = [colour2, colour1]
//        style.incomingGradient = gradient1
//        style.outgoingGradient = gradient2
//        return style
//    }
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        dataSource = self
//    }
// 
//}
//
//extension ChatMessengerVC: MSGDataSource {
//    
//    func numberOfSections() -> Int {
//        return messages.count
//    }
//    
//    func numberOfMessages(in section: Int) -> Int {
//         return messages[section].count
//     }
//     
//     func message(for indexPath: IndexPath) -> MSGMessage {
//         return messages[indexPath.section][indexPath.item]
//     }
//     
//     func footerTitle(for section: Int) -> String? {
//         return "Just now"
//     }
//     
//     func headerTitle(for section: Int) -> String? {
//         return messages[section].first?.user.displayName
//     }
//}
