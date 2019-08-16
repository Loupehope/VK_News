//
//  AuthService.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ controller: UIViewController!)
    func authServiceSignIn()
    func authServiceSignInFail()
}

final class AuthService: NSObject {
    private enum Const {
        static let id = "7096692"
        static let scope = ["wall,offline,friends"]
    }
    private let vkSdk: VKSdk = VKSdk.initialize(withAppId: Const.id)
    var token: String {
        return VKSdk.accessToken().accessToken
    }
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        VKSdk.wakeUpSession(Const.scope) { [delegate] (state, error) in
            if error != nil { return }
            switch (state) {
            case VKAuthorizationState.authorized:
                delegate?.authServiceSignIn()
            case VKAuthorizationState.initialized:
                VKSdk.authorize(Const.scope)
            default:
                break
            }
        }
    }
}

extension VKSdk {
    static func logout() {
        VKSdk.forceLogout()
        UserDefaults.standard.set(false, forKey: UserDefaults.Const.userAuthKey)
    }
}

// MARK: VKSdkDelegate

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
            UserDefaults.standard.set(true, forKey: UserDefaults.Const.userAuthKey)
            delegate?.authServiceSignIn()
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        
    }
}

// MARK: VKSdkUIDelegate

extension AuthService: VKSdkUIDelegate {
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        delegate?.authServiceShouldShow(controller)
    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
}

