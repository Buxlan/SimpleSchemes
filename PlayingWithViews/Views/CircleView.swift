//
//  CircleView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class CircleView: UIView, ConnectableView {
    
    weak var connectedView: ConnectableView?
    let lineLayer = CAShapeLayer()
    let shapeLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.systemGreen.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.lineWidth = 5
        
        return layer
    }()
    
    let clearCircleLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.blue.cgColor
        layer.lineWidth = 10
        layer.fillRule = .nonZero
        
        return layer
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle))
        addGestureRecognizer(gesture)
        
        layer.mask = clearCircleLayer
        layer.addSublayer(shapeLayer)
        layer.addSublayer(lineLayer)
//        layer.addSublayer(clearCircleLayer)
        
        lineLayer.lineJoin = CAShapeLayerLineJoin(rawValue: "line")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect, for formatter: UIViewPrintFormatter) {
        super.draw(rect, for: formatter)
        
        print("CircleView draw_rect frame is: \(frame)")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("CircleView draw frame is: \(frame)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("CircleView layoutSubviews frame is: \(frame)")
        
        let circlePath = UIBezierPath(ovalIn: bounds)
        shapeLayer.path = circlePath.cgPath
        
        let newOrigin = CGPoint(x: bounds.width/4, y: bounds.height/4)
        let littleBounds = CGRect(origin: newOrigin,
                                  size: CGSize(width: bounds.width/2,
                                               height: bounds.height/2))
        let transparentCirclePath = UIBezierPath(ovalIn: littleBounds)
        clearCircleLayer.path = transparentCirclePath.cgPath
        
        print("CircleView sublayers count: \(layer.sublayers?.count ?? 0)")
        
        
//        let origin = CGPoint(x: 50.0, y: 100.0),
//            size = CGSize(width: 300.0, height: 300.0),
//            newFrame = CGRect(origin: origin, size: size)
//
//        frame = newFrame
    }
    
}

extension CircleView {
    
    func connect(to view: ConnectableView) {
        connectedView = view
        view.connectedView = self
    }
    
    private func drawLine() {
        
        guard let connectedView = connectedView else { return }
        
        let start = convert(center, from: superview),
        end = convert(connectedView.center, from: connectedView.superview)
        
        print("circleView start is: \(start)")
        print("connectedView end is: \(end)")
        
        let path = UIBezierPath()
        
        path.move(to: start)
        path.addLine(to: end)
        lineLayer.path = path.cgPath
        
        lineLayer.strokeColor = UIColor.black.cgColor
        lineLayer.lineWidth = 2
        
        layer.addSublayer(lineLayer)
        
    }
    
    @objc private func panGestureHandle(_ gesture: UIPanGestureRecognizer) {
        
        guard let view = gesture.view else { return }
        
        switch gesture.state {
        case .possible:
            print("state possible")
        case .began:
            print("state began")
        case .changed:
//            print("state changed")
            let point1 = gesture.translation(in: superview!)
//            print("Point 1 is: \(point1)")
            
            let point2 = gesture.location(in: superview!)
            print("Point 2 is: \(point2)")
            center = point2
            
            var newCenter = view.center
            newCenter.x += point1.x
            newCenter.y += point1.y
            view.center = newCenter
            
            gesture.setTranslation(.zero, in: superview!)
            
            drawLine()
        case .ended:
            print("state ended")
        case .cancelled:
            print("state cancelled")
        case .failed:
            print("state failed")
        @unknown default:
            print("unknown")
        }
        
    }
    
    func connectedViewFrameDidChanged() {
        drawLine()
    }
    
}
