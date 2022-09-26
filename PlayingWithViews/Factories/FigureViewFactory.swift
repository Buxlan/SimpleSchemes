//
//  FigureViewFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import UIKit

protocol FigureViewFactory {
    func makeFigureView(_ figure: Figure, delegate: SelectableAndRemovableViewDelegate?) -> UIView
}

struct FigureViewFactoryImpl: FigureViewFactory {
    
    func makeFigureView(_ figure: Figure, delegate: SelectableAndRemovableViewDelegate?) -> UIView {
        switch figure.type {
        case .square:
            let view = SquareView(figure: figure)
            view.delegate = delegate
            return view
        case .rectangle:
            let view = RectangleView(figure: figure)
            view.delegate = delegate
            return view
        case .circle:
            let view = CircleView(figure: figure)
            view.delegate = delegate
            return view
        case .arrow:
            let frame = CGRect(x: 100, y: 100, width: 200, height: 200)
            let view = ArrowView(figure: figure, frame: frame)
            view.delegate = delegate
            return view
        case .none:
            fatalError()
        }
    }
    
}
