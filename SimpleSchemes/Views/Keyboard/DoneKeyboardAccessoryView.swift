//
//  DoneKeyboardAccessoryView.swift
//  IceHockey
//
//  Created by  Buxlan on 11/8/21.
//

import UIKit

protocol DoneKeyboardAccessoryViewDelegate: AnyObject {
    func onDone()
}

class DoneKeyboardAccessoryView: UIView {
    
    // MARK: - Properties
    
    weak var delegate: DoneKeyboardAccessoryViewDelegate?
            
    private lazy var doneButton: UIButton = {
        let width = self.frame.width
        let frame = CGRect(x: width,
                           y: 0,
                           width: 100,
                           height: 44)
        let view = UIButton(frame: frame)
        view.accessibilityIdentifier = "doneButton"
        view.backgroundColor = .systemGray2
        view.tintColor = .systemGray4
        view.setTitle("DONE".localized(), for: .normal)
        view.contentEdgeInsets = .init(top: 4, left: 8, bottom: 4, right: 8)
        view.titleLabel?.font = .systemFont(ofSize: 15)
        view.sizeToFit()
        view.frame = CGRect(x: width - view.frame.width,
                            y: 0,
                            width: view.frame.width,
                            height: 44)
        view.addTarget(self, action: #selector(buttonTapped),
                       for: .touchUpInside)
        return view
    }()
    
    // MARK: - Lifecircle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray2
        self.addSubview(doneButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper methods
    
    @objc private func buttonTapped() {
        delegate?.onDone()
    }
    
}
