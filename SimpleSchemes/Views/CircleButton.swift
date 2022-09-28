//
//  CircleButton.swift
//  SimpleSchemes
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.09.2022.
//

import UIKit

class CircleButton: UIButton {
    
    var bgColor: UIColor = .clear
    var insets: UIEdgeInsets = .init(top: 2, left: 2, bottom: 2, right: 2)
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let circleRect = rect.inset(by: insets)
        
        let context = UIGraphicsGetCurrentContext()
        bgColor.setFill()
        context?.fillEllipse(in: circleRect)
        
        UIGraphicsEndImageContext()
    }
    
    func setBGColor(color: UIColor, forState: UIControl.State) {
        bgColor = color
    }
    
}
