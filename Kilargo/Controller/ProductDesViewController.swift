//
//  ProductDesViewController.swift
//  Kilargo
//
//  Created by Internetics on 25/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import Kingfisher

enum ProductionInfoType {
    case information
    case installation
    case unknown
}


class ProductDesViewController:BaseViewController{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var baseView: UIView!
    
    // used to diff wheter it's from infomation button or installation button
    var source:ProductionInfoType = .information
    
    var product:Product!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        //dynamic cell height
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;

        self.tableView.register(InfoDialogCell.self, forCellReuseIdentifier: InfoDialogCell.identifier)
        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(dismissCurrentView))
        recognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(recognizer)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    // MARK: - Actions
    
    func dismissCurrentView() {
      self .dismiss(animated: true, completion: nil)
    }

    
}

extension ProductDesViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        
        let separator = UIView()
        if (section == 0) {
            separator.backgroundColor = UIColor.clear
        } else {
            separator.backgroundColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 0.7)
        }
        view.addSubview(separator)
        
        separator.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.equalTo(0.5)
            make.left.equalTo(10)
            make.right.equalTo(0)
        }
        
        return view;
    }
    
}

extension ProductDesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch source {
        case .information:
            return 3
        case .installation:
            return 1
        default:
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier: InfoDialogCell.identifier, for: indexPath) as! InfoDialogCell
        cell.backgroundColor = UIColor.clear
        
        var summaryLabelWidth = 0
        
        let summaryLabel = UILabel()
        summaryLabel.textAlignment = .left
        if (DeviceType.IS_IPHONE) {
            summaryLabel.font = UIFont.systemFont(ofSize: 11)
            summaryLabelWidth = 120
        } else {
            summaryLabel.font = UIFont.systemFont(ofSize: 24)
            summaryLabelWidth = 150
        }
        summaryLabel.numberOfLines = 0
        cell.contentView.addSubview(summaryLabel)
        
        summaryLabel.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.width.equalTo(summaryLabelWidth)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        let detailLabel = UILabel()
        
        detailLabel.textAlignment = .left
        detailLabel.numberOfLines = 0
        if (DeviceType.IS_IPHONE) {
            detailLabel.font = UIFont.systemFont(ofSize: 11)
        } else {
            detailLabel.font = UIFont.systemFont(ofSize: 24)
        }
        cell.contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.right.equalTo(20)
            make.left.equalTo(summaryLabelWidth + 20)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        
        if (source == .information) {
            
            switch indexPath.section {
            case 0:
                summaryLabel.text = "Building Element"
                detailLabel.text = product.buildingElement
            case 1:
                summaryLabel.text = "Application"
                detailLabel.text = product.application
            case 2:
                summaryLabel.text = "Maximum size"
//                detailLabel.text = "automatically adjust height example,automatically adjust height example,automatically adjust height example,automatically adjust height example,automatically adjust height example,automatically adjust height example"
                detailLabel.text = product.maxSize
                
                
            default: break
                
            }
        } else if (source == .installation) {
            
            summaryLabel.text = product.installationInstructionTitle
            detailLabel.text = product.installationInstructionBody
            
            
        } else {
            
        }
        

        return cell
    }
    
    
}
