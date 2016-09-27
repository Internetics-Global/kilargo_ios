//
//  UIViewControllerExtension.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import DropDown

extension UIViewController: NVActivityIndicatorViewable {
    
    func openLeftMenuList() {
        self.slideMenuController()?.openLeft()
    }
    
    
    func setupLeftMenuNavigationBarItem() {
        self.addLeftBarButtonWithImage(UIImage(named: "ic_menu_black_24dp")!)
        
        self.slideMenuController()?.removeLeftGestures()
        self.slideMenuController()?.addLeftGestures()
        
    }

    
    func removeLeftMenuNavigationBarItem() {
        self.navigationItem.leftBarButtonItem = nil
        self.slideMenuController()?.removeLeftGestures()
    }
    
    func removeAllSubviewsFromNavigationBar() {
        self.navigationController?.navigationBar.subviews.forEach({$0.removeFromSuperview()})
    }
    
    func setupNotHomeNavigationBar() {
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.frame), height: 133))
        baseView.backgroundColor = UIColor.clearColor()
        baseView.userInteractionEnabled = false
        
        let imageView = UIImageView(image: UIImage(named: "top_banner3"))
        baseView.addSubview(imageView)
        imageView.contentMode = .ScaleAspectFill
        imageView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(baseView).offset(0)
            make.left.equalTo(baseView).offset(0)
            make.bottom.equalTo(baseView).offset(0)
            make.right.equalTo(baseView).offset(0)
        }
        
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
    }
    
    
    func setupHomeNavigationBar() {
        
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: CGRectGetWidth(self.view.frame), height: 133))
        baseView.backgroundColor = UIColor.whiteColor()
        baseView.userInteractionEnabled = false
        
        let imageView = UIImageView(image: UIImage(named: "logo_banner"))
        baseView.addSubview(imageView)
        imageView.contentMode = .ScaleAspectFill
        imageView.snp_makeConstraints { (make) -> Void in
            make.centerX.equalTo(baseView)
            make.top.equalTo(55)
            make.height.equalTo(78)
            make.width.equalTo(219)
        }
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        
    }
    
    func showSearchResultDropDown(searchBar searchBar:UISearchBar,searchText:String) {
        
        let dropDown = DropDown()
        dropDown.anchorView = searchBar
        dropDown.bottomOffset = CGPoint(x: 0, y:CGRectGetHeight(searchBar.frame))
        dropDown.dataSource = ["Car", "Motorcycle", "Truck"]
        
        dropDown.direction = .Bottom
        
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
            let viewController = storyboard.instantiateViewControllerWithIdentifier("ProductViewController") as! ProdutViewController
            viewController.products = [searchResult[index]]
            self.navigationController?.pushViewController(viewController, animated: true)
            
            
            
            
        }
        
        dropDown.show()
    }
    
    
}