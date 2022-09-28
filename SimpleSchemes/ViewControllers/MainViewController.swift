//
//  MainViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

class MainViewController: UITabBarController {
    
    let canvasViewController = CanvasNavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewControllers([canvasViewController], animated: false)
    }
    
}
