//
//  SquareDecoratorProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 15.09.2022.
//

import CoreGraphics

protocol SquareDecoratorProtocol: DecoratorProtocol {
    var cornerRadius: CGFloat { get set }
    var offsetFromEdges: CGFloat { get set }
}

