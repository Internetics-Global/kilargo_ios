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
    var source:ProductionInfoType = .information {
        didSet {
            if (self.source == .installation) {
                self.tableView.separatorStyle = .none
            }
        }
    }
    
    var product:Product!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        //dynamic cell height
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;

        self.tableView.register(InfoDialogCell.self, forCellReuseIdentifier: InfoDialogCell.identifier)
        
        let recognizer = UITapGestureRecognizer(target: self, action:#selector(dismissCurrentView))
        recognizer.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(recognizer)
        
        //gradient background color

        
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
        return 5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        
        return view;
    }
    
}

extension ProductDesViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch source {
        case .information:
            return 6
        case .installation:
            return 5
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell( withIdentifier: InfoDialogCell.identifier, for: indexPath) as! InfoDialogCell
        
        var summaryLabelWidth = 0
        if (DeviceType.IS_IPHONE) {
            summaryLabelWidth = 110
        } else {
            summaryLabelWidth = 220
        }
        
        let summaryLabel:UILabel;
        let detailLabel:UILabel;
        if (cell.contentView.subviews.count == 0) {
            
            summaryLabel = UILabel()
            summaryLabel.textAlignment = .left
            if (DeviceType.IS_IPHONE) {
                summaryLabel.font = UIFont.systemFont(ofSize: 12)
            } else {
                summaryLabel.font = UIFont.systemFont(ofSize: 18)
            }
            summaryLabel.numberOfLines = 0
            cell.contentView.addSubview(summaryLabel)
            
            
            
            detailLabel = UILabel()
            
            detailLabel.textAlignment = .left
            detailLabel.numberOfLines = 0
            if (DeviceType.IS_IPHONE) {
                detailLabel.font = UIFont.systemFont(ofSize: 12)
            } else {
                detailLabel.font = UIFont.systemFont(ofSize: 18)
            }
            cell.contentView.addSubview(detailLabel)
        } else {
            summaryLabel = cell.contentView.subviews[0] as! UILabel
            detailLabel = cell.contentView.subviews[1] as! UILabel
        }
        
        cell.contentView.backgroundColor = UIColor.clear
        
        
        if (source == .information) {
            
            summaryLabel.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.width.equalTo(summaryLabelWidth)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
            }
            
            
            detailLabel.snp.makeConstraints { (make) in
                make.right.equalTo(10)
                make.left.equalTo(summaryLabelWidth + 20)
                make.top.equalTo(5)
                make.bottom.equalTo(-5)
            }
            
            
            
            switch indexPath.row {
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
            case 3:
                summaryLabel.text = "FRL"
                detailLabel.text = product.frl
            case 4:
                summaryLabel.text = "Test Reference No."
                detailLabel.text = product.testReferenceNumber
            case 5:
                summaryLabel.text = "System No."
                detailLabel.text = product.systemNumber
                cell.contentView.backgroundColor = UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1)
                
                
            default: break
                
            }
        } else if (source == .installation) {
            
            
            
            summaryLabel.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.width.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(0)
            }
            
            
            detailLabel.snp.makeConstraints { (make) in
                make.right.equalTo(0)
                make.left.equalTo(0)
                make.top.equalTo(0)
                make.bottom.equalTo(-5)
            }
            
            let cyanColor = UIColor(red: 69.0/255, green: 88.0/255, blue: 53.0/255, alpha: 1)
            let fontSize = detailLabel.font.pointSize
            switch indexPath.row {
            case 0:
                detailLabel.text = "Installation Introductions"
                detailLabel.textColor = cyanColor
                detailLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            case 1:
                detailLabel.text = product.installationInstructionTitle
                detailLabel.textColor = cyanColor
                detailLabel.font = UIFont.systemFont(ofSize: fontSize)
            case 2:
                detailLabel.text = product.installationInstructionBody
                detailLabel.textColor = UIColor.black
                detailLabel.font = UIFont.systemFont(ofSize: fontSize)
            case 3:
                detailLabel.text = "\nNotes"
                detailLabel.textColor = cyanColor
                detailLabel.font = UIFont.boldSystemFont(ofSize: fontSize)
            case 4:
                detailLabel.text = product.notes
                detailLabel.textColor = UIColor.black
                detailLabel.font = UIFont.systemFont(ofSize: fontSize)
            default:
                break
            }
            
            
        } else {
            
        }
        

        return cell
    }
    
    
}
