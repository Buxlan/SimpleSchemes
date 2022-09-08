//
//  ViewMovementValidator.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 28.08.2022.
//

import UIKit

protocol ViewMovementValidator {
    func validate(view: UIView, at point: CGPoint) -> Bool
}
