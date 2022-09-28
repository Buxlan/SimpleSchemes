//
//  CanvasFactory.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

protocol CanvasFactory {    
    func makeNewCanvas() -> CanvasViewController
    func makeExistingCanvas(with filename: String) throws -> CanvasViewController
}
