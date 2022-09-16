//
//  EdgeViewDelegate.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 08.09.2022.
//

import CoreGraphics

protocol EdgeViewDelegate {
    func edgeFrameBeganChanging()
    func didEdgeFrameChanged(_ translation: CGPoint, edgeType: EdgeTypeProtocol)
    
    @available(*, deprecated, renamed: "didEdgeFrameChanged(_:edgeType:)")
    func didEdgeFrameChanged(_ oldFrame: CGRect, _ newFrame: CGRect, edgeType: EdgeTypeProtocol)
}
