//
//  ImageInfo.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import ObjectMapper
import RealmSwift

class Info: Object, Mappable {
    dynamic var id = NSUUID().uuidString
    dynamic var descriptionText: String = ""
    dynamic var timestamp = NSDate()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["_id"]
        descriptionText <- map["description"]
        
        var stringDate = ""
        stringDate <- map["timestamp"]
        timestamp = NSDate(string: stringDate, formatter: .dateTimeWithSeconds)!
    }
}
