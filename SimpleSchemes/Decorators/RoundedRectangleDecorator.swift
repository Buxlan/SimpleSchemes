//
//  RoundedRectangleDecorator.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 09.09.2022.
//

import UIKit

struct RoundedRectangleDecorator: RoundedRectangleDecoratorProtocol {
    var cornerRadius: CGFloat = 10.0
    var offsetFromEdges: CGFloat = 10.0
    
    func decorate(view: UIView) {
    }
}
