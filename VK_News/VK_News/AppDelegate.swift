//
//  AppDelegate.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import VK_ios_sdk
import Reusable

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var authService = AuthService()
    
    static func shared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        authService.delegate = self
        window = UIWindow()
        window?.makeKeyAndVisible()
        let authVC = AuthViewController.instantiate()
        window?.rootViewController = authVC
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplicationOpenURLOptionsKey.sourceApplication.rawValue)
        return true
    }
}

// MARK: AuthServiceDelegate

extension AppDelegate: AuthServiceDelegate {
    func authServiceShouldShow(_ controller: UIViewController!) {
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
