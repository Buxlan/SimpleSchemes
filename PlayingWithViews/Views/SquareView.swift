//
//  SquareView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class SquareView: UIView, ConnectableView, SelectableViewWithEdges {
    
    weak var connectedView: ConnectableView?
    
    var isSelected: Bool = false {
        didSet {
            selectEdges(isSelected)
        }
    }
    
    private let lineLayer = CAShapeLayer()
    private let shapeLayer = CAShapeLayer()
    
    internal var edgeViews: [EdgeType: EdgeViewProtocol] = [:]
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        
        setupEdges()
        selectEdges(false)
        edgeViews.forEach { self.addSubview($1) }
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle))
        addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureHandle))
        addGestureRecognizer(tapGesture)
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
        
        var edgePoints: [CGPoint] = []
        var minX: CGFloat = .greatestFiniteMagnitude,
            minY: CGFloat = .greatestFiniteMagnitude,
            maxX: CGFloat = -.greatestFiniteMagnitude,
            maxY: CGFloat = -.greatestFiniteMagnitude
        
        edgeViews.forEach { (edgeType, view) in
            print("SquareView edgeType \(edgeType) frame is: \(view.frame)")
            let rect = view.frame
//            let rect = edgeType.getRect(in: self.frame, size: view.decorator.size)
            let point = edgeType.getEdgePoint(bounds: rect),
                converted = convert(point, to: self)
            
            minX = min(minX, point.x)
            minY = min(minY, point.y)
            maxX = max(maxX, point.x)
            maxY = max(maxY, point.y)
        }
        
        let origin = frame.origin
        
        let newFrame = CGRect(origin: origin, size: CGSize(width: (maxX-minX), height: (maxY-minY)))
//        frame = newFrame
        
//        self.draw(newFrame)
        setNeedsDisplay(newFrame)
        
        print("SquareView layoutSubviews newFrame is: \(frame)")
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
    
    @objc private func tapGestureHandle() {
        switchSelection()
    }
    
    internal func connectedViewFrameDidChanged() {
        
    }
    
}

extension SquareView: EdgeMovementValidatorProtocol {
    
    func validate(view: UIView, at point: CGPoint) -> Bool {
        guard let (edgeSide, _) = edgeViews.first(where: { $1 === view })
        else {
            print("Edge view not found")
            return false
        }

        return true
    }

}

