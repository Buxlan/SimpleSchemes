//
//  AppInitializer.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

struct AppInitializer {
    
    func configureBars() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .systemOrange
    
        UITableView.appearance().sectionHeaderTopPadding = 0.0
        
        let tintColor: UIColor = .systemOrange
        UITabBar.appearance().tintColor = tintColor
        UITabBar.appearance().backgroundColor = .white
    }
    
}
