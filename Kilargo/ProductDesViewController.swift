//
//  ProductDesViewController.swift
//  Kilargo
//
//  Created by Internetics on 25/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import Kingfisher

class ProductDesViewController:BaseViewController {
    
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var appendixTextView: UITextView!
    
    @IBOutlet weak var baseView: UIView!
    
    
    
    
    var product:Product!
    
    // used to define the position of baseView
    var anchorPoint:CGPoint = CGPointZero

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        
        self.textView.text = product.notes
        self.titleTextView.text = product.productName
        self.appendixTextView.text = product.buildingElement
        
        self.textView.font = UIFont.systemFontOfSize(16)
        self.titleTextView.font = UIFont.systemFontOfSize(16)
        self.appendixTextView.font = UIFont.systemFontOfSize(16)
        
        self.baseView.backgroundColor = UIColor(red: 223.0/255, green: 223.0/255, blue: 223.0/255, alpha: 1)
        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(dismissCurrentView))
        recognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.baseView.snp_removeConstraints()
        self.baseView.snp_makeConstraints { (make) in
            make.left.equalTo(18)
            make.height.equalTo(200)
            make.centerX.equalTo(self.view)
            make.top.equalTo(anchorPoint.y).priority(999)
        }
    }
    
    
    // MARK: - Actions
    
    func dismissCurrentView() {
      self .dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
