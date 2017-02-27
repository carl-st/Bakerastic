//
//  DateFormatter+Bakerastic.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import Foundation

extension DateFormatter {
    @nonobjc static let dateTimeWithSeconds: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
    
    @nonobjc static let longTimeAndDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
}
