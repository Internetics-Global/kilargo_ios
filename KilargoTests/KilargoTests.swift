//
//  KilargoTests.swift
//  KilargoTests
//
//  Created by internetics on 16/11/16.
//  Copyright © 2016 internetics. All rights reserved.
//

import XCTest
@testable import Kilargo


class KilargoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductJson() {
        
        let exp = expectation(description: "fetchProducts")
        
        JsonFetcher.fetchProducts("http://127.0.0.1:8080/product.json") { (result, errorMessage) in
            
            XCTAssertTrue(result)
            
            let products = JsonFetcher.getAllProducts()
            XCTAssertTrue(products.count == 2)
            
            let product:Product = products[1];
            XCTAssertNotNil(product.categoryIDList)
            XCTAssertNotNil(product.subcategoryIDList)
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        
    }
    
    
    func testSubCategoryJson() {
        
        let exp = expectation(description: "fetchSubCateogry")
        
        JsonFetcher.fetchSubCategory("http://127.0.0.1:8080/subcategory.json") { (result, errorMessage) in
            
            XCTAssertTrue(result)
            
            let subcategories = JsonFetcher.getAllSubCategories()
            XCTAssertTrue(subcategories.count == 2)
            
            let subcateogry:SubCategory = subcategories[1];
            XCTAssertNotNil(subcateogry.masterCategoryIDList)
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        
    }
    
    func testCategoryJson() {
        
        let exp = expectation(description: "fetchCateogry")
        
        JsonFetcher.fetchCategory("http://127.0.0.1:8080/category.json") { (result, errorMessage) in
            
            XCTAssertTrue(result)
            
            let categories = JsonFetcher.getAllCategories()
            XCTAssertTrue(categories.count == 2)
            
            let cateogry:Kilargo.Category = categories[1];
            XCTAssertTrue(cateogry.categoryID == 2)
            XCTAssertTrue(cateogry.categoryName == "Shaftwall Systems")
            
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 3, handler: nil)
        
        
    }
    
}
