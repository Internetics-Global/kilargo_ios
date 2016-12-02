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
        
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let leftViewController = storyboard.instantiateViewController(withIdentifier: "LeftViewController") as! LeftViewController
        
        let mainNVC: UINavigationController = UINavigationController(rootViewController: mainViewController)
        
        
        leftViewController.mainViewController = mainNVC
        
        let slideMenuController = ExSlideMenuController(mainViewController:mainNVC, leftMenuViewController: leftViewController)
        //slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.changeLeftViewWidth(276)
        SlideMenuOptions.hideStatusBar = false
        SlideMenuOptions.contentViewScale = 1
        SlideMenuOptions.contentViewOpacity = 0.7
        
        self.window?.backgroundColor = UIColor.white
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func setGlobalAppearance() {
        
        /**
         *  Control the bar item text color, rather than bar color
         */
        UINavigationBar.appearance().tintColor = UIColor(red: 143.0/255, green: 143.0/255, blue: 143.0/255, alpha: 1)
        
        NVActivityIndicatorView.DEFAULT_TYPE = .lineScalePulseOut
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.white
        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(30.0)
    }
    
    
}

