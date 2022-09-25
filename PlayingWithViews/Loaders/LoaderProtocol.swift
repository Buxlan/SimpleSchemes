//
//  LoaderProtocol.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

protocol LoaderProtocol {
    associatedtype DataType: Decodable
    
    func load(fromFile filename: String) throws -> DataType
}
