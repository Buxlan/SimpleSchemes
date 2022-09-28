//
//  SaverProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

protocol SaverProtocol {
    associatedtype DataType: Codable
    
    func save(_ object: DataType) throws
}
