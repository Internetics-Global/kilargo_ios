//
//  SubMenu.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import ObjectMapper

@available(*, deprecated, message="no use any more")
public class SubMenu:NSObject,Mappable {
    
    var menuID:Int           = 0
    var name  :String        = "submenu"
    var parent:String        = ""
    var products:[Product]   = []
    
    required public init?(_ map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        menuID        <- map["subcategory_id"]
        name          <- map["name_of_subcategory"]
        parent          <- map["parent_category"]
        products      <- map["products"]
    }
    
}