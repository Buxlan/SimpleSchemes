//
//  RectangleView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 08.09.2022.
//

import UIKit

class RectangleView: UIView, RectangleViewProtocol, SelectableAndRemovableViewWithFigureAndEdges {
    
    weak var delegate: SelectableAndRemovableViewDelegate?
    
    override var frame: CGRect {
        didSet {
            print("SquareView new frame is \(frame)")
            figure.frame = frame
        }
    }
    
    var figure: Figure
    
    let decorator = RoundedRectangleDecorator()
    
    var isSelected: Bool = false {
        didSet {
            selectEdges(isSelected)
        }
    }
    
    private var initialCenter: CGPoint = .zero
    var initialFrame: CGRect = .zero
    
    internal var edgeViews: [RectangleEdgeType: EdgeViewProtocol] = [:]
    
    required init(figure: Figure, frame: CGRect = .zero) {
        self.figure = figure
        
        super.init(frame: frame)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        addGestureRecognizer(panGesture)
        
        setupEdges()
        edgeViews.forEach { self.addSubview($1) }
        
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("RectangleView draw rect is: \(rect)")
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        let origin = CGPoint(x: rect.origin.x + decorator.offsetFromEdges, y: rect.origin.y + decorator.offsetFromEdges),
            size = CGSize(width: rect.size.width - 2 * decorator.offsetFromEdges, height: rect.size.height - 2 * decorator.offsetFromEdges)
        let pathRect = CGRect(origin: origin, size: size)
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: decorator.cornerRadius)
        
        UIColor.systemBlue.setFill()
        path.fill()
        
        edgeViews.forEach {
            let rect = $0.getRect(in: rect, size: $1.decorator.size)
            $1.frame = rect
        }        
    }
    
}

extension RectangleView {
    
    @objc func tapped() {
        switchSelection()
        setNeedsDisplay()
        delegate?.viewDidSelect(self)
    }
    
    @objc func panned(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .possible:
            print("state possible")
        case .began:
            print("state began")
            initialCenter = center
        case .changed:
            let translation = gesture.translation(in: superview)
            center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
        case .ended:
            print("state ended")
            figure.frame = frame
        case .cancelled:
            print("state cancelled")
        case .failed:
            print("state failed")
        @unknown default:
            print("unknown")
        }
    }
    
    func resize() {
        frame = CGRect(origin: frame.origin, size: CGSize(width: 50, height: 50))
        setNeedsDisplay()
    }
    
}
