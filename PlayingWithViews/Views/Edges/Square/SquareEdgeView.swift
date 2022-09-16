//
//  SquareEdgeView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

final class SquareEdgeView: UIView, EdgeViewProtocol {
    
    weak var delegate: SelectableViewDelegate?    
    
    var isSelected: Bool = false {
        didSet {
            isHidden = !isSelected
        }
    }
    var edgeType: EdgeTypeProtocol
    var decorator: EdgeViewDecoratorProtocol = SquareEdgeDecorator()
    
    private var initialCenter: CGPoint = .zero
    
    init(type: EdgeTypeProtocol, frame: CGRect = .zero) {
        edgeType = type
        
        super.init(frame: frame)
        
        isHidden = true
        decorator.decorate(view: self)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureHandle))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("SquareEdgeView draw rect is: \(rect)")
//        print("SquareEdgeView draw superview bounds are: \(superview.bounds)")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("SquareEdgeView layoutSubviews frame is: \(frame)")
    }
    
    func setSelected(_ status: Bool) {
        isSelected = status
    }
    
    func switchSelection() {
        isSelected.toggle()
    }
    
}

extension SquareEdgeView {
    
    @objc private func panGestureHandle(_ gesture: UIPanGestureRecognizer) {
        
        switch gesture.state {
        case .possible:
            print("state possible")
        case .began:
            print("state began")
            initialCenter = center
            if let superview = superview as? EdgeViewDelegate {
                superview.edgeFrameBeganChanging()
            }
        case .changed:
            let oldFrame = frame
            let translation = gesture.translation(in: superview)
            center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
                
            if let superview = superview as? EdgeViewDelegate {
                print("SquareEdgeView frame before are: \(oldFrame)")
                print("SquareEdgeView frame after are: \(frame)")
                superview.didEdgeFrameChanged(translation, edgeType: edgeType)
            }
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
    
}
