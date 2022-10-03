//
//  FigurePropertiesBottomSlidingMenu.swift
//  SimpleSchemes
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.09.2022.
//

import UIKit

protocol FigurePropertiesBottomSlidingMenuDelegate: AnyObject {
    func colorDidSelect(_ color: UIColor)
}

class FigurePropertiesBottomSlidingMenu: UIView {
    
    enum State {
        case opened
        case closed
    }
    private(set) var state = State.closed
    
    let height: CGFloat = 200.0
    
    weak var delegate: FigurePropertiesBottomSlidingMenuDelegate?
    
    private let colorsScrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private var initialFrame: CGRect = .zero
    
    private lazy var colorsStackView: UIStackView = {
        let buttons = makeColorButtons()
        let view = UIStackView(arrangedSubviews: buttons)
        view.spacing = 5
        view.alignment = .leading
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    private let cutView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray
        view.layer.cornerRadius = 3
        
        return view
    }()
    
    private let colorsLabel: UILabel = {
        let view = UILabel()
        view.textColor = .systemGray
        view.font = .systemFont(ofSize: 15)
        view.text = "FIGURE_COLOR".localized()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        
        addSubview(cutView)
        addSubview(colorsLabel)
        addSubview(colorsScrollView)
        colorsScrollView.addSubview(colorsStackView)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panned))
        addGestureRecognizer(panGesture)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setState(_ newState: State) {
        state = newState
    }
    
    private func configureConstraints() {
        
        colorsScrollView.translatesAutoresizingMaskIntoConstraints = false
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        cutView.translatesAutoresizingMaskIntoConstraints = false
        colorsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = [
            colorsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            colorsScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            colorsScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 50),
            colorsScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            colorsStackView.topAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.topAnchor),
            colorsStackView.bottomAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.bottomAnchor),
            colorsStackView.leadingAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.leadingAnchor),
            colorsStackView.trailingAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.trailingAnchor),
            colorsStackView.heightAnchor.constraint(equalTo: colorsScrollView.frameLayoutGuide.heightAnchor),
            
            cutView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            cutView.widthAnchor.constraint(equalToConstant: 60),
            cutView.topAnchor.constraint(equalTo: self.topAnchor, constant: 14),
            cutView.heightAnchor.constraint(equalToConstant: 6),
            
            colorsLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            colorsLabel.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, constant: -30),
            colorsLabel.bottomAnchor.constraint(equalTo: colorsScrollView.topAnchor, constant: -5),
            colorsLabel.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor)
        ]
        
        colorsStackView.arrangedSubviews.forEach { view in
            constraints.append(view.heightAnchor.constraint(equalTo: view.widthAnchor))
        }
        
        let widthConstraint = colorsStackView.widthAnchor.constraint(equalTo: colorsScrollView.frameLayoutGuide.widthAnchor)
        widthConstraint.priority = .defaultLow
        
        constraints += [widthConstraint]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makeColorButtons() -> [UIButton] {
        let views: [UIButton] = ViewColor.allCases.map { value in
            let view = CircleButton()
            view.bgColor = value.color
            view.addTarget(self, action: #selector(colorViewTapHandle), for: .touchUpInside)
            return view
        }
        
        return views
    }
    
    @objc private func colorViewTapHandle(_ sender: UIButton) {
        guard let sender = sender as? CircleButton else { return }
        delegate?.colorDidSelect(sender.bgColor)
    }
    
}

extension FigurePropertiesBottomSlidingMenu {
    
    @objc func panned(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .possible:
            print("state possible")
        case .began:
            print("state began")
            initialFrame = frame
        case .changed:
            let translation = gesture.translation(in: superview)
            processTranslation(translation)
        case .ended:
            print("state ended")
            processTranslationEnded()
        case .cancelled:
            print("state cancelled")
        case .failed:
            print("state failed")
        @unknown default:
            print("unknown")
        }
    }
    
    func processTranslation(_ translation: CGPoint) {
        switch state {
        case .opened:
            let newY = (frame.minY + translation.y > initialFrame.minY) ? translation.y : 0
            let newTranslation = CGPoint(x: 0, y: newY)
            UIView.animate(withDuration: 0.2) {
                let newOrigin = CGPoint(x: self.initialFrame.origin.x, y: self.initialFrame.origin.y + newTranslation.y)
                let newFrame = CGRect(origin: newOrigin, size: self.initialFrame.size)
                self.frame = newFrame
            }
        case .closed:
            break
        }
    }
    
    func processTranslationEnded() {
        switch state {
        case .opened:
            if (frame.origin.y - initialFrame.origin.y) > (initialFrame.size.height / 2.8) {
                UIView.animate(withDuration: 0.5) {
                    let origin = CGPoint(x: self.initialFrame.origin.x,
                                         y: self.initialFrame.origin.y + self.initialFrame.size.height)
                    let newFrame = CGRect(origin: origin, size: self.initialFrame.size)
                    self.frame = newFrame
                    self.setState(.closed)
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    let origin = CGPoint(x: self.initialFrame.origin.x,
                                         y: self.initialFrame.origin.y)
                    let newFrame = CGRect(origin: origin, size: self.initialFrame.size)
                    self.frame = newFrame
                    self.setState(.opened)
                }
            }
        case .closed:
            break
        }
        
    }
    
}
