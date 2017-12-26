//
//  Author.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/25/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import Foundation
import ObjectMapper

class Author: Mappable {
    
    var name: String?
    var email: String?
    var gender: String?
    var telephone: String?
    var status: String?
    var facebook_id: String?
    var image_url: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        name    <- map["NAME"]
        email   <- map["EMAIL"]
        gender  <- map["GENDER"]
        telephone   <- map["TELEPHONE"]
        status  <- map["STATUS"]
        facebook_id <- map["FACEBOOK_ID"]
        image_url   <- map["IMAGE_URL"]
    }
    
}
