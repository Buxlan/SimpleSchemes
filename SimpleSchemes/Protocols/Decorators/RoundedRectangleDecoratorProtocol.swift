//
//  RoundedRectangleDecorator.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 09.09.2022.
//

import CoreGraphics

protocol RoundedRectangleDecoratorProtocol: DecoratorProtocol {
    var cornerRadius: CGFloat { get set }
    var offsetFromEdges: CGFloat { get set }
}
