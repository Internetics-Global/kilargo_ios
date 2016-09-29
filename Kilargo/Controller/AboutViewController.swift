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
        
        self.scrollView.backgroundColor = UIColor.white
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 800)
        
        let imageView = UIImageView(image: UIImage(named: "about_content"))
//        imageView.backgroundColor = UIColor.green
        self.scrollView.addSubview(imageView)
        
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { (make) in
            make.width.equalTo(300)
            make.centerX.equalToSuperview()
            make.top.equalTo(0)
            make.height.equalTo(800)
        }
        
        
    }
    

    
}
