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
    static fileprivate var categories:[Category] = []
    static fileprivate var subCategories:[SubCategory] = []

    
    static func fetchAllFeed(completion:@escaping (_ result: Bool, _ errorMessage:String) -> Void) {
        
        var isFinallSuccess = true   //mean success
        var finalErrorMessage = ""
        
        let serviceGroup = DispatchGroup()
        
        serviceGroup.enter();
        JsonFetcher.fetchProducts(Global.productFeedURL) { (result, errorMessage) in
            
            if (result == false) {
                isFinallSuccess = false
                finalErrorMessage = errorMessage
            }
            
            serviceGroup.leave()
        }
        
        serviceGroup.enter();
        JsonFetcher.fetchCategory(Global.categoryFeedURL) { (result, errorMessage) in
            
            if (result == false ) {
                isFinallSuccess = false
                finalErrorMessage = errorMessage
            }
            
            serviceGroup.leave()
        }
        
        serviceGroup.enter();
        JsonFetcher.fetchSubCategory(Global.subCategoryFeedURL) { (result, errorMessage) in
            
            if (result == false) {
                isFinallSuccess = false
                finalErrorMessage = errorMessage
            }
            
            serviceGroup.leave()
        }
        
        serviceGroup.notify(queue: DispatchQueue.main) {
            
            completion(isFinallSuccess,finalErrorMessage)
            
        }
        
        
    }
    
    static func fetchCategory(_ urlStr:String,completion:@escaping (_ result: Bool, _ errorMessage:String) -> Void) {
        
        if let url = URL(string: urlStr) {
            
            Alamofire.request(url).responseArray { (response: DataResponse<[Category]>) in
                
                switch response.result {
                    
                case .success(_):
                    
                    if let resultArray = response.result.value {
                        
                        if (resultArray.count > 0) {
                            self.categories = resultArray
                            completion(true,"Parse success")
                        } else {
                            self.categories = []
                            completion(false, "Parse failed")
                        }
                    }
                    
                    
                case .failure(let error):
                    self.categories = []
                    print("fetchCategory eror " + error.localizedDescription)
                    completion(false, error.localizedDescription)
                    
                }
                
                
            }
            
            
        }
        
    }
    
    static func fetchSubCategory(_ urlStr:String,completion:@escaping (_ result: Bool, _ errorMessage:String) -> Void) {
        
        if let url = URL(string: urlStr) {
            
            Alamofire.request(url).responseArray { (response: DataResponse<[SubCategory]>) in
                
                switch response.result {
                    
                case .success(_):
                    
                    if let resultArray = response.result.value {
                        
                        if (resultArray.count > 0) {
                            self.subCategories = resultArray
                            completion(true,"Parse success")
                        } else {
                            self.subCategories = []
                            completion(false, "Parse failed")
                        }
                    }
                    
                    
                case .failure(let error):
                    self.subCategories = []
                    print("fetchSubCategory error:" + error.localizedDescription)
                    completion(false, error.localizedDescription)
                    
                }
                
                
            }
            
            
        }
        
    }
    
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
                    print("fetchProducts error:" + error.localizedDescription)
                    completion(false, error.localizedDescription)
                    
                }
            
                
            }
            
            
        }
        
    }
    
    
    static func getAllCategories() -> [Category] {
    
        return categories
    }
    
    static func getAllSubCategories() -> [SubCategory] {
        
        return subCategories
    }
    
    
    static func getAllProducts() -> [Product] {
        return self.products
    }
    
    
    static func getSubcategory(_ categoryID:Int) -> [SubCategory] {
        var filtedSubCategories:[SubCategory] = []
        for item in self.subCategories {
            
            if let IDs = item.masterCategoryIDList {
                for masterCategoryID in IDs {
                    if (masterCategoryID == categoryID) {
                        filtedSubCategories.append(item)
                    }
                }
            }
            
            
        }
        
        return filtedSubCategories;
    }
    
    static func getProducts(categoryId: Int,subCategoryId:Int) -> [Product] {
        
        var filteredProducts:[Product] = []
        for item in self.products {
            if ((item.categoryIDList?.contains(categoryId))! && (item.subcategoryIDList?.contains(subCategoryId))!) {
                filteredProducts.append(item)
            }
        }
        
        return filteredProducts
    }
    
    /**
     support to search by product name, system number
     */
    static func getProductsWithAnyKeyword(_ name:String) -> [Product] {
        
        var filtedProducts:[Product] = []
        
        guard name.characters.count>0 else {
            return []
        }
        
        let lowerCaseName = name.lowercased()
        filtedProducts = self.products.filter({ (product) -> Bool in
            (product.productName.lowercased().contains(lowerCaseName)) ||
            (product.systemNumber.lowercased().contains(lowerCaseName))
//            (product.category.lowercased().contains(lowerCaseName)) ||
//            (product.subcategory.lowercased().contains(lowerCaseName))
        })
        
        return filtedProducts
        
        
    }
    
    static func getCategoryName(categoryID: Int) -> String? {
        
        for item in self.categories {
            if (item.categoryID == categoryID) {
                return item.categoryName
            }
        }
        
        return nil;
        
    }
    
    static func isParentChildRelationship(parentID:Int, childID:Int) -> Bool {
        
        for item in self.subCategories {
            if (item.subcategoryID == childID) {
                if let IDs = item.masterCategoryIDList {
                    for masterCategoryID in IDs {
                        if (masterCategoryID == parentID) {
                            return true;
                        }
                    }
                }
                
            }
        }
        
        return false
    }

    
    static func getSubCategoryName(subCategoryID: Int) -> String? {
        
        for item in self.subCategories {
            if (item.subcategoryID == subCategoryID) {
                return item.subcategoryName
            }
        }
        
        return nil;
        
    }
    
    
}



