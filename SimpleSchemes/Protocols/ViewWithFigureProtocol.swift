//
//  ViewWithFigureProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import UIKit

protocol ViewWithFigureProtocol: UIView {
    var figure: Figure { get set }
    var figureColor: UIColor { get set }
    
    init(figure: Figure, figureColor: UIColor, frame: CGRect)
}
