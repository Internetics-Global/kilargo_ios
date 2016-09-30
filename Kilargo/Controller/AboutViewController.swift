//
//  AboutViewController.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupNotHomeNavigationBar()
        self.setupLeftMenuNavigationBarItem()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        var width:CGFloat = 0.0
        var height:CGFloat = 0.0
        if (DeviceType.IS_IPHONE_6P_7P) {
            width = 380
            height = 950
        } else {
            width = 300
            height = 800
        }
        
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: height)
        
        let imageView = UIImageView(image: UIImage(named: "about_content"))
        self.scrollView.addSubview(imageView)
        
        
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(width)
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(height)
        }
        
        
    }
    

    
}
