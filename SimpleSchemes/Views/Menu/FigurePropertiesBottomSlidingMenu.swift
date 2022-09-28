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
    
    let height: CGFloat = 200.0
    
    weak var delegate: FigurePropertiesBottomSlidingMenuDelegate?
    
    private let colorsScrollView: UIScrollView = {
        let view = UIScrollView()
        
        return view
    }()
    
    private lazy var colorsStackView: UIStackView = {
        let buttons = makeColorButtons()
        let view = UIStackView(arrangedSubviews: buttons)
        view.spacing = 5
        view.alignment = .leading
        view.axis = .horizontal
        view.distribution = .fillEqually
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 15.0
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        
        addSubview(colorsScrollView)
        colorsScrollView.addSubview(colorsStackView)
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        
        colorsScrollView.translatesAutoresizingMaskIntoConstraints = false
        colorsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = [
            colorsScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            colorsScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            colorsScrollView.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            colorsScrollView.heightAnchor.constraint(equalToConstant: 40),
            
            colorsStackView.topAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.topAnchor),
            colorsStackView.bottomAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.bottomAnchor),
            colorsStackView.leadingAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.leadingAnchor),
            colorsStackView.trailingAnchor.constraint(equalTo: colorsScrollView.contentLayoutGuide.trailingAnchor),
            colorsStackView.heightAnchor.constraint(equalTo: colorsScrollView.frameLayoutGuide.heightAnchor)
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
