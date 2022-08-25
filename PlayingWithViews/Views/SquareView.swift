//
//  SquareView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class SquareView: UIView, ConnectableView {
    
    weak var connectedView: ConnectableView?
    let lineLayer = CAShapeLayer()
    let shapeLayer = CAShapeLayer()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle))
        addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("SquareView draw frame is: \(frame)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("SquareView layoutSubviews frame is: \(frame)")
        
//        let origin = CGPoint(x: 50.0, y: 100.0),
//            size = CGSize(width: 300.0, height: 300.0),
//            newFrame = CGRect(origin: origin, size: size)
//
//        frame = newFrame
    }
    
}

extension SquareView {
    
    func connect(to view: ConnectableView) {
        connectedView = view
        view.connectedView = self
    }
    
    private func drawLine() {
        
        guard let connectedView = connectedView else { return }
        
        let start = convert(center, from: superview),
        end = convert(connectedView.center, from: connectedView.superview)
        
        print("SquareView start is: \(start)")
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
            connectedView?.connectedViewFrameDidChanged()
            
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
    
    internal func connectedViewFrameDidChanged() {
        
    }
    
}
