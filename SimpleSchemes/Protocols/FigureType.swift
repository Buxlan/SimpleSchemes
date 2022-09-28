//
//  FigureType.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

enum FigureType: String, Codable {
    case square
    case rectangle
    case circle
    case arrow
    
    var image: UIImage? {
        switch self {
        case .square:
            return UIImage(systemName: "square")            
        case .rectangle:
            return UIImage(systemName: "rectangle")
        case .circle:
            return UIImage(systemName: "circle")
        case .arrow:
            return UIImage(systemName: "arrow.up.forward")
        }
    }
}
