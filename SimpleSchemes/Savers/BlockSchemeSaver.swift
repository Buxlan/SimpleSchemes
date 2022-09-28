//
//  BlockSchemeSaver.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import Foundation

struct BlockSchemeSaver: SaverProtocol {
    typealias DataType = BlockScheme
    
    func save(_ object: DataType) throws {
        guard !object.name.isEmpty else {
            throw BlockSchemeSavingError.nameIsEmpty
        }
        
        let encoder = JSONEncoder()
        let data = try encoder.encode(object)
        
        var url = try FileUtil.getBlockSchemesDirectory()
        url.appendPathComponent(object.name)
        url.appendPathExtension("syms")
        
        let fileExists = FileManager.default.fileExists(atPath: url.path)
        
        switch (object.isNew, fileExists) {
        case (true, true):
            // блок схема новая и файл уже существует! Ошибка! Не сохраняем!
            throw BlockSchemeSavingError.alreadyExists
        case (true, false):
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        case (false, true):
            try FileManager.default.removeItem(at: url)
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        case (false, false):
            FileManager.default.createFile(atPath: url.path, contents: data, attributes: nil)
        }
        
        if object.isNew {
            object.isNew = false
        }
    }
    
}
