//
//  FigureViewFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import UIKit

protocol FigureViewFactory {
    func makeFigureView(_ figure: Figure,
                        color: UIColor,
                        frame: CGRect,
                        delegate: SelectableAndRemovableViewDelegate?) -> UIView
}

struct FigureViewFactoryImpl: FigureViewFactory {
    
    func makeFigureView(_ figure: Figure, color: UIColor, frame: CGRect = .zero, delegate: SelectableAndRemovableViewDelegate?) -> UIView {
        switch figure.type {
        case .square:
            let view = SquareView(figure: figure, frame: frame)
            view.delegate = delegate
            return view
        case .rectangle:
            let view = RectangleView(figure: figure, frame: frame)
            view.delegate = delegate
            return view
        case .circle:
            let view = CircleView(figure: figure, frame: frame)
            view.delegate = delegate
            return view
        case .arrow:
            var initialFrame = CGRect(x: 100, y: 100, width: 200, height: 200)
            if frame != .zero {
                initialFrame = frame
            }
            let view = ArrowView(figure: figure, frame: initialFrame)
            view.delegate = delegate
            return view
        case .none:
            fatalError()
        }
    }
    
}
