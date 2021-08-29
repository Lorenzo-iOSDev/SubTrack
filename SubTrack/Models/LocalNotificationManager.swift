//
//  LocalNotificationManager.swift
//  SubTrack
//
//  Created by Lorenzo Zemp on 25/08/21.
//

import SwiftUI
import UserNotifications

class LocalNotificationManager: ObservableObject {
    
    init() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted == true && error == nil {
                print("Notifications Permitted")
            } else if let error = error{
                print("Notifications not Permitted \(error.localizedDescription)")
            }
        }
    }
    
    //Function to add notification to UNNotificationCenter
    func sendNotification(id: String, title: String, subtitle: String?, body: String, sendIn: Double) {
        print("new notification id is: \(id)")
        
        let content = UNMutableNotificationContent()
        content.title = title
        
        if let subtitle = subtitle {
            content.subtitle = subtitle
        }
        
        content.body = body
        content.sound = .default
        
        var trigger: UNTimeIntervalNotificationTrigger
        
        if sendIn <= 0 {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
        } else {
            trigger = UNTimeIntervalNotificationTrigger(timeInterval: sendIn, repeats: false)
        }
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func removeNotification(id: String) {
        print("ID to remove is \(id)")
        
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { notificationRequests in
            for notification in notificationRequests {
                if notification.identifier == id {
                    print("Did not remove notification")
                } else {
                    print("Removed notification")
                }
            }
        }
    }
}
