//
//  ZoomImageViewController.swift
//  Kilargo
//
//  Created by internetics on 2/10/2016.
//  Copyright © 2016 internetics. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class ZoomImageViewController:UIViewController {
    
    var imageUrl = ""
    
    var scrollView:UIScrollView!
    var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(ZoomImageViewController.dimissViewController))
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        scrollView = UIScrollView()
        //scrollView.backgroundColor = UIColor.red
        scrollView.maximumZoomScale = 5
        scrollView.minimumZoomScale = 0.5
        scrollView.delegate = self;
        self.view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        
        imageView = UIImageView()
        scrollView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.equalTo(self.view.frame.width)
            make.height.equalTo(self.view.frame.height)
        }
        //imageView.backgroundColor = UIColor.orange
        imageView.contentMode = .scaleAspectFit
        
        imageView.kf.setImage(with:URL(string: imageUrl)!, placeholder: UIImage(named: "placeholder"), options: [.transition(ImageTransition.fade(1))], progressBlock: nil, completionHandler: nil)
        

    }
    
    func dimissViewController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return [.landscape]
    }

    
}


extension ZoomImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    
}
