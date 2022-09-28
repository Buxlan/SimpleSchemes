//
//  String+Localized.swift
//  DoctorRyadom
//
//  Created by Sergey Bystrov on 03.10.17.
//  Copyright © 2017 Medlinesoft. All rights reserved.
//

import UIKit

public extension String {
    func localized() -> String {
        let localizedWithFile = self.localizedWithFile()
        if (localizedWithFile == self) {
            let commonLocalization = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
            if (commonLocalization == self) {
                return localizedWithInternalFile()
            }
            return commonLocalization
        }
        return localizedWithFile
    }

    func localizedNumber(_ number: Int) -> String {
        let str = self.localized()
        return String.localizedStringWithFormat(str, number)
    }

    func localizedWithFile() -> String {
        if let fileName = Bundle.main.object(forInfoDictionaryKey: "LOCALIZATION_FILE") as? String {
            return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: "", comment: "")
        }
        return self
    }

    func localizedWithInternalFile() -> String {
        let fileName = "Localizable"
        return NSLocalizedString(self, tableName: fileName, bundle: Bundle.main, value: "", comment: "")
    }

    func dropAlamofireDescription(_ str: String) -> String {
        let alamofireInfo = "URLSessionTask failed with error:"
        if str.contains(alamofireInfo) {
            return str.toLengthOf(length: alamofireInfo.count)
        }
        return str
    }

    func toLengthOf(length:Int) -> String {
        if length <= 0 {
            return self
        } else if let from = self.index(self.startIndex, offsetBy: length, limitedBy: self.endIndex) {
            return String(self[from...])

        } else {
            return ""
        }
    }
    
    func boundingRect(withWidth width: CGFloat, font: UIFont) -> CGRect {
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = self.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin], attributes: [.font : font], context: nil)
        return rect
    }
    
}
