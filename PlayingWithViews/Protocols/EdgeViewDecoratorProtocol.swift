//
//  EdgeViewDecoratorProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 25.08.2022.
//

import CoreGraphics
import UIKit

protocol EdgeViewDecoratorProtocol: DecoratorProtocol {
    var size: CGSize { get set }
    var borderWidth: CGFloat { get set }
    var borderColor: UIColor { get set }
    var bgColor: UIColor { get set }
}
