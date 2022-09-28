//
//  SelectableView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol Selectable: AnyObject {
    var isSelected: Bool { get set }
    func setSelected(_ status: Bool)
    func switchSelection()
}

extension Selectable {
    func setSelected(_ status: Bool) {
        isSelected = status
    }
    
    func switchSelection() {
        isSelected.toggle()
    }
}

protocol RemovableViewDelegate: AnyObject {
    func viewWillRemove(_ view: ViewWithFigureProtocol)
}

protocol SelectableViewDelegate: AnyObject {
    func viewDidSelect(_ view: UIView)
}

protocol SelectableView: UIView, Selectable {
    var delegate: SelectableViewDelegate? { get set }
}

protocol SelectableAndRemovableViewDelegate: SelectableViewDelegate, RemovableViewDelegate {}

protocol SelectableAndRemovableViewWithFigure: ViewWithFigureProtocol, Selectable {
    var delegate: SelectableAndRemovableViewDelegate? { get set }
}

