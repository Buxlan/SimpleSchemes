//
//  ViewWithEdgesProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol ViewWithEdgesProtocol: AnyObject {
    
    var edgeViews: [EdgeType: EdgeViewProtocol] { get set }
    func setupEdges()
    func selectEdges(_ isSelected: Bool)
    
}

extension ViewWithEdgesProtocol {
    
    func setupEdges() {
        var type: EdgeType = .leftBottom,
            view = SquareEdgeView(type: type)
        edgeViews[type] = view
        
        type = .leftTop
        view = SquareEdgeView(type: type)
        edgeViews[type] = view
        
        type = .rightTop
        view = SquareEdgeView(type: type)
        edgeViews[type] = view
        
        type = .rightBottom
        view = SquareEdgeView(type: type)
        edgeViews[type] = view
    }
    
    func selectEdges(_ isSelected: Bool) {
        edgeViews.forEach { (key, view) in
            view.isHidden = !isSelected
        }
    }
    
}
