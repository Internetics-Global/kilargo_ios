//
//  StringExtension.swift
//  Kilargo
//
//  Created by Internetics on 22/04/2016.
//  Copyright © 2016 com.internetics. All rights reserved.
//

import Foundation

extension String {
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    func substring(_ from: Int) -> String {
        return self.substring(from: self.characters.index(self.startIndex, offsetBy: from))
    }
    
    var length: Int {
        return self.characters.count
    }
    
    /// Returns a percent-escaped string following RFC 3986 for a query string key or value.
    /// From: https://github.com/Alamofire/Alamofire/blob/ab07523ee93527e79e99037f1a2d596b30689016/Source/ParameterEncoding.swift
    /// - returns: The percent-escaped string.
    public func escape() -> String {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        
        var escaped = ""
        
        escaped = self.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? self
        
        return escaped
    }
}
