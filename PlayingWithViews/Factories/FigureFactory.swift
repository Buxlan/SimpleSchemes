//
//  FigureFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

struct FigureFactory {
    
    func makeFigureView(with type: FigureType) -> UIView {
        switch type {
        case .square:
            return SquareView()
        case .rectangle:
            return RectangleView()
        case .circle:
            return CircleView()
        }
    }
    
}
