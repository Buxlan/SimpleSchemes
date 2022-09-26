//
//  CanvasListViewController.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

final class CanvasListViewController: UIViewController {
    
    var viewModel = CanvasListViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let size = CGSize(width: 125, height: 125)
        layout.itemSize = size
        layout.estimatedItemSize = size
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(CanvasListCell.self, forCellWithReuseIdentifier: "CanvasListCell")
        view.register(CanvasNewCell.self, forCellWithReuseIdentifier: "CanvasNewCell")
        view.backgroundColor = .white
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("CanvasListViewController viewDidLoad frame = \(view.frame)")
        
        view.backgroundColor = .white
        
        navigationItem.title = "CANVAS_LIST.VC.TITLE".localized()
        
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.loadItems()
        collectionView.reloadData()
        
        print("CanvasListViewController viewWillAppear frame = \(view.frame)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("CanvasListViewController viewWillLayoutSubviews frame = \(view.frame)")
        
        setCollectionViewFrame()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        print("CanvasListViewController viewDidLayoutSubviews frame = \(view.frame)")
    }
    
}

extension CanvasListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.item
        var cell: UICollectionViewCell
        if row < viewModel.items.count {
            let dequeued = collectionView.dequeueReusableCell(withReuseIdentifier: "CanvasListCell", for: indexPath) as! CanvasListCell
            dequeued.configure(viewModel.items[row].name)
            cell = dequeued
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CanvasNewCell", for: indexPath)
        }
        
        return cell
    }
    
    func setCollectionViewFrame() {
        collectionView.frame = view.safeAreaLayoutGuide.layoutFrame
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item
        if row < viewModel.items.count {
            let file = viewModel.items[row]
            if let vc = try? CanvasFactoryImpl().makeExistingCanvas(with: file.name) {
                navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            let vc = CanvasFactoryImpl().makeNewCanvas()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
