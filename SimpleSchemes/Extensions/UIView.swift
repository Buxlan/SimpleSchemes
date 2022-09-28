//
//  UIView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 15.09.2022.
//

import UIKit

extension UIView {
    func makeClearHole(rect: CGRect) {
        let maskLayer = CAShapeLayer()
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.black.cgColor
        
        let pathToOverlay = UIBezierPath(rect: self.bounds)
        pathToOverlay.append(UIBezierPath(rect: rect))
        pathToOverlay.usesEvenOddFillRule = true
        maskLayer.path = pathToOverlay.cgPath
        
        layer.mask = maskLayer
    }
}
