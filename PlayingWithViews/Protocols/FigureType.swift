//
//  FigureType.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

enum FigureType {
    case square
    case rectangle
    case circle
    
    var image: UIImage? {
        switch self {
        case .square:
            return UIImage(systemName: "square")            
        case .rectangle:
            return UIImage(systemName: "rectangle")
        case .circle:
            return UIImage(systemName: "circle")
        }
    }
}
