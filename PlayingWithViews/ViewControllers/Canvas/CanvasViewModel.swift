//
//  CanvasViewModel.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

struct CanvasViewModel {
    
    var blockScheme: BlockScheme = BlockScheme()
    
    func save() throws {
        let saver = BlockSchemeSaver()
        try saver.save(blockScheme)
    }
    
}
