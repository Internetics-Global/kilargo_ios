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
    case setting
    case about
}

protocol LeftMenuProtocol : class {
    func changeViewController(_ menu: LeftMenu)
}

class LeftViewController : BaseViewController, LeftMenuProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var menus = ["Products", "Settings", "About"]
    var mainViewController: UIViewController!
    var settingViewController: UIViewController!
    var aboutViewController: UIViewController!
    var nonMenuViewController: UIViewController!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.separatorColor = UIColor(red: 233/255, green: 233/255, blue: 233/255, alpha: 0.7)
        self.tableView.separatorStyle = .singleLine
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "left_view_bottom_background"))
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingViewController = storyboard.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        self.settingViewController = UINavigationController(rootViewController: settingViewController)
        
        let aboutViewController = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
        self.aboutViewController = UINavigationController(rootViewController: aboutViewController)
        
        
        self.tableView.registerCellClass(LeftTableViewCell.self)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    func changeViewController(_ menu: LeftMenu) {
        switch menu {
        case .main:
            self.slideMenuController()?.changeMainViewController(self.mainViewController, close: true)
        case .setting:
            self.slideMenuController()?.changeMainViewController(self.settingViewController, close: true)
        case .about:
            self.slideMenuController()?.changeMainViewController(self.aboutViewController, close: true)
        }
    }
    
}

extension LeftViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let menu = LeftMenu(rawValue: (indexPath as NSIndexPath).item) {
            switch menu {
            case .main, .setting,.about:
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
}

extension LeftViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let menu = LeftMenu(rawValue: (indexPath as NSIndexPath).item) {
            switch menu {
            case .main, .setting,.about:
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


