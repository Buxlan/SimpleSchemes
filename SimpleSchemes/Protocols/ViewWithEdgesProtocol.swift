//
//  ViewWithEdgesProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol ViewWithEdgesProtocol: AnyObject {
    associatedtype EdgeType: Hashable
    var edgeViews: [EdgeType: EdgeViewProtocol] { get set }
    func setupEdges()
    func selectEdges(_ isSelected: Bool)
    
}

extension ViewWithEdgesProtocol {
    
    func selectEdges(_ isSelected: Bool) {
        edgeViews.forEach { (key, view) in
            view.isHidden = !isSelected
        }
    }
    
}

extension ViewWithEdgesProtocol where EdgeType == RectangleEdgeType {
    
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
}

extension ViewWithEdgesProtocol where EdgeType == ArrowEdgeType {
    
    func setupEdges() {
        var type: EdgeType = .start,
            view = SquareEdgeView(type: type)
        edgeViews[type] = view
        
        type = .end
        view = SquareEdgeView(type: type)
        edgeViews[type] = view
    }
}
