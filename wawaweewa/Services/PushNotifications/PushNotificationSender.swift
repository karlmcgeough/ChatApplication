//
//  PushNotificationSender.swift
//  wawaweewa
//
//  Created by Karl mcgeough on 11/01/2022.
//

import Foundation
import UIKit
class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String, sentBy: String) {
                let url = URL(string: "https://fcm.googleapis.com/fcm/send")!
                var request = URLRequest(url: url)
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("key=AAAAQsNR1BM:APA91bH3iVhx_QZfMiBIc97no1MH9vg5cV60th4WY75MWosAv2xRUeDX83QeyXkJH-ANga56XLZ1Jo274gltKdj8uOZS3oS86VOYgpKpw3do1h0ECEY6t8B4Q9SoxOtKo-B-9Lgshtyl", forHTTPHeaderField: "Authorization")
                request.httpMethod = "POST"
        
                var notData: [String: Any] =  ["to" : token,
                                            "notification" : ["title" : title, "body" : body, "sound": "default"],"data" : ["user" : sentBy]
                ]
                request.httpBody = try? JSONSerialization.data(withJSONObject: notData, options: [])
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data, error == nil else {                                                 // check for fundamental networking error
                        print("error=\(error)")
                        return
                    }
        
                    if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(response)")
                    }
        
                    let responseString = String(data: data, encoding: .utf8)
                    print("responseString = \(responseString)")
                }
                task.resume()
        }
        }
