//
//  SceneDelegate.swift
//  Music Player
//
//  Created by Angelina Dieu and Jane Jung on 12/02/23
//

import UIKit
import SwiftUI

// Class contains Scene Methods.
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

// Function sets up the main content view when the scene is created.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    // Function cleans up or saves critical data before the app closes. 
    // Function is called when the app's scene is disconnected (user closed the app or the system terminated it). 
    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    // Function carries out tasks such as refreshing user interface or resuming any paused activities while app is in foreground. 
    // Function is called when the app's scene becomes active. 
    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    // Function prepares the app for background mode (pauses animation, stops ongoing tasks, etc.).
    // Function is called when the app's scene is about to resign its active status.
    func sceneWillResignActive(_ scene: UIScene) {

    }

    // Function prepares the app for foreground mode (updates data, prepares UI for user interaction, etc.).
    // Function is called right before the app's scene enters the foreground (becoming visible) again after being in the background. 
    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    // Function carries out tasks such as saving user data, stopping unneccessary processes or tasks, etc.
    // Function is called when the app's scene enters the background (no longer visible). 
    func sceneDidEnterBackground(_ scene: UIScene) {
   
    }


}

