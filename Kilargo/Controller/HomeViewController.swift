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

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

