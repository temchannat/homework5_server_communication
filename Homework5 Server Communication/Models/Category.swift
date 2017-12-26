//
//  Category.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation
import ObjectMapper

class Category: Mappable {
    
    var name: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map) {
        name    <- map["NAME"]
    }
}
