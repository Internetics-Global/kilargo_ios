//
//  Menu.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import ObjectMapper

@available(*, deprecated, message="no use any more")
public class Menu:NSObject,Mappable{
    
    var menuID             :Int = 0
    var name               :String = "menu"
    var subMenus:[SubMenu] = []
    
    
    required public init?(_ map: Map) {
        
    }
    
    // Mappable
    public func mapping(map: Map) {
        menuID        <- map["category_id"]
        name          <- map["name_of_category"]
        subMenus      <- map["subcategories"]
        
    }
    
    
}
