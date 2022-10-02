//
//  SquareFigure.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

class SquareFigure: Figure {
    
    override init() {
        super.init()
        frame = .zero
        type = .square
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }
    
}

extension SquareFigure: ConfigurableFigure {
    typealias DataType = DefaultFigureConfigurationProtocol
    
    func configure(with data: DataType) {
        backcolor = data.backgroundColor
    }
}
