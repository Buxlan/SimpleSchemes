//
//  Figure.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import CoreGraphics
import Foundation
import UIKit

class Figure: Codable, FrameProvider, Equatable {
        
    var frame: CGRect
    var type: FigureType!
    var backcolor: UIColor
    
    init() {
        frame = .zero
        backcolor = .clear
    }
    
    private enum CodingKeys: String, CodingKey {
        case type
        case frame
        case backcolor
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        frame = try container.decode(CGRect.self, forKey: .frame)
        type = try container.decode(FigureType.self, forKey: .type)
        let color = try? container.decode(Color.self, forKey: .backcolor)
        backcolor = color?.uiColor ?? .systemPink
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frame, forKey: .frame)
        try container.encode(type, forKey: .type)
        try container.encode(Color(uiColor: backcolor), forKey: .backcolor)
    }
    
    static func == (lhs: Figure, rhs: Figure) -> Bool {
        lhs === rhs
    }
}
