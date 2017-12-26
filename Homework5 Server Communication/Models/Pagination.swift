//
//  Pagination.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation
import ObjectMapper

class Pagination: Mappable {
    
    var page: Int?
    var limit: Int?
    var total_page: Int?
    var total_count: Int?
    
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        page        <- map["PAGE"]
        limit       <- map["LIMIT"]
        total_page  <- map["TOTAL_PAGE"]
        total_count <- map["TOTAL_COUNT"]
    }
    
}
