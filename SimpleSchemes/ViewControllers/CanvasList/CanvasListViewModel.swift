//
//  CanvasListViewModel.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

struct CanvasListViewModel {
    
    struct ItemData {
        var name: String
    }
    
    var items: [ItemData]
    
    init() {
        items = []
    }
    
    mutating func loadItems() {
        let files = (try? FileUtil.getAvailableBlockSchemeFiles()) ?? []
        
        items = files.map { ItemData(name: $0) }.sorted(by: { $0.name < $1.name })
    }
    
}
