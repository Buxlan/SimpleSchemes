//
//  ArrowViewProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 24.09.2022.
//

import UIKit

protocol ArrowViewProtocol: UIView, ViewWithEdgesProtocol, EdgeViewDelegate where EdgeType == ArrowEdgeType {
    var initialFrame: CGRect { get set }
    var initialTransform: CGAffineTransform { get set }
}

extension ArrowViewProtocol {
    
    func edgeFrameBeganChanging() {
        initialFrame = frame
        initialTransform = transform
    }
    
    func didEdgeFrameChanged(_ translation: CGPoint, edgeType: EdgeTypeProtocol) {
        guard let edgeType = edgeType as? EdgeType else { return }
        if translation.x == 0, translation.y == 0 { return }
        let difx = translation.x,
            dify = translation.y
        var newFrame: CGRect
        
        
        guard difx != 0, dify != 0 else { return }
//        guard dify != 0 else { return }
        
//        switch edgeType {
//        case .start:
//            let newOrigin = CGPoint(x: initialFrame.origin.x + difx, y: initialFrame.origin.y + dify),
//                height = initialFrame.height - dify,
//                width = initialFrame.width - difx
//            newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
//        case .end:
//            let newOrigin = CGPoint(x: initialFrame.origin.x, y: initialFrame.origin.y + dify),
//                height = initialFrame.height - dify,
//                width = initialFrame.width + difx
//            newFrame = CGRect(origin: newOrigin, size: CGSize(width: width, height: height))
//        }
//        frame = newFrame
        
        let identity = transform
//        transform = CGAffineTransform(a: identity.a, b: identity.b, c: identity.c, d: identity.d, tx: difx, ty: dify)
//        transform = CGAffineTransform(rotationAngle: .pi/4)
//        transform = CGAffineTransform(translationX: difx, y: dify)
//        transform = CGAffineTransform(
        
        
        
        var angle = atan2(dify, difx)
//        angle = angle < 0 ? abs(angle) : 360 - angle
        
        print("didEdgeFrameChanged difX: \(difx), difY: \(dify), radians are: \(angle)")
        
        let tr = initialTransform.rotated(by: angle)
        
        transform = tr

//        var angle: CGFloat
//        if dify > 0 {
//            angle = .pi/40
//        } else {
//            angle = -.pi/40
//        }
//        transform = transform.rotated(by: angle)
//        transform = CGAffineTransform(a: identity.a, b: identity.b, c: identity.c, d: identity.d, tx: difx, ty: dify)
//        transform = CGAffineTransform(rotationAngle: -.pi/20)
        
//        transform = CGAffineTransform(a: initialTransform.a, b: initialTransform.b, c: initialTransform.c, d: initialTransform.d, tx: difx, ty: dify)
        
//        transform = CGAffineTransform(scaleX: dify, y: dify)
        
//        setNeedsDisplay()
    }
    
    func didEdgeFrameChanged(_ oldFrame: CGRect, _ newFrame: CGRect, edgeType: EdgeTypeProtocol) {
        guard let edgeType = edgeType as? EdgeType else { return }
        print("New frame is: \(newFrame)")
        
        switch edgeType {
        case .start:
            break
        case .end:
            break
        }
        setNeedsDisplay()
    }
    
}
