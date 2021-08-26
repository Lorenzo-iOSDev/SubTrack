//
//  LocalNotificationManager.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 25/08/21.
//

import SwiftUI
import UserNotifications

class LocalNotificationManager: ObservableObject {
    
    var notifications = [Notification]()
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications Permitted")
            } else if let error = error{
                print("Notifications not Permitted \(error.localizedDescription)")
            }
        }
    }
    
    func sendNotification(title: String, subtitle: String?, body: String, sendIn: Double) {
        let content = UNMutableNotificationContent()
        content.title = title
        
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        
        content.body = body
        content.sound = .default
        
        var trigger: UNTimeIntervalNotificationTrigger
        
        if sendIn <= 0 {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: false)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: sendIn, repeats: false)
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
