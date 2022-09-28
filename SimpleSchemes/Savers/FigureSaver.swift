//
//  FigureSaver.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import Foundation

class FigureSaver {
    
    func save(figure: Figure) {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(figure)
        } catch {
            fatalError()
            print("error")
        }
    }
    
}
