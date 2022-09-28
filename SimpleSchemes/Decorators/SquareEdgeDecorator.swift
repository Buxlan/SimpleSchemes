//
//  SquareEdgeDecorator.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import CoreGraphics
import UIKit

struct SquareEdgeDecorator: EdgeViewDecoratorProtocol {
    
    var size: CGSize = .init(width: 25.0, height: 25.0)
    var borderWidth: CGFloat = 1
    var borderColor: UIColor = .systemGray
    var bgColor: UIColor = .systemYellow
    
    func decorate(view: UIView) {
        view.bounds = .init(origin: view.bounds.origin, size: size)
        view.layer.borderWidth = 1
        view.layer.borderColor = borderColor.cgColor
        view.backgroundColor = bgColor
    }
    
}
