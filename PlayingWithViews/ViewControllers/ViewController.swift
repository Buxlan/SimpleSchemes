//
//  ViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1.0
        view.maximumZoomScale = 10.0
        
        return view
    }()
    
    private let contentView: UIView = {
        let size = CGSize(width: 1000.0, height: 1000.0)
        let frame = CGRect(origin: .zero, size: size)
        let view = UIView(frame: frame)
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let toolsView = VerticalToolsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Testing views"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(toolsView)
        toolsView.delegate = self
        
        scrollView.contentSize = contentView.frame.size
        scrollView.contentOffset = .init(x: contentView.frame.size.width/2, y: contentView.frame.size.height/2)
        scrollView.delegate = self
        
        configureConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("ViewController viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("ViewController viewDidLayoutSubviews")
    }
    
    private func configureConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            toolsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            toolsView.widthAnchor.constraint(equalToConstant: 50.0),
            toolsView.heightAnchor.constraint(equalToConstant: VerticalToolsView.height),
            toolsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ]
        
        NSLayoutConstraint.activate(constraints)        
    }


}

extension ViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("scrollView viewForZooming")
        return contentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("scrollView scrollViewDidZoom")
    }
    
}

extension ViewController: VerticalToolsViewDelegate {
    func addFigure(with type: FigureType) {
        let view = FigureFactory().makeFigureView(with: type),
            size = AppConfig.newFigureDefaultSize,
            midX = scrollView.contentOffset.x + scrollView.bounds.size.width / 2 - size.width / 2,
            midY = scrollView.contentOffset.y + scrollView.bounds.size.height / 2 - size.height / 2,
            origin = CGPoint(x: midX, y: midY),
            frame = CGRect(origin: origin, size: size)
        
        view.frame = frame
        
        print("scrollView.bounds: \(scrollView.bounds)")
        print("scrollView.bounds.midX: \(scrollView.bounds.midX)")
        print("scrollView.bounds.midY: \(scrollView.bounds.midY)")
        
        contentView.addSubview(view)
    }
}

