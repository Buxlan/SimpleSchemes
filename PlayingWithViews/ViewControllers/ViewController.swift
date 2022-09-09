//
//  ViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let squareView: SquareView = {
        let view = SquareView()
        
        let origin = CGPoint(x: 30.0, y: 100.0),
            size = CGSize(width: 100.0, height: 100.0),
            newFrame = CGRect(origin: origin, size: size)
        
        view.frame = newFrame
        
        view.backgroundColor = .systemBlue
        
        return view
    }()
    
    private let circleView: CircleView = {
        let view = CircleView()
        
        let origin = CGPoint(x: 200.0, y: 100.0),
            size = CGSize(width: 50.0, height: 50.0),
            newFrame = CGRect(origin: origin, size: size)
        
        view.frame = newFrame
        
        return view
    }()
    
    private let rectangleView: RectangleView = {
        let view = RectangleView()
        
        view.backgroundColor = .systemGray
        
        let origin = CGPoint(x: 100.0, y: 300.0),
            size = CGSize(width: 200.0, height: 200.0),
            newFrame = CGRect(origin: origin, size: size)
        
        view.frame = newFrame
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Testing views"
        
        view.addSubview(squareView)
        view.addSubview(circleView)
        view.addSubview(rectangleView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("ViewController viewWillLayoutSubviews Square view frame is: \(squareView.frame)")
        
//        UIView.animate(withDuration: 3) {
//            let origin = CGPoint(x: 30.0, y: 100.0),
//                size = CGSize(width: 200.0, height: 200.0)
//
//            self.squareView.frame = CGRect(origin: origin, size: size)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("ViewController viewDidLayoutSubviews Square view frame is: \(squareView.frame)")
        
//        UIView.animate(withDuration: 3) {
//            let origin = CGPoint(x: 30.0, y: 100.0),
//                size = CGSize(width: 200.0, height: 200.0)
//
//            self.squareView.frame = CGRect(origin: origin, size: size)
//        }
    }


}

