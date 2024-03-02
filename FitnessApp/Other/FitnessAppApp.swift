//
//  FitnessAppApp.swift
//  FitnessApp
//
//  Created by eren on 19.02.2024.
//

import SwiftUI
import FirebaseCore

@main
struct FitnessAppApp: App {
    
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map {String(format: "%02.2hhx", $0)}.joined()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Error: \(error.localizedDescription)")
    }
    
}
