//
//  ToolButton.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 14.09.2022.
//

import UIKit

protocol FigureTypeContaining {
    var type: FigureType { get }
}

class ToolButton: UIButton, FigureTypeContaining {
    
    let cornerRadius: CGFloat
    let type: FigureType
    
    init(type: FigureType, cornerRadius: CGFloat = 6.0) {
        self.type = type
        self.cornerRadius = cornerRadius
        
        super.init(frame: .zero)        
        
        layer.cornerRadius = cornerRadius
        setImage(type.image, for: .normal)
        backgroundColor = .systemGray5
        
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: heightAnchor)
        ])
    }
        
}

final class CircleToolButton: ToolButton {
    convenience init(cornerRadius: CGFloat = 6.0) {
        self.init(type: .circle, cornerRadius: cornerRadius)
    }
}

final class SquareToolButton: ToolButton {
    convenience init(cornerRadius: CGFloat = 6.0) {
        self.init(type: .square, cornerRadius: cornerRadius)
    }
}

final class RectangleToolButton: ToolButton {
    convenience init(cornerRadius: CGFloat = 6.0) {
        self.init(type: .rectangle, cornerRadius: cornerRadius)
    }
}

final class ArrowToolButton: ToolButton {
    convenience init(cornerRadius: CGFloat = 6.0) {
        self.init(type: .arrow, cornerRadius: cornerRadius)
    }
}
