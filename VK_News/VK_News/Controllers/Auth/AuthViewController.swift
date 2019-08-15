//
//  AuthViewController.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import Reusable

final class AuthViewController: UIViewController {
    private enum Const {
        static let storyboardName = "AuthViewController"
    }
    private let authService = AppDelegate.shared().authService
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signInTouch(_ sender: UIButton) {
        authService.wakeUpSession()
    }
}

// MARK: StoryboardBased

extension AuthViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
