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
        dropDown.bottomOffset = CGPoint(x: 0, y:(searchBar.frame).height)
        
        dropDown.direction = .bottom
        
        let searchResult = JsonFetcher.getProductsWithAnyKeyword(searchText)
        
        var dataSource:[String] = []
        for item in searchResult {
            let text = "\(item.category)->\(item.subcategory)"
            dataSource.append(text)
        }
        dropDown.dataSource = dataSource
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            
            let storyboard : UIStoryboard = UIStoryboard(
                name: "Main",
                bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ProductViewController") as! ProdutViewController
            viewController.products = [searchResult[index]]
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
            
            
        }
        
        dropDown.show()
    }

}
