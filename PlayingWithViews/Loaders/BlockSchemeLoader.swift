//
//  BlockSchemeLoader.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import Foundation

struct BlockSchemeLoader: LoaderProtocol {
    typealias DataType = BlockScheme
    
    func load(fromFile filename: String) throws -> DataType {
        guard !filename.isEmpty else { throw BlockSchemeLoadingError.nameIsEmpty }
        
        var url = try FileUtil.getBlockSchemesDirectory()
        url.appendPathComponent(filename)
        
        guard FileManager.default.fileExists(atPath: url.path) else {
            throw BlockSchemeLoadingError.fileNotExists
        }
        
        guard let data = FileManager.default.contents(atPath: url.path) else {
            throw BlockSchemeLoadingError.dataIsNil
        }
        
        let decoder = JSONDecoder()
        let object = try decoder.decode(BlockScheme.self, from: data)
        
        return object
    }
    
}
