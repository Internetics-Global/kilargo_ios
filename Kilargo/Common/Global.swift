//
//  Global.swift
//  Kilargo
//
//  Created by Internetics on 26/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation
import UIKit

struct Global {
    static let imageBaseURL = "http://www.internetics.net.au/kgo/app/plus/app_files/"
    static let feedURL      = "http://www.internetics.net.au/kgo/app/manage/get_products_data?X-API-KEY=A109764532X"
    
    
    static func isPhoneDevice() -> Bool {
        return (UIDevice.current.userInterfaceIdiom == .phone)
        
    }
}


