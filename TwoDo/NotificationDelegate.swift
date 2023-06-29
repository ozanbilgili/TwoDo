//
//  NotificationDelegate.swift
//  TwoDo
//
//  Created by Ozan Bilgili on 29.06.2023.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    // This function will be called when a notification is delivered to a foreground app.
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Handle the notification here...

        // Complete the handler. Change this to fit your notification presentation needs.
        completionHandler([.banner, .list, .sound])
    }
    
    // This function will be called right after user taps on the notification.
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // Handle the notification here...

        // Don't forget to call the completion handler!
        completionHandler()
    }
}

