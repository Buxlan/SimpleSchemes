//
//  EdgeType.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import CoreGraphics

enum EdgeType {
    case leftTop
    case rightTop
    case leftBottom
    case rightBottom
    
    func getRect(in superViewBounds: CGRect, size: CGSize) -> CGRect {
        
        var result: CGRect
        var origin: CGPoint
        
        switch self {
        case .leftBottom:
            origin = CGPoint(x: superViewBounds.minX,
                             y: superViewBounds.maxY - size.height)
        case .leftTop:
            origin = CGPoint(x: superViewBounds.minX,
                             y: superViewBounds.minY)
        case .rightTop:
            origin = CGPoint(x: superViewBounds.maxX - size.width,
                             y: superViewBounds.minY)
        case .rightBottom:
            origin = CGPoint(x: superViewBounds.maxX - size.width,
                             y: superViewBounds.maxY - size.width)
        }
        
        result = CGRect(origin: origin, size: size)
        
        return result
    }
    
    func getEdgePoint(bounds: CGRect) -> CGPoint {
        
        var point: CGPoint
        
        switch self {
        case .leftBottom:
            point = .init(x: bounds.minX, y: bounds.maxY)
        case .leftTop:
            point = .init(x: bounds.minX, y: bounds.minY)
        case .rightTop:
            point = .init(x: bounds.maxX, y: bounds.minY)
        case .rightBottom:
            point = .init(x: bounds.maxX, y: bounds.maxY)
        }
        
        return point
    }
}
