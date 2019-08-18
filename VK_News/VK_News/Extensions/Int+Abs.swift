//
//  Int+Abs.swift
//  VK_News
//
//  Created by Vlad on 18.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

extension Int {
    func abs() -> Int {
        return self > 0 ? self : -self
    }
}
