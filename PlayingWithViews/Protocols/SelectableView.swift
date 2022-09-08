//
//  SelectableView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol SelectableView: UIView {
    var isSelected: Bool { get set }
    
    func setSelected(_ status: Bool)
    func switchSelection()
}

