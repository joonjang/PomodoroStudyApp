//
//  NotificationController.swift
//  PomodoroStudy
//
//  Created by Joon Jang on 2022-09-24.
//

import UIKit
import UserNotifications

class NotificationController: UIViewController {
    
    // https://www.youtube.com/watch?v=JuqQUP0pnZY&t=149s
    
    // 1 ask for permission
    var center = UNUserNotificationCenter.current()
    
    func askNotification() {
        center.requestAuthorization(options: [.alert, .sound])
        { (granted, error) in
            // code to run if access not granted
        }
    }
    
    func notify(timeInterval: Double){
        
        // 2 create notification content
        let content = UNMutableNotificationContent()
//        content.title = "Timer Complete"
//        content.body = "Choose your next timer interval"
        content.title = NSString.localizedUserNotificationString(forKey: "Time Complete", arguments: nil)
//        content.body = NSString.localizedUserNotificationString(forKey: "Choose your next timer interval", arguments: nil)
        content.sound = UNNotificationSound.default
        
        // 3 create notification trigger
        let date = Date().addingTimeInterval(timeInterval)

        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // 4 create request
        let uuidString = UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        // 5 register request
        center.add(request) { (error) in
            // check error and handle
        }
    }
    
    func cancelNotify() {
        center.removeAllPendingNotificationRequests()
    }
}
