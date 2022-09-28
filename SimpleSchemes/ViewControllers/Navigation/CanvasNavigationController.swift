//
//  CanvasNavigationController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

class CanvasNavigationController: UINavigationController {
    
    init() {
        let vc = CanvasListViewController(nibName: nil, bundle: nil)
        super.init(rootViewController: vc)
        
        tabBarItem.image = AppImage.tabCanvas.image
        tabBarItem.title = "TAB_BAR.CANVAS.TITLE".localized()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
