//
//  Product.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import ObjectMapper

open class Product:NSObject, Mappable {
    
    var productID:Int                       = 0
    var productName:String                  = ""

    var categoryIDList:[Int]?              = []
    var subcategoryIDList:[Int]?           = []

    var systemNumber:String                 = ""
    var buildingElement:String              = ""
    var application:String                  = ""
    var maxSize:String                      = ""
    var frl:String                          = ""
    var testReferenceNumber:String          = ""

    var productImage:String                 = ""
    var image1:String                       = ""
    var image2:String                       = ""
    var image3:String                       = ""
    var image4:String                       = ""
    var image5:String                       = ""

    var installationInstructionTitle:String = ""
    var installationInstructionBody:String  = ""
    var notes:String                        = ""
    
    
    
    required public init?(map: Map) {
        
    }
    
    // Mappable
    open func mapping(map: Map) {
        
        
        let transformString2IntArray = TransformOf<[Int], String>(fromJSON: { (value: String?) -> [Int]? in

            let stringArray = value?.components(separatedBy: ",")
            let intArray:[Int]? = stringArray?.map{Int($0)!}
            return intArray
            }, toJSON: { (value: [Int]?) -> String? in
                //not implemented yet
                return nil
        })
        
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
        
        
        
        productID        <-                      (map["product_id"],transform)
        productName        <-                    map["product_name"]

        categoryIDList          <-                     (map["category_name"],transformString2IntArray)
        subcategoryIDList          <-                  (map["subcategory_name"],transformString2IntArray)

        systemNumber          <-                 map["system_number"]
        buildingElement      <-                  map["building_element"]
        application        <-                    map["application"]
        maxSize          <-                      map["maximum_size"]
        frl          <-                          map["FRL"]
        testReferenceNumber      <-              map["test_reference_no"]

        productImage      <-                     map["product_image"]
        image1        <-                         map["image_1"]
        image2          <-                       map["image_2"]
        image3          <-                       map["image_3"]
        image4      <-                           map["image_4"]
        image5        <-                         map["image_5"]

        installationInstructionTitle          <- map["installation_instructions_title"]
        installationInstructionBody          <-  map["installation_instructions_body"]

        notes          <-                        map["notes"]
        
    }
    
}
