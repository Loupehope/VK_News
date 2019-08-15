//
//  FeedViewController.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import UIKit
import Reusable

final class FeedViewController: UIViewController {
    private enum Const {
        static let storyboardName = "FeedViewController"
    }
}

// MARK: StoryboardSceneBased

extension FeedViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard {
        return UIStoryboard(name: Const.storyboardName, bundle: nil)
    }
}
