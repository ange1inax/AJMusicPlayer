//
//  AppDelegate.swift
//  Music Player
//
//  Created by Angelina Dieu and Jane Jung on 12/02/23.
//

import UIKit

@UIApplicationMain

// Class contains Application Methods.
class AppDelegate: UIResponder, UIApplicationDelegate {

// Function performs any additional setup after the application has launched (called after application launch). 
// Function is called after application has launched. 
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        return true
    }

// Function is called when a new scene session is being created.
// returns the configuration for a new scene session.
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
// Function performs any necessary clean up when the user discards a scene session (called when user discards scene session).
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

