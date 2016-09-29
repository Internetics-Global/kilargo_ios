//
//  AppDelegate.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import DropDown

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        DropDown.startListeningToKeyboard()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.setGlobalAppearance()
        
        self.prepareViewController()
        
        
        return true
    }
    
    
    
    fileprivate func prepareViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: homeViewController)
        let leftnvc: UINavigationController = UINavigationController(rootViewController: leftViewController)
        
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftnvc)
        //slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = homeViewController
        if (Global.isPhoneDevice() == false) {
            slideMenuController.changeLeftViewWidth(380)
        } else {
            slideMenuController.changeLeftViewWidth(300)
        }
        SlideMenuOptions.hideStatusBar = false
        SlideMenuOptions.contentViewScale = 1
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func setGlobalAppearance() {
        
        /**
         *  Control the bar item text color, rather than bar color
         */
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScalePulseOut
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(30.0)
    }
    
    
}

