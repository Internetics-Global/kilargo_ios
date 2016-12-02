//
//  LeftViewController.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit

enum LeftMenu: Int {
    case main = 0
    case about
    case about_app
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : BaseViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Product systems", "Coming soon","About the app"]
    var mainViewController: UIViewController!
    var settingViewController: UIViewController!
    var aboutViewController: UIViewController!
    var aboutAppViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        self.edgesForExtendedLayout = []
        
        self.tableView.separatorColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 0.7)
        self.tableView.separatorStyle = .singleLine
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.settingViewController = UINavigationController(rootViewController: settingViewController)
        
        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)
        
        let aboutAppViewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.aboutAppViewController = UINavigationController(rootViewController: aboutAppViewController)
        
        self.tableView.registerCellClass(LeftTableViewCell.self)
        
        //For an unknow reason, we can not make constraints on storyboard, otherwise,top position will be wrong.
        do {
            
            self.tableView.snp.remakeConstraints { (make) -> Void in
                make.top.equalTo(135 + 20)
                make.left.equalTo(0)
                make.bottom.equalTo(0)
                make.right.equalTo(0)
            }
            
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            
            let topImageView = UIImageView(image: UIImage(named: "left_view_top.png"))
            topImageView.contentMode = .scaleToFill
            self.view.addSubview(topImageView)
            topImageView.snp.makeConstraints { (make) -> Void in
                make.top.equalTo(20)
                make.left.equalTo(0)
                make.height.equalTo(115 + 20)
                make.right.equalTo(0)
            }
            
            let width:Int
            let height:Int
            if (DeviceType.IS_IPHONE_6P_7P) {
                width = 180
                height = 62
            } else if (DeviceType.IS_IPHONE_6_7) {
                width = 168
                height = 58
            } else {
                width = 139
                height = 48
            }
            
            let logoImageView = UIImageView(image: UIImage(named: "logo_banner"))
            logoImageView.contentMode = .scaleToFill
            self.view.addSubview(logoImageView)
            logoImageView.snp.makeConstraints { (make) -> Void in
                make.centerX.equalToSuperview()
                make.top.equalTo(45 + 20)
                make.height.equalTo(height)
                make.width.equalTo(width)
            }
            
        }
        
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .about:
            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
        case .about_app:
            self.slideMenuController()?.changeMainViewController(self.aboutAppViewController, close: true)
        }
        
    }
    
    
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: (indexPath as NSIndexPath).item) {
            switch menu {
            case .main,.about,.about_app:
                return LeftTableViewCell.height()
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let menu = LeftMenu(rawValue: (indexPath as NSIndexPath).item) {
            self.changeViewController(menu)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: (indexPath as NSIndexPath).item) {
            switch menu {
            case .main,.about,.about_app:
                let cell = LeftTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: LeftTableViewCell.identifier)
                cell.setData(menus[(indexPath as NSIndexPath).row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    
}

extension LeftViewController: UIScrollViewDelegate {
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.tableView == scrollView {
            
        }
    }
}


