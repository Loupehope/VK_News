//
//  DateFormatter+FeedFormat.swift
//  VK_News
//
//  Created by Vlad on 18.08.19.
//  Copyright © 2019 vlad. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var feedFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ru_RU")
        formatter.dateFormat = "d MMM 'в' HH:mm"
        return formatter
    }
}
