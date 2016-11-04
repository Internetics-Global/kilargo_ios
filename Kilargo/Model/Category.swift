//
//  Menu.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import ObjectMapper

open class Category:NSObject,Mappable{
    
    var categoryID             :Int = 0
    var categoryName           :String = ""
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    open func mapping(map: Map) {
        
        let transform = TransformOf<Int, String>(fromJSON: { (value: String?) -> Int? in
            // transform value from String? to Int?
            return Int(value!)
            }, toJSON: { (value: Int?) -> String? in
                // transform value from Int? to String?
                if let value = value {
                    return String(value)
                }
                return nil
        })
        
        categoryID        <- (map["category_id"],transform)
        categoryName          <- map["category_name"]
        
    }
    
    
}
