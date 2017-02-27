//
//  NSDate+Bakerastic.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import Foundation

extension NSDate {
    // string representation for the date with the given formatter
    func string(with format: DateFormatter) -> String {
        return format.string(from: self as Date)
    }
    
    // NSDate from the given string and formatter.
    convenience init?(string: String, formatter: DateFormatter) {
        guard let date = formatter.date(from: string) else { return nil }
        self.init(timeIntervalSince1970: date.timeIntervalSince1970)
    }
}
