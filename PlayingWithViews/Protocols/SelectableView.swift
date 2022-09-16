//
//  SelectableView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol SelectableViewDelegate: AnyObject {
    func viewDidSelect(_ view: UIView)
}

protocol SelectableView: UIView {
    var delegate: SelectableViewDelegate? { get set }    
    var isSelected: Bool { get set }
    
    func setSelected(_ status: Bool)
    func switchSelection()
}

