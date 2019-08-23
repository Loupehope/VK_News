//
//  AuthService.swift
//  VK_News
//
//  Created by Vlad on 14.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: AnyObject {
    func authServiceShouldShow(_ controller: UIViewController)
    func authServiceSignIn()
    func authServiceSignInFail()
}

final class AuthService: NSObject {
    private enum Const {
        static let id = "7096692"
        static let scope = ["wall,offline,friends"]
    }
    private let vkSdk = VKSdk.initialize(withAppId: Const.id)
    var token: String {
        return VKSdk.accessToken().accessToken
    }
    weak var delegate: AuthServiceDelegate?
    
    override init() {
        super.init()
        vkSdk?.register(self)
        vkSdk?.uiDelegate = self
    }
    
    func wakeUpSession() {
        VKSdk.wakeUpSession(Const.scope) { [delegate] state, error in
            if error != nil {
                return
            }
            switch state {
            case .authorized:
                delegate?.authServiceSignIn()
            case .initialized:
                VKSdk.authorize(Const.scope)
            default:
                delegate?.authServiceSignInFail()
            }
        }
    }
}

// MARK: VKSdkDelegate
// swiftlint:disable implicitly_unwrapped_optional

extension AuthService: VKSdkDelegate {
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if result.token != nil {
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
