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
//    = [
//        ItemData(name: "first document"),
//        ItemData(name: "second document (черновик)"),
//        ItemData(name: "third"),
//        ItemData(name: "fourth"),
//        ItemData(name: "fifth"),
//        ItemData(name: "sixth")
//    ]
    
    init() {
        items = []
    }
    
    mutating func loadItems() {
        let files = (try? FileUtil.getAvailableBlockSchemeFiles()) ?? []
        
        items = files.map { ItemData(name: $0) }
    }
    
}
