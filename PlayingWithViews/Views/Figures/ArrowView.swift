//
//  ArrowView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.09.2022.
//

import UIKit

class ArrowView: UIView, SelectableViewWithEdges {
    typealias EdgeType = ArrowEdgeType    
    
    weak var connectedView1: UIView?
    weak var connectedView2: UIView?
    
    weak var delegate: SelectableViewDelegate?
    
    let decorator = ArrowDecorator()
    
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
        
        isOpaque = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("ArrowView draw rect is: \(rect)")
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        let origin = CGPoint(x: rect.origin.x, y: rect.midY)
        let end = CGPoint(x: origin.x + rect.maxX, y: rect.midY)
        let path = UIBezierPath.arrow(from: origin, to: end, tailWidth: 10, headWidth: 20, headLength: 10)
        
        UIColor.black.setFill()
        path.fill()
        
        edgeViews.forEach {
            let rect = $0.getRect(in: rect, size: $1.decorator.size)
            $1.frame = rect
        }
    }    
    
}

extension ArrowView {
    
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
