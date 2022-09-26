//
//  AppImage.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

enum AppImage: String {
    case tabCanvas = "macwindow.on.rectangle"
    case docTextFill = "doc.text.fill"
    case docFillBadgePlus = "doc.fill.badge.plus"
    case checkmarkCircleFill = "checkmark.circle.fill"
    case trashFill = "trash.fill"    
    
    var image: UIImage {
        UIImage(systemName: rawValue)!
    }
}
