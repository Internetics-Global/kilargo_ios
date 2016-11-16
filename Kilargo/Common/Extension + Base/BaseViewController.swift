//
//  BaseViewController.swift
//  Kilargo
//
//  Created by internetics on 25/09/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import SnapKit
import DropDown

class BaseViewController: UIViewController {
    
    let dropDown = DropDown()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         we always show navigation bar in whole app except "CarouselImageViewController"
         */
        self.navigationController?.isNavigationBarHidden = false
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        /**
         avoid navigation bar overlap status bar
         */
        self.extendedLayoutIncludesOpaqueBars = false
    }
    
    override var prefersStatusBarHidden : Bool {
        return false
    }
    
    
    func showSearchResultDropDown(searchBar:UISearchBar,searchText:String) {
        
        dropDown.anchorView = searchBar
        dropDown.bottomOffset = CGPoint(x: 10, y:(searchBar.frame).height)
        dropDown.direction = .bottom
        
        dropDown.width = searchBar.frame.width - 2*10
        dropDown.separatorColor = UIColor(red: 200.0/255, green: 199.0/255, blue: 204.0/255, alpha: 1)
        dropDown.cornerRadius = 5
        dropDown.backgroundColor = UIColor(red: 241.0/255, green: 242.0/255, blue: 242.0/255, alpha: 1)
        
        
        var finalList:[Dictionary<String, Any>] = [] //the reason for this is because some products could have multiple subcategories
        
        do {
            
            let productList = JsonFetcher.getProductsWithAnyKeyword(searchText)
            for product in productList {
                for subCategoryID in product.subcategoryIDList! {
                    if let subCategoryName = JsonFetcher.getSubCategoryName(subCategoryID: subCategoryID) {
                        
                        for categoryID in product.categoryIDList! {
                            
                            let isParentChildRelationship = JsonFetcher.isParentChildRelationship(parentID: categoryID, childID: subCategoryID)
                            
                            if (isParentChildRelationship) {
                                
                                if let categoryName = JsonFetcher.getCategoryName(categoryID: categoryID) {
                                    
                                    if (subCategoryName.length > 0 && categoryName.length > 0) {
                                        
                                        let dict:[String: Any] = ["product":product,"subCategoryName":subCategoryName,"categoryName":categoryName]
                                        finalList.append(dict)
                                    }
                                }
                            }
                        }
                    }
        
                    
                }
            }

        }
        
        
        var dataSource:[String] = []
        for item in finalList {
            let text = "\(item["categoryName"]!)->\(item["subCategoryName"]!)"
            dataSource.append(text)
        }
        dropDown.dataSource = dataSource
        
        dropDown.cellNib = UINib(nibName: "DropdownSearchResultCell", bundle: nil)
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            let targetProduct:Product = finalList[index]["product"] as! Product;
            
            let storyboard : UIStoryboard = UIStoryboard(
                name: "Main",
                bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProdutViewController
            viewController.products = [targetProduct]
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
            
            
        }
        
        dropDown.show()
    }
    
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.portrait, .portraitUpsideDown]
    }

}
