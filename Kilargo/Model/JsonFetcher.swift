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
    
    static fileprivate var products:[Product] = []
    
    static func fetchProducts(_ urlStr:String,completion:@escaping (_ result: Bool, _ errorMessage:String) -> Void){
        
        if let url = URL(string: urlStr) {
            
            Alamofire.request(url).responseArray { (response: DataResponse<[Product]>) in
                
                switch response.result {
                    
                case .success(_):
                    
                    if let resultArray = response.result.value {
                        
                        if (resultArray.count > 0) {
                            self.products = resultArray
                            completion(true,"Parse success")
                        } else {
                            self.products = []
                            completion(false, "Parse failed")
                        }
                    }
                    
                    
                case .failure(let error):
                    self.products = []
                    print(error)
                    completion(false, error.localizedDescription)
                    
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
    
    static func getSubcategoryWithParenent(_ categoryName:String) -> [String] {
        var subcategories:[String] = []
        for item in self.products {
            if (item.category.lowercased() == categoryName.lowercased()) {
                subcategories.append(item.subcategory)
            }
        }
        
        let sets = Set(subcategories)  //remove duplicated
        
        return Array(sets)
    }
    
    static func getAllProducts() -> [Product] {
        return self.products
    }
    
    /**
     support to search by product name, category, subcategory name
     */
    static func getProductsWithAnyKeyword(_ name:String) -> [Product] {
        
        var products:[Product] = []
        
        guard name.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = name.lowercased()
        products = self.products.filter({ (product) -> Bool in
            (product.productName.lowercased().contains(lowerCaseName)) ||
            (product.category.lowercased().contains(lowerCaseName)) ||
            (product.subcategory.lowercased().contains(lowerCaseName))
        })
        
        return products
        
        
    }
    

    static func getProductsWithProductName(_ productName:String) -> [Product] {
        
        var products:[Product] = []
        
        guard productName.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = productName.lowercased()
        products = self.products.filter({ (product) -> Bool in
            product.productName.lowercased().contains(lowerCaseName)
        })
        
        return products
        
        
    }
    
    static func getProductsWithSubcategoryName(_ subcategoryName:String) -> [Product] {
        
        var products:[Product] = []
        
        guard subcategoryName.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = subcategoryName.lowercased()
        products = self.products.filter({ (product) -> Bool in
            product.subcategory.lowercased() == lowerCaseName
        })
        
        return products
        
        
    }
    
}



