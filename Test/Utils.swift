//
//  Utils.swift
//  Test
//
//  Created by Roberto Veiga Junior on 28/07/16.
//  Copyright © 2016 RJR. All rights reserved.
//

import UIKit

extension String
{
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension UIImageView {
    var setBorder: UIImageView {
        self.layer.borderWidth = 6
        self.layer.borderColor = Utils.colorDefault.CGColor
        return self
    }
    
    var setBorderSlim: UIImageView {
        self.layer.borderWidth = 1
        self.layer.borderColor = Utils.colorDefault.CGColor
        return self
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
}

class Utils {
    static let colorDefault = UIColor(red: 114/255, green: 198/255, blue: 104/255, alpha: 1.0)
}
