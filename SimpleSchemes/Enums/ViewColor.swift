//
//  ViewColor.swift
//  SimpleSchemes
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.09.2022.
//

import UIKit

enum ViewColor: CaseIterable {
    
    case blue
    case green
    case black
    case yellow
    case orange
    case red
    case pink
    case purple
    case cyan
    case teal
    
    var color: UIColor {
        switch self {
        case .blue: return .systemBlue
        case .green: return .systemGreen
        case .black: return .black
        case .yellow: return .systemYellow
        case .orange: return .systemOrange
        case .red: return .systemRed
        case .pink: return .systemPink
        case .purple: return .systemPurple
        case .cyan: return .systemCyan
        case .teal: return .systemTeal
        }        
    }
    
}
