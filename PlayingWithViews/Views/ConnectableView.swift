//
//  ConnectableView.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 22.08.2022.
//

import UIKit

protocol ConnectableView: UIView {
    var connectedView: ConnectableView? { get set }
    func connect(to view: ConnectableView)
    func connectedViewFrameDidChanged()
}
