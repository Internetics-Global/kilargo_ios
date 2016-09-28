//
//  BaseViewController.swift
//  Kilargo
//
//  Created by internetics on 25/09/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import SnapKit

class BaseViewController: UIViewController {

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

}
