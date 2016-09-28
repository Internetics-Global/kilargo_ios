//
//  AboutViewController.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.setupNotHomeNavigationBar()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        //we have to put following method in here viewDidLayoutSubviews since the custom navigation bar view will overlap bar item because auto layout characters
        self.setupLeftMenuNavigationBarItem()
    }
}
