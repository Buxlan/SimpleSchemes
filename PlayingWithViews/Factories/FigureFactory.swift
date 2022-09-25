//
//  FigureFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

struct FigureFactory {
    
    func makeFigureView(with type: FigureType, delegate: SelectableViewDelegate?) -> UIView {
        switch type {
        case .square:
            let view = SquareView()
            view.delegate = delegate
            return view
        case .rectangle:
            let view = RectangleView()
            view.delegate = delegate
            return view
        case .circle:
            let view = CircleView()
            view.delegate = delegate
            return view
        case .arrow:
            let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
            let view = ArrowView(frame: frame)
//            view.delegate = delegate
            return view
        }
    }
    
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
