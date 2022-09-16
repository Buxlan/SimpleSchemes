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
    
}
