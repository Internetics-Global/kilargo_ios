//
//  UIViewControllerExtension.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit

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
        self.navigationController?.navigationBar.subviews.forEach({
            if ($0.tag == 314) {
                $0.removeFromSuperview()
            }
            
        })
    }
    
    func setupNotHomeNavigationBar() {
        
        removeAllSubviewsFromNavigationBar()
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 133))
        baseView.backgroundColor = UIColor.clear
        baseView.isUserInteractionEnabled = false
        baseView.tag = 314
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        let imageView = UIImageView(image: UIImage(named: "top_banner3"))
        baseView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(baseView).offset(0)
            make.left.equalTo(baseView).offset(0)
            make.bottom.equalTo(baseView).offset(0)
            make.right.equalTo(baseView).offset(0)
        }
        
    }
    
    func setupLeftViewNavigationBar() {
        
        removeAllSubviewsFromNavigationBar()
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 133))
        baseView.backgroundColor = UIColor.blue
        baseView.isUserInteractionEnabled = false
        baseView.tag = 314
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        let imageView = UIImageView(image: UIImage(named: "top_banner3"))
        baseView.addSubview(imageView)
        imageView.contentMode = .topLeft
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(baseView).offset(0)
            make.left.equalTo(baseView).offset(0)
            make.bottom.equalTo(baseView).offset(0)
            make.right.equalTo(baseView).offset(0)
        }
        
    }
    
    
    func setupHomeNavigationBar() {
        
        removeAllSubviewsFromNavigationBar()
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 133))
        baseView.backgroundColor = UIColor.white
        baseView.isUserInteractionEnabled = false
        baseView.tag = 314
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        let imageView = UIImageView(image: UIImage(named: "logo_banner"))
        baseView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(baseView)
            make.top.equalTo(35)
            make.height.equalTo(78)
            make.width.equalTo(219)
        }
        
        
        
        
    }
    
    
}
