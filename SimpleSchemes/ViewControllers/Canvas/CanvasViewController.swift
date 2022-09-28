//
//  ViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

class CanvasViewController: UIViewController {
    
    var viewModel: CanvasViewModel!
    let figureViewFactory: FigureViewFactory = FigureViewFactoryImpl()
    
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
    
    private let bottomMenuView = FigurePropertiesBottomSlidingMenu()
    
    private let toolsView = VerticalToolsView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        if viewModel.blockScheme.isNew {
            navigationItem.title = "CANVAS.VC.NEW.TITLE".localized()
        } else {
            navigationItem.title = viewModel.blockScheme.name
        }
        updateCanvas()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        bottomMenuView.delegate = self
        bottomMenuView.backgroundColor = .systemGray3
        view.addSubview(bottomMenuView)
        
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
        
        hideFigurePropertiesMenu()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("ViewController viewWillLayoutSubviews")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("ViewController viewDidLayoutSubviews")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    private func configureBars() {
        tabBarController?.tabBar.isHidden = true
        
        let action = UIAction { [unowned self] _ in
            if viewModel.blockScheme.isNew {
                let alert = UIAlertController.makeInputTextAlert(title: "INPUT.NAME".localized(),
                                                                 message: nil) { [unowned self] result in
                    switch result {
                    case .success(let name):
                        guard let name = name, !name.isEmpty else { return }
                        viewModel.blockScheme.name = name
                        saveScheme()
                    case .failure(_):
                        return
                    }
                }
                present(alert, animated: true, completion: nil)
            } else {
                saveScheme()
            }            
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "SAVE".localized(), image: nil, primaryAction: action, menu: nil)
    }
    
    private func saveScheme() {
        do {
            try viewModel.save()
        } catch let error as BlockSchemeError {
            print(error.description)
        } catch {
            print(error.localizedDescription)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func configureConstraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        toolsView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints: [NSLayoutConstraint] = [
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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

// MARK: - UIScrollViewDelegate

extension CanvasViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print("scrollView viewForZooming")
        return contentView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("scrollView scrollViewDidZoom")
    }
    
}

// MARK: - VerticalToolsViewDelegate

extension CanvasViewController: VerticalToolsViewDelegate {
    func addFigure(with type: FigureType) {
        let figure = viewModel.addFigure(with: type)
        let view = figureViewFactory.makeFigureView(figure, color: .systemBlue, frame: .zero, delegate: self),
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

// MARK: - SelectableAndRemovableViewDelegate

extension CanvasViewController: SelectableAndRemovableViewDelegate {
    
    func viewWillRemove(_ view: ViewWithFigureProtocol) {
        do {
            try viewModel.blockScheme.remove(figure: view.figure)            
        } catch {
            print("Deleting figure error")
        }
    }
    
    func viewDidSelect(_ view: UIView) {
        if let view = view as? ViewWithFigureProtocol {
            viewModel.selectedFigure = view.figure
        }
        contentView.bringSubviewToFront(view)
        print("subviews are: \(self.view.subviews)")
        contentView.subviews.forEach { subview in
            if subview === view { return }
            if let subview = subview as? Selectable, subview.isSelected {
                subview.setSelected(false)
            }
        }
        if let view = view as? Selectable, view.isSelected {
            showFigurePropertiesMenu(true)
        } else {
            hideFigurePropertiesMenu(true)
        }
    }
}

// MARK: - CanvasViewModelDelegate

extension CanvasViewController: CanvasViewModelDelegate {
    func updateCanvas() {
        print("CanvasViewController updateCanvas")
        contentView.subviews.forEach { $0.removeFromSuperview() }
        viewModel.blockScheme.figures.items.forEach { figure in
            let view = figureViewFactory.makeFigureView(figure, color: figure.backcolor,frame: figure.frame, delegate: self)
            view.frame = figure.frame
            
            contentView.addSubview(view)
        }
    }
}

// MARK: - FigurePropertiesBottomSlidingMenuDelegate

extension CanvasViewController: FigurePropertiesBottomSlidingMenuDelegate {
    func colorDidSelect(_ color: UIColor) {
        guard let figure = viewModel.selectedFigure else { return }
        set(color: color, to: figure)
    }
}

extension CanvasViewController {
    
    @objc private func contentViewTapped() {
        contentView.subviews.forEach { subview in
            if let subview = subview as? SelectableAndRemovableViewWithFigure {
                subview.setSelected(false)
            }
        }
        hideFigurePropertiesMenu(true)
    }
    
    private func showFigurePropertiesMenu(_ animated: Bool = false) {
        let origin = CGPoint(x: view.bounds.minX, y: view.bounds.maxY-bottomMenuView.height)
        let size = CGSize(width: view.bounds.width, height: bottomMenuView.height)
        
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.bottomMenuView.frame = CGRect(origin: origin, size: size)
            }
        } else {
            bottomMenuView.frame = CGRect(origin: origin, size: size)
        }
    }
    
    private func hideFigurePropertiesMenu(_ animated: Bool = false) {
        let origin = CGPoint(x: view.bounds.minX, y: view.bounds.maxY)
        let size = CGSize(width: view.bounds.width, height: bottomMenuView.height)
        
        if animated {
            UIView.animate(withDuration: 0.5) {
                self.bottomMenuView.frame = CGRect(origin: origin, size: size)
            }
        } else {
            bottomMenuView.frame = CGRect(origin: origin, size: size)
        }
    }
    
    func set(color: UIColor, to figure: Figure) {
        for view in contentView.subviews {
            guard let view = view as? ViewWithFigureProtocol,
                  view.figure === figure else { continue }
            view.figureColor = color
            view.setNeedsDisplay()
            return
        }
    }
    
}

