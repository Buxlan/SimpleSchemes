//
//  SelectableViewWithEdges.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 07.09.2022.
//

protocol SelectableViewWithEdges: SelectableView, ViewWithEdgesProtocol {
    func selectEdges(_ isSelected: Bool)
}

extension SelectableViewWithEdges {
    
    func setSelected(_ status: Bool) {
        isSelected = status
    }
    
    func switchSelection() {
        isSelected.toggle()
    }
    
    func selectEdges(_ isSelected: Bool) {
        edgeViews.forEach { $1.setSelected(isSelected) }
    }
    
}
