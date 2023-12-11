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

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
       
    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
      
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
   
    }


}

