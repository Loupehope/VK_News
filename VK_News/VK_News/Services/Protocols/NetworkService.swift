//
//  NetworkService.swift
//  VK_News
//
//  Created by Vlad on 15.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

protocol NetworkService {
    func request(path: String, params: [String: String], _ completionHandler: @escaping (Data?, Error?) -> Void)
}
