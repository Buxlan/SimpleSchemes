//
//  SquareView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class SquareView: UIView, SquareViewProtocol, SelectableAndRemovableViewWithFigureTextAndEdges {
    
    typealias EdgeType = RectangleEdgeType
    
    weak var delegate: SelectableAndRemovableViewDelegate?
    weak var textDelegate: (UITextViewDelegate & DoneKeyboardAccessoryViewDelegate)?
    
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
    
    let decorator = RoundedRectangleDecorator()
    
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
    
    private lazy var keyboardAccessoryView: DoneKeyboardAccessoryView = {
        let width = UIScreen.main.bounds.width
        let frame = CGRect(x: 0, y: 0, width: width, height: 44)
        let view = DoneKeyboardAccessoryView(frame: frame)
        view.delegate = self
        return view
    }()
    
    private lazy var textView: UITextView = {
        let view = UITextView()
        view.textColor = .black
        view.font = .systemFont(ofSize: 15)
        view.delegate = self
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.inputAccessoryView = keyboardAccessoryView
        view.isScrollEnabled = false
        
        return view
    }()
    
    private var initialCenter: CGPoint = .zero
    var initialFrame: CGRect = .zero
    
    internal var edgeViews: [EdgeType: EdgeViewProtocol] = [:]
    
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
        
        configureInterface()
        configureConstraints()
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
        
        print("SquareView draw pathRect is: \(pathRect)")
        
        let path = UIBezierPath(roundedRect: pathRect, cornerRadius: decorator.cornerRadius)
        figureColor.setFill()
        path.fill()
        
        edgeViews.forEach {
            let rect = $0.getRect(in: rect, size: $1.decorator.size)
            $1.frame = rect
        }
    }
    
    private func configureInterface() {
        addSubview(textView)
    }
    
    private func configureConstraints() {
        let constraints: [NSLayoutConstraint] = [
            textView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textView.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -20),
            textView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
 
// MARK: - UITextViewDelegate
extension SquareView: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textDelegate?.textViewShouldBeginEditing?(textView) ?? true
    }
    
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        textDelegate?.textViewShouldEndEditing?(textView) ?? true
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textDelegate?.textViewDidBeginEditing?(textView)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textDelegate?.textViewDidEndEditing?(textView)
    }

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        textDelegate?.textView?(textView, shouldChangeTextIn: range, replacementText: text) ?? true
    }

    func textViewDidChange(_ textView: UITextView) {
        textDelegate?.textViewDidChange?(textView)
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
        textDelegate?.textViewDidChangeSelection?(textView)
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        textDelegate?.textView?(textView, shouldInteractWith: URL, in: characterRange, interaction: interaction) ?? true
    }

    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        textDelegate?.textView?(textView, shouldInteractWith: textAttachment, in: characterRange, interaction: interaction) ?? true
    }
}

extension SquareView: DoneKeyboardAccessoryViewDelegate {
    func onDone() {
        textView.resignFirstResponder()
        textDelegate?.onDone()
    }
}

extension SquareView {
    
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

extension SquareView: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { [unowned self] _ in
            customMenu
        }
    }
}

