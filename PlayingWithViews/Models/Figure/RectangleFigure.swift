//
//  RectangleFigure.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

class RectangleFigure: Figure {
    
    override init() {
        super.init()
        frame = .zero
        type = .rectangle
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}
