//
//  AuthService.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate {
    func authServiceShouldShow(_ controller: UIViewController!)
    func authServiceSignIn()
    func authServiceSignInFail()
}

final class AuthService: NSObject {
    private enum Const {
        static let id = "7096692"
        static let scope = ["offline"]
    }
    private let vkSdk: VKSdk = VKSdk.initialize(withAppId: Const.id)
    var delegate: AuthServiceDelegate?
    
    override init() {
        super.init()
        vkSdk.register(self)
        vkSdk.uiDelegate = self
    }
    
    func wakeUpSession() {
        VKSdk.wakeUpSession(Const.scope) { (state, error) in
            if error != nil { return }
            switch (state) {
            case VKAuthorizationState.authorized:
                self.delegate?.authServiceSignIn()
            case VKAuthorizationState.initialized:
                VKSdk.authorize(Const.scope)
            default:
                break
            }
        }
    }
    
}

// MARK: VKSdkDelegate

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(result)
        delegate?.authServiceSignIn()
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

