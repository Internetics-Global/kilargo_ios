//
//  DisclaimerViewController.swift
//  Kilargo
//
//  Created by internetics on 2016/12/13.
//  Copyright © 2016年 internetics. All rights reserved.
//

import UIKit

class DisclaimerViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Disclaimer"
        
        self.setupNotHomeNavigationBar()
        self.setupLeftMenuNavigationBarItem()
        
        self.automaticallyAdjustsScrollViewInsets = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
