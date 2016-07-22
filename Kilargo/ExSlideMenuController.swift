//
//  ExSlideMenuController.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift

class ExSlideMenuController : SlideMenuController {

    override func isTagetViewController() -> Bool {
        if let vc = UIApplication.topViewController() {
            if vc is MainViewController ||
            vc is SettingViewController ||
            vc is AboutViewController {
                return true
            }
        }
        return false
    }
    
    override func track(trackAction: TrackAction) {
        switch trackAction {
        case .LeftTapOpen:
            print("TrackAction: left tap open.")
        case .LeftTapClose:
            print("TrackAction: left tap close.")
        case .LeftFlickOpen:
            print("TrackAction: left flick open.")
        case .LeftFlickClose:
            print("TrackAction: left flick close.")
        case .RightTapOpen:
            print("TrackAction: right tap open.")
        case .RightTapClose:
            print("TrackAction: right tap close.")
        case .RightFlickOpen:
            print("TrackAction: right flick open.")
        case .RightFlickClose:
            print("TrackAction: right flick close.")
        }   
    }
}
