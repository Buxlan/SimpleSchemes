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
}

struct FigureFactoryImpl: FigureFactory {
    
    func makeEmptyFigure(with type: FigureType) -> Figure {
        switch type {
        case .square:
            return SquareFigure()
        case .rectangle:
            return RectangleFigure()
        case .circle:
            return CircleFigure()
        case .arrow:
            return ArrowFigure()
        }
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
    
}
