//
//  CircleView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class CircleView: UIView, CircleViewProtocol, SelectableAndRemovableViewWithFigureAndEdges {
    typealias EdgeType = RectangleEdgeType
    
    override var frame: CGRect {
        didSet {
            print("SquareView new frame is \(frame)")
            figure.frame = frame
        }
    }
    
    var figure: Figure
    var figureColor: UIColor {
        get {
            figure.backcolor
        } set {
            figure.backcolor = newValue
        }
    }
    
    weak var delegate: SelectableAndRemovableViewDelegate?
    
    let decorator = CircleDecorator()
    
    var isSelected: Bool = false {
        didSet {
            selectEdges(isSelected)
        }
    }
    
    private lazy var customMenu: UIMenu = {
        let selectAction = UIAction(title: "TO_SELECT".localized(), image: AppImage.checkmarkCircleFill.image, attributes: []) { [unowned self] _ in
            switchSelection()
            delegate?.viewDidSelect(self)
        }
        let deleteAction = UIAction(title: "TO_DELETE".localized(), image: AppImage.trashFill.image, attributes: .destructive) { [unowned self] _ in
            delegate?.viewWillRemove(self)
            removeFromSuperview()
        }
        let menu = UIMenu(title: "CHOOSE_WHAT_TO_DO".localized(), image: nil, identifier: nil, children: [selectAction, deleteAction])
        
        return menu
    }()
    
    private var initialCenter: CGPoint = .zero
    var initialFrame: CGRect = .zero
    
    internal var edgeViews: [RectangleEdgeType: EdgeViewProtocol] = [:]
    
    required init(figure: Figure, frame: CGRect = .zero) {
        self.figure = figure
        
        super.init(frame: frame)
        
        self.figureColor = figure.backcolor
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        addGestureRecognizer(gesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        addGestureRecognizer(panGesture)
        
        setupEdges()
        edgeViews.forEach { self.addSubview($1) }
        
        isOpaque = false
        
        addInteraction(UIContextMenuInteraction(delegate: self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        print("CircleView draw rect is: \(rect)")
        
        let origin = CGPoint(x: rect.origin.x + decorator.offsetFromEdges, y: rect.origin.y + decorator.offsetFromEdges),
            size = CGSize(width: rect.size.width - 2 * decorator.offsetFromEdges, height: rect.size.height - 2 * decorator.offsetFromEdges)
        let pathRect = CGRect(origin: origin, size: size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.clear(rect)
        }
        
        print("CircleView draw pathRect is: \(pathRect)")
        
        let path = UIBezierPath(ovalIn: pathRect)
        figureColor.setFill()
        path.fill()
        
        edgeViews.forEach {
            let rect = $0.getRect(in: rect, size: $1.decorator.size)
            $1.frame = rect
        }
    }
    
}

extension CircleView {
    
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

extension CircleView: EdgeMovementValidatorProtocol {
    
    func validate(view: UIView, at point: CGPoint) -> Bool {
        guard let (edgeSide, _) = edgeViews.first(where: { $1 === view })
        else {
            print("Edge view not found")
            return false
        }

        return true
    }

}

extension CircleView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [unowned self] _ in
            customMenu
        }
    }
}
