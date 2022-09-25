//
//  FileUtil.swift
//  PlayingWithViews
//
//  Created by Sergey Bush bushmakin@outlook.com on 26.09.2022.
//

import UIKit

struct FileUtil {
    
    static func getBlockSchemesDirectory() throws -> URL {
        var documentsDirectory = try FileManager.default.url(for: .documentDirectory,
                                                            in: .userDomainMask,
                                                            appropriateFor: nil,
                                                            create: true)
        
        documentsDirectory.appendPathComponent("simple_schemes")
        documentsDirectory.appendPathComponent("schemes")
        
        if !FileManager.default.fileExists(atPath: documentsDirectory.path) {
            try FileManager.default.createDirectory(at: documentsDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        
        return documentsDirectory
    }
    
    static func getAvailableBlockSchemeFiles() throws -> [String] {
        let dirUrl = try getBlockSchemesDirectory()
        
        let files = try FileManager.default.contentsOfDirectory(atPath: dirUrl.path)
        
        print("Files in directory \(dirUrl) are: \(files)")
        
        return files
    }
    
}
