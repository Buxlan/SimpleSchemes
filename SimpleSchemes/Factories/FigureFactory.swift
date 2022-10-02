//
//  FigureFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

protocol FigureFactory {
    func makeEmptyFigure(with type: FigureType) -> Figure
    func makeFigure(with type: FigureType, from decoder: Decoder) throws -> Figure
    func makeConfiguredFigure(with type: FigureType, config: FigureConfigurator) -> Figure
}

struct FigureFactoryImpl: FigureFactory {
    func makeEmptyFigure(with type: FigureType) -> Figure {
        var figure: Figure,
            config: FigureConfigurator
        switch type {
        case .square:
            figure = SquareFigure()
            config = SquareConfigurator(data: DefaultSquareFigureConfiguration())
        case .rectangle:
            figure = RectangleFigure()
            config = RectangleConfigurator(data: DefaultRectangleFigureConfiguration())
        case .circle:
            figure = CircleFigure()
            config = CircleConfigurator(data: DefaultCircleFigureConfiguration())
        case .arrow:
            figure = ArrowFigure()
            config = ArrowConfigurator(data: DefaultArrowFigureConfiguration())
        }
        config.configure(figure: figure)
        
        return figure
    }
    
    func makeFigure(with type: FigureType, from decoder: Decoder) throws -> Figure {
        switch type {
        case .square:
            return try SquareFigure(from: decoder)
        case .rectangle:
            return try RectangleFigure(from: decoder)
        case .circle:
            return try CircleFigure(from: decoder)
        case .arrow:
            return try ArrowFigure(from: decoder)
        }
    }
    
    func makeConfiguredFigure(with type: FigureType, config: FigureConfigurator) -> Figure {
        let figure = makeEmptyFigure(with: type)
        
        config.configure(figure: figure)
        
        return figure
    }
    
}
