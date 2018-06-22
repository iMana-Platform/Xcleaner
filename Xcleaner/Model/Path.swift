//
//  Path.swift
//  Xcleaner
//
//  Created by kingcos on 2018/6/22.
//  Copyright © 2018 kingcos. All rights reserved.
//

import Foundation

struct Path {
    var directory: String
    var size: String
    var isEnabled: Bool
    
    init(directory: String,
         isEnabled: Bool) {
        self.directory = directory
        self.isEnabled = isEnabled
        self.size = "0"
        
        let manager = FileManager.default
        if manager.fileExists(atPath: self.directory) {
            let subpaths = manager.subpaths(atPath: self.directory) ?? []
            let fileSize = subpaths.reduce(0) { (result, subpath) -> UInt64 in
                let absolutePath = self.directory + subpath
                return result + Path.size(absolutePath)
            }
            
            self.size = String(format: "%.2f", Double(fileSize) / 1024 / 1024 / 1024)
        }
    }
    
    static func size(_ path: String) -> UInt64 {
        let manager = FileManager.default
        
        guard let sizeObject = try? manager.attributesOfItem(atPath: path)[FileAttributeKey.size],
            let size = sizeObject as? UInt64 else {
                fatalError()
        }
        
        return size
    }
}
