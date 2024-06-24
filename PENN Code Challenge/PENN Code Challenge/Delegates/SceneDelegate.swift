//
//  SceneDelegate.swift
//  PENN Code Challenge
//
//  Created by Tyler Edlin on 6/20/24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        if Auth.auth().currentUser == nil {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController
        } else {
            window?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as? CustomTabBarViewController
        }
        window?.makeKeyAndVisible()
    }
}

