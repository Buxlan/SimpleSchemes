//
//  CircleViewProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 15.09.2022.
//

import UIKit

protocol CircleViewProtocol: UIView, ViewWithEdgesProtocol, EdgeViewDelegate where EdgeType == RectangleEdgeType {
    var initialFrame: CGRect { get set }
}

extension CircleViewProtocol where EdgeType == RectangleEdgeType {
    
    func edgeFrameBeganChanging() {
        initialFrame = frame
    }
    
    func didEdgeFrameChanged(_ translation: CGPoint, edgeType: EdgeTypeProtocol) {
        guard let edgeType = edgeType as? EdgeType else { return }
        if translation.x == 0, translation.y == 0 { return }
        
        var newFrame: CGRect
        
        switch edgeType {
        case .leftTop:
            let difx = (translation.x + translation.y) / 2,
                dify = (translation.x + translation.y) / 2
            let newOrigin = CGPoint(x: initialFrame.origin.x + difx/2, y: initialFrame.origin.y + dify/2),
                height = initialFrame.height - dify,
                width = initialFrame.width - difx,
                side = (height + width) / 2
            newFrame = CGRect(origin: newOrigin, size: CGSize(width: side, height: side))
        case .rightTop:
            let difx = -(-translation.x + translation.y) / 2,
                dify = -(-translation.x + translation.y) / 2
            let newOrigin = CGPoint(x: initialFrame.origin.x - difx/2, y: initialFrame.origin.y - dify/2),
                height = initialFrame.height + dify,
                width = initialFrame.width + difx,
                side = (height + width) / 2
            newFrame = CGRect(origin: newOrigin, size: CGSize(width: side, height: side))
        case .leftBottom:
            let difx = -(-translation.x + translation.y) / 2,
                dify = -(-translation.x + translation.y) / 2
            let newOrigin = CGPoint(x: initialFrame.origin.x + difx/2, y: initialFrame.origin.y + dify/2),
                height = initialFrame.height - dify,
                width = initialFrame.width - difx,
                side = (height + width) / 2
            newFrame = CGRect(origin: newOrigin, size: CGSize(width: side, height: side))
        case .rightBottom:
            let difx = (translation.x + translation.y) / 2,
                dify = (translation.x + translation.y) / 2
            let newOrigin = CGPoint(x: initialFrame.origin.x - difx/2, y: initialFrame.origin.y - dify/2),
                height = initialFrame.height + dify,
                width = initialFrame.width + difx,
                side = (height + width) / 2
            newFrame = CGRect(origin: newOrigin, size: CGSize(width: side, height: side))
        }
        frame = newFrame
        setNeedsDisplay()
    }
    
    func didEdgeFrameChanged(_ oldFrame: CGRect, _ newFrame: CGRect, edgeType: EdgeTypeProtocol) {
        guard let edgeType = edgeType as? EdgeType else { return }
        print("New frame is: \(newFrame)")
        
        switch edgeType {
        case .leftTop:
            let newOrigin = convert(newFrame.origin, to: superview),
                height = frame.height - newFrame.origin.y,
                width = frame.width - newFrame.origin.x,
                newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
            frame = newFrame
        case .rightTop:
            let difx = newFrame.origin.x - oldFrame.origin.x,
                dify = newFrame.origin.y - oldFrame.origin.y,
                newOrigin = CGPoint(x: frame.origin.x, y: frame.origin.y + dify),
                height = frame.height - dify,
                width = frame.width + difx,
                newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
            frame = newFrame
        case .leftBottom:
            let difx = newFrame.origin.x - oldFrame.origin.x,
                dify = newFrame.origin.y - oldFrame.origin.y,
                newOrigin = CGPoint(x: frame.origin.x + difx, y: frame.origin.y),
                height = frame.height + dify,
                width = frame.width - difx,
                newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
            frame = newFrame
        case .rightBottom:
            let difx = newFrame.origin.x - oldFrame.origin.x,
                dify = newFrame.origin.y - oldFrame.origin.y,
                newOrigin = CGPoint(x: frame.origin.x, y: frame.origin.y),
                height = frame.height + dify,
                width = frame.width + difx,
                newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
            frame = newFrame
        }
        setNeedsDisplay()
    }
    
}
