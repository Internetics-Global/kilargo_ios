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
    static let productFeedURL      = "http://www.internetics.net.au/kgo/app/manage/get_products_data?X-API-KEY=A109764532X"
    static let categoryFeedURL      = "http://www.internetics.net.au/kgo/app/manage/get_categories_data?X-API-KEY=A109764532X"
    static let subCategoryFeedURL      = "http://www.internetics.net.au/kgo/app/manage/get_subcategories_data?X-API-KEY=A109764532X"
    
    static var lastSearchKeyword = ""
}

struct ScreenSize
{
    static let SCREEN_WIDTH = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}

struct DeviceType
{
    static let IS_IPHONE = (UIDevice.current.userInterfaceIdiom == .phone)
    static let IS_IPHONE_4_OR_LESS =  UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6_7 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6P_7P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
}


