//
//  SquareView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class SquareView: UIView, SquareViewProtocol, SelectableViewWithEdges {
    
    let decorator = RoundedRectangleDecorator()
    
    var isSelected: Bool = false {
        didSet {
            selectEdges(isSelected)
        }
    }
    
    private var initialCenter: CGPoint = .zero
    var initialFrame: CGRect = .zero
    
    internal var edgeViews: [EdgeType: EdgeViewProtocol] = [:]
    
    override init(frame: CGRect = .zero) {
        
        super.init(frame: frame)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        addGestureRecognizer(panGesture)
        
        setupEdges()
        edgeViews.forEach { self.addSubview($1) }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("SquareView draw rect is: \(rect)")
        
        let origin = CGPoint(x: rect.origin.x + decorator.offsetFromEdges, y: rect.origin.y + decorator.offsetFromEdges),
            size = CGSize(width: rect.size.width - 2 * decorator.offsetFromEdges, height: rect.size.height - 2 * decorator.offsetFromEdges)
        let pathRect = CGRect(origin: origin, size: size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        var path = UIBezierPath(rect: rect)
        UIColor.systemGray6.setFill()
        path.fill()
        
        print("SquareView draw pathRect is: \(pathRect)")
        
        path = UIBezierPath(roundedRect: pathRect, cornerRadius: decorator.cornerRadius)
        UIColor.systemBlue.setFill()
        path.fill()
        
        edgeViews.forEach {
            let rect = $0.getRect(in: rect, size: $1.decorator.size)
            $1.frame = rect
        }
    }
    
}

extension SquareView {
    
    @objc func tapped() {
        switchSelection()
        setNeedsDisplay()
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

