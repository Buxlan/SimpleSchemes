//
//  ViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var viewModel: CanvasViewModel!
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.minimumZoomScale = 1.0
        view.maximumZoomScale = 10.0
        
        return view
    }()
    
    private let contentView: UIView = {
        let size = CGSize.zero
        let frame = CGRect(origin: .zero, size: size)
        let view = UIView(frame: frame)
        view.backgroundColor = .systemGray6
        
        return view
    }()
    
    private let toolsView = VerticalToolsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if viewModel.blockScheme.isNew {
            navigationItem.title = "CANVAS.VC.NEW.TITLE".localized()
        } else {
            navigationItem.title = viewModel.blockScheme.name
        }
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        view.addSubview(toolsView)
        toolsView.delegate = self
        
//        scrollView.contentSize = contentView.frame.size
//        scrollView.contentOffset = .init(x: contentView.frame.size.width/2, y: contentView.frame.size.height/2)
        scrollView.bounces = false
        scrollView.delegate = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(contentViewTapped))
        contentView.addGestureRecognizer(gesture)
        
        configureBars()
        
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
    
    private func configureBars() {
        let action = UIAction { [unowned self] _ in
            do {
                try self.viewModel.save()
            } catch let error as BlockSchemeSavingError {
                print(error.description)
            } catch {
                print(error.localizedDescription)
            }
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE".localized(), image: nil, primaryAction: action, menu: nil)
    }
    
    private func configureConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            
            contentView.heightAnchor.constraint(equalToConstant: 1000),
            contentView.widthAnchor.constraint(equalToConstant: 1000),
            
            toolsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            toolsView.widthAnchor.constraint(equalToConstant: 50.0),
            toolsView.heightAnchor.constraint(equalToConstant: VerticalToolsView.height),
            toolsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15)
        ]
        
        let heightConstraint = contentView.heightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.heightAnchor)
        heightConstraint.priority = .defaultLow
        
        let widthConstraint = contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        widthConstraint.priority = .defaultLow
        
        constraints += [heightConstraint, widthConstraint]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension CanvasViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("scrollView viewForZooming")
        return contentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("scrollView scrollViewDidZoom")
    }
    
}

extension CanvasViewController: VerticalToolsViewDelegate {
    func addFigure(with type: FigureType) {
        let view = FigureFactory().makeFigureView(with: type, delegate: self),
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

extension CanvasViewController: SelectableViewDelegate {
    func viewDidSelect(_ view: UIView) {
        contentView.bringSubviewToFront(view)
        print("subviews are: \(self.view.subviews)")
        contentView.subviews.forEach { subview in
            if subview === view { return }
            if let subview = subview as? SelectableView, subview.isSelected {
                subview.setSelected(false)
            }
        }
    }
}

extension CanvasViewController {
    
    @objc private func contentViewTapped() {
        contentView.subviews.forEach { subview in
            if let subview = subview as? SelectableView {
                subview.setSelected(false)
            }
        }
    }
    
}

