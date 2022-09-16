//
//  VerticalToolsView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

protocol VerticalToolsViewDelegate: AnyObject {
    func addFigure(with type: FigureType)
}

class VerticalToolsView: UIView {
    
    static let height: CGFloat = 220.0
    
    weak var delegate: VerticalToolsViewDelegate?
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .center
        view.spacing = 10
        
        return view
    }()
    
    private let squareButton = SquareToolButton()
    private let circleButton = CircleToolButton()
    private let rectangleButton = RectangleToolButton()
    private let arrowButton = ArrowToolButton()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        addSubview(stackView)
        stackView.addArrangedSubview(circleButton)
        stackView.addArrangedSubview(squareButton)
        stackView.addArrangedSubview(rectangleButton)
        stackView.addArrangedSubview(arrowButton)
        
        circleButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        squareButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        rectangleButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        arrowButton.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func tapped(_ sender: UIButton) {
        if let sender = sender as? FigureTypeContaining {
            delegate?.addFigure(with: sender.type)
        }
    }
    
}
