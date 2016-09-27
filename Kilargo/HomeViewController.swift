//
//  HomeViewController.swift
//  Kilargo
//
//  Created by internetics on 27/09/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import SlideMenuControllerSwift

class HomeViewController:BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupHomeNavigationBar()
        self.setupLeftMenuNavigationBarItem()
        
        UIApplication.sharedApplication().statusBarStyle = .Default

    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}


extension HomeViewController : SlideMenuControllerDelegate {
    
    func leftWillOpen() {
        print("SlideMenuControllerDelegate: leftWillOpen")
    }
    
    func leftDidOpen() {
        print("SlideMenuControllerDelegate: leftDidOpen")
    }
    
    func leftWillClose() {
        print("SlideMenuControllerDelegate: leftWillClose")
    }
    
    func leftDidClose() {
        print("SlideMenuControllerDelegate: leftDidClose")
    }
    
    func rightWillOpen() {
        print("SlideMenuControllerDelegate: rightWillOpen")
    }
    
    func rightDidOpen() {
        print("SlideMenuControllerDelegate: rightDidOpen")
    }
    
    func rightWillClose() {
        print("SlideMenuControllerDelegate: rightWillClose")
    }
    
    func rightDidClose() {
        print("SlideMenuControllerDelegate: rightDidClose")
    }
}


