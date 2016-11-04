//
//  SubMenu.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import ObjectMapper

open class SubCategory:NSObject,Mappable {
    
    var subcategoryID:Int               = 0
    var subcategoryName  :String        = ""
    var masterCategoryID:Int            = 0
    
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
        
        subcategoryID        <- (map["subcategory_id"],transform)
        subcategoryName          <- map["subcategory_name"]
        masterCategoryID          <- (map["master_category"],transform)
    }
    
}
