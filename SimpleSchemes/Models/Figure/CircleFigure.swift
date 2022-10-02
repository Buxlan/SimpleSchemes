//
//  CircleFigure.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

class CircleFigure: Figure {
    
    override init() {
        super.init()
        frame = .zero
        type = .circle
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}

extension CircleFigure: ConfigurableFigure {
    typealias DataType = DefaultFigureConfigurationProtocol
    
    func configure(with data: DataType) {
        backcolor = data.backgroundColor
    }
}
