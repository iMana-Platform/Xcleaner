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
        self.size = "Calculating..."
        
//        Path.calculate(self) { size in
//            self.size = String(format: "%.2f", Double(size) / 1024 / 1024 / 1024)
//            completion()
//        }
        
//        DispatchQueue.global().async {
//            let manager = FileManager.default
//            if manager.fileExists(atPath: directory) {
//                let subpaths = manager.subpaths(atPath: directory) ?? []
//                let fileSize = subpaths.reduce(0) { (result, subpath) -> UInt64 in
//                    let absolutePath = directory + subpath
//                    return result + Path.fileSize(absolutePath)
//                }
//
//                let size = String(format: "%.2f", Double(fileSize) / 1024 / 1024 / 1024)
//
//                // Finished calculating notify
//                NotificationCenter.default.post(name: .CalculatedDirectorySize,
//                                                object: nil,
//                                                userInfo: [Constants.NotificationInfoKey.directorySize : size])
//            }
//        }
        
//        let manager = FileManager.default
//        if manager.fileExists(atPath: self.directory) {
//            let subpaths = manager.subpaths(atPath: self.directory) ?? []
//            let fileSize = subpaths.reduce(0) { (result, subpath) -> UInt64 in
//                let absolutePath = self.directory + subpath
//                return result + Path.size(absolutePath)
//            }
//
//            self.size = String(format: "%.2f", Double(fileSize) / 1024 / 1024 / 1024)
//
//            // Finished calculating notify
//            NotificationCenter.default.post(name: .CalculatedDirectorySize,
//                                            object: nil,
//                                            userInfo: [Constants.NotificationInfoKey.directorySize : self.size])
//        }
    }
    
    static func calculate(_ path: Path, _ completion: @escaping (UInt64) -> Void) {
        var path = path
        
        DispatchQueue.global().async {
            let manager = FileManager.default
            if manager.fileExists(atPath: path.directory) {
                let subpaths = manager.subpaths(atPath: path.directory) ?? []
                let fileSize = subpaths.reduce(0) { (result, subpath) -> UInt64 in
                    let absolutePath = path.directory + subpath
                    return result + Path.fileSize(at: absolutePath)
                }
                
                path.size = String(format: "%.2f", Double(fileSize) / 1024 / 1024 / 1024)
                completion(fileSize)
            }
        }
    }
    
    static func fileSize(at path: String) -> UInt64 {
        guard let sizeObject = try? FileManager.default.attributesOfItem(atPath: path)[FileAttributeKey.size],
            let size = sizeObject as? UInt64 else {
                return 0
        }
        
        return size
    }
    
    static func fileSize(_ path: String) -> UInt64 {
        let manager = FileManager.default
        
        guard let sizeObject = try? manager.attributesOfItem(atPath: path)[FileAttributeKey.size],
            let size = sizeObject as? UInt64 else {
                return 0
        }
        
        return size
    }
}
