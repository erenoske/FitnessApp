//
//  NotificationHandler.swift
//  FitnessApp
//
//  Created by eren on 23.02.2024.
//

import Foundation
import UserNotifications

class NotificationHandler {
    
    func askPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("Access granted!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
    
    func sendNotification(timeInterval : Double = 10.0, title: String, body: String) async {
        var trigger : UNNotificationTrigger?
        
        trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
    
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = UNNotificationSound.default
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        do {
            try await notificationCenter.add(request)
        } catch {
            print("noti error: \(error)")
        }
        
        print("notification function")
    }
}
