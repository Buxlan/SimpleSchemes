//
//  CanvasFactoryImpl.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

struct CanvasFactoryImpl: CanvasFactory {
    
    func makeNewCanvas() -> CanvasViewController {
        let vc = CanvasViewController()
        let model = CanvasViewModel()
        vc.viewModel = model
        
        return vc
    }
    
    func makeExistingCanvas(with filename: String) throws -> CanvasViewController {
        let vc = CanvasViewController()
        let scheme = try BlockSchemeLoader().load(fromFile: filename)
        let model = CanvasViewModel(blockScheme: scheme)
        
        vc.viewModel = model
        
        return vc
    }
    
}
