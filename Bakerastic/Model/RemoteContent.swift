//
//  RemoteContent.swift
//  Bakerastic
//
//  Created by Karol Stępień on 27.02.2017.
//  Copyright © 2017 carlst. All rights reserved.
//

import ObjectMapper
import RealmSwift

class ImageInfo: Object, Mappable {
    dynamic var id = 0 // It will be only one
    dynamic var lastUpdate: String = ""
    let images = List<Kitten>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        images <- map["images"]
    }
}
