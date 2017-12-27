//
//  Article.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation
import ObjectMapper

struct Article: Mappable {
    
    var id: Int?
    var title: String?
    var description: String?
    var image: String?
    var category: Category?
    var createdDate: String?
    
    init() {
    }
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        id          <- map["ID"]
        title       <- map["TITLE"]
        description <- map["DESCRIPTION"]
        image       <- map["IMAGE"]
        category    <- map["CATEGORY"]
        createdDate <- map["CREATED_DATE"]
    }
}

