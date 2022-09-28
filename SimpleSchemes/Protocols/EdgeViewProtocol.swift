//
//  EdgeViewProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import UIKit

protocol EdgeViewProtocol: SelectableView, ViewWithDecorator {
    var edgeType: EdgeTypeProtocol { get set }
    var decorator: EdgeViewDecoratorProtocol { get set }
}
