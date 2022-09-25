//
//  CanvasNewCell.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.09.2022.
//

import UIKit

class CanvasNewCell: UICollectionViewCell {
    
    private let defaultImage = AppImage.docFillBadgePlus.image
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.image = defaultImage
        
        return view
    }()
    
    private let nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 15)
        view.textAlignment = .center
        view.text = "CANVAS_LIST.VC.ADD_NEW_CANVAS.TITLE".localized()
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        setImageViewFrame(in: rect)
        setNameLabelFrame(in: rect)
    }
    
    func setImageViewFrame(in rect: CGRect) {
        let size = CGSize(width: rect.width/2, height: rect.width/2)
        let origin = CGPoint(x: rect.width/4, y: 10)
        
        imageView.frame = CGRect(origin: origin, size: size)
    }
    
    func setNameLabelFrame(in rect: CGRect) {
        let origin = CGPoint(x: 0, y: rect.width/2+10)
        let size = CGSize(width: rect.width, height: rect.height-origin.y)
        
        nameLabel.frame = CGRect(origin: origin, size: size)
    }
    
}
