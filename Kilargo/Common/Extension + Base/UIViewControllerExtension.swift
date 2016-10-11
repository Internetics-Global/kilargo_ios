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
        self.addLeftBarButtonWithImage(UIImage(named: "left_menu")!)
        
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
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 113))
        baseView.backgroundColor = UIColor.white
        baseView.isUserInteractionEnabled = false
        baseView.tag = 314
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        let logoImageView = UIImageView(image: UIImage(named: "logo_banner"))
        logoImageView.contentMode = .scaleToFill
        baseView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(45)
            make.height.equalTo(48)
            make.width.equalTo(139)
        }
        
    }
    
    
    
    func setupHomeNavigationBar() {
        
        removeAllSubviewsFromNavigationBar()
        
        let baseView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 113))
        baseView.backgroundColor = UIColor.white
        baseView.isUserInteractionEnabled = false
        baseView.tag = 314
        
        self.navigationController?.navigationBar.addSubview(baseView)
        
        
        
        let logoImageView = UIImageView(image: UIImage(named: "logo_banner"))
        logoImageView.contentMode = .scaleToFill
        baseView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalToSuperview()
            make.top.equalTo(45)
            make.height.equalTo(48)
            make.width.equalTo(139)
        }
        
        
        
    }
    
    
}
