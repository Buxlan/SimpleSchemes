//
//  SelectableViewWithEdges.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.09.2022.
//

protocol SelectableAndRemovableViewWithFigureAndEdges: SelectableAndRemovableViewWithFigure, ViewWithEdgesProtocol {
    func selectEdges(_ isSelected: Bool)
}

extension SelectableAndRemovableViewWithFigureAndEdges {
    
    func selectEdges(_ isSelected: Bool) {
        edgeViews.forEach { $1.setSelected(isSelected) }
    }
    
}
