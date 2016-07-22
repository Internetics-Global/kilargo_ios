//
//  MenuFetcher.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ObjectMapper
import AlamofireObjectMapper

struct JsonFetcher {
    
    static private var products:[Product] = []
    
    static func fetchProducts(urlStr:String,completion:(result: Bool, errorMessage:String) -> Void){
        
        if let url = NSURL(string: urlStr) {
            
            Alamofire.request(.GET, url).responseArray { (response: Response<[Product], NSError>) in
                
                switch response.result {
                    
                case .Success:
                    
                    if let resultArray = response.result.value {
                        
                        if (resultArray.count > 0) {
                            self.products = resultArray
                            completion(result: true, errorMessage: "Parse success")
                        } else {
                            self.products = []
                            completion(result: false, errorMessage: "Parse failed")
                        }
                    }
                    
                    
                case .Failure(let error):
                    self.products = []
                    print(error)
                    completion(result: false, errorMessage: error.description)
                    
                }
                
                
                
            }
            
            
        }
        
    }
    
    
    static func getCategory() -> [String] {
        
        var categories :[String] = []
        for item in self.products {
            categories.append(item.category)
        }
        
        let sets = Set(categories)  //remove duplicated
        
        
        return Array(sets)
    }
    
    static func getSubcategoryWithParenent(categoryName:String) -> [String] {
        var subcategories:[String] = []
        for item in self.products {
            if (item.category.lowercaseString == categoryName.lowercaseString) {
                subcategories.append(item.subcategory)
            }
        }
        
        let sets = Set(subcategories)  //remove duplicated
        
        return Array(sets)
    }
    
    static func getAllProducts() -> [Product] {
        return self.products
    }
    

    static func getProductsWithProductName(productName:String) -> [Product] {
        
        var products:[Product] = []
        
        guard productName.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = productName.lowercaseString
        products = self.products.filter({ (product) -> Bool in
            product.productName.lowercaseString.containsString(lowerCaseName)
        })
        
        return products
        
        
    }
    
    static func getProductsWithSubcategoryName(subcategoryName:String) -> [Product] {
        
        var products:[Product] = []
        
        guard subcategoryName.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = subcategoryName.lowercaseString
        products = self.products.filter({ (product) -> Bool in
            product.subcategory.lowercaseString == lowerCaseName
        })
        
        return products
        
        
    }
    
}



