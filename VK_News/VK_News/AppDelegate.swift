//
//  AppDelegate.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Reusable
import UIKit
import VK_ios_sdk

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var authService = AuthService()
    
    static func shared() -> AppDelegate {
        guard let shared = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Couldn't cast to AppDelegate")
        }
        return shared
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        authService.delegate = self
        window = UIWindow()
        window?.makeKeyAndVisible()
        window?.rootViewController = AuthViewController.instantiate()
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        VKSdk.processOpen(url, fromApplication: sourceApplication)
        return true
    }
}

// MARK: AuthServiceDelegate

extension AppDelegate: AuthServiceDelegate {
    func authServiceShouldShow(_ controller: UIViewController) {
        window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
    func authServiceSignIn() {
        let feedVC = FeedViewController.instantiate()
        let navVC = UINavigationController(rootViewController: feedVC)
        window?.rootViewController = navVC
    }
    
    func authServiceSignInFail() {
        print(#function)
    }
}
