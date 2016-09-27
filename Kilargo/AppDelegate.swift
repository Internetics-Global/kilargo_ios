//
//  AppDelegate.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import NVActivityIndicatorView

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.setGlobalAppearance()
        
        self.prepareViewController()
        
        
        return true
    }
    
    
    
    private func prepareViewController() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let homeViewController = storyboard.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        let leftViewController = storyboard.instantiateViewControllerWithIdentifier("LeftViewController") as! LeftViewController
        
        let nvc: UINavigationController = UINavigationController(rootViewController: homeViewController)
        
        
        leftViewController.mainViewController = nvc
        
        let slideMenuController = ExSlideMenuController(mainViewController:nvc, leftMenuViewController: leftViewController)
        slideMenuController.automaticallyAdjustsScrollViewInsets = true
        slideMenuController.delegate = homeViewController
        if (Global.isPhoneDevice() == false) {
           slideMenuController.changeLeftViewWidth(380)
        } else {
           slideMenuController.changeLeftViewWidth(300)
        }
        
        self.window?.backgroundColor = UIColor(red: 236.0, green: 238.0, blue: 241.0, alpha: 1.0)
        self.window?.rootViewController = slideMenuController
        self.window?.makeKeyAndVisible()
    }
    
    func setGlobalAppearance() {
        
        /**
         *  Control the bar item text color, rather than bar color
         */
        UINavigationBar.appearance().tintColor = UIColor(hex: "689F38")
        
        NVActivityIndicatorView.DEFAULT_TYPE = .LineScalePulseOut
        NVActivityIndicatorView.DEFAULT_COLOR = UIColor.whiteColor()
        NVActivityIndicatorView.DEFAULT_PADDING = CGFloat(30.0)
    }

    
}

